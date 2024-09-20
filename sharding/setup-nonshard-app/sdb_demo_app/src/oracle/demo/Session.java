package oracle.demo;

import oracle.RandomGenerator;
import oracle.Utils;
import oracle.jdbc.OraclePreparedStatement;

import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import java.util.function.Consumer;

public class Session
{
    private final Customer customer;
    private final Application app;

    private Calendar orderDate = null;
    private final Map<Long, ItemDef> pendingItems = new TreeMap<>();

    private int orderId;

    public Session(Customer customer, Application application) {
        this.customer = customer;
        this.app = application;
    }

    public class ItemDef
    {
        long itemId;
        BigDecimal qty;
        BigDecimal price;

        public ItemDef(long itemId, Random rand) {
            this.itemId = itemId;
            this.qty    = RandomGenerator.generateQty(rand);
            this.price  = RandomGenerator.generatePrice(rand);
        }

        public ItemDef(long itemId, BigDecimal price, BigDecimal qty) {
            this.itemId = itemId;
            this.qty    = qty;
            this.price  = price;
        }
    }

    public void order()
    {
        orderDate = Calendar.getInstance();
    }

    public void item(ItemDef item)
    {
        if (item != null) {
            if (pendingItems.containsKey(item.itemId)) {
                BigDecimal qty = pendingItems.get(item.itemId).qty;
                qty = qty.add(item.qty);
                pendingItems.get(item.itemId).qty = qty;
            } else {
                pendingItems.put(item.itemId, item);
            }
        }
    }

    private static final String selectCustomerStatement =
            "SELECT CustId, FirstName, LastName, CustProfile FROM Customers " +
                    "WHERE CustId=:p1 AND PasswCheck(:p2, Passwd) = 0";

    /**
     * Fetch customer information
     *
     * @return \true if customer have been found, \false otherwise
     */
    public boolean getCustomerInfo(byte[] password) throws ApplicationException
    {
        try (Connection trn = app.getReadonly(customer))
        {
            try (PreparedStatement statement = trn.prepareStatement(selectCustomerStatement))
            {
                Utils.setBinds(statement, customer.email, password);

                try (ResultSet resultSet = statement.executeQuery())
                {
                    if (resultSet.next())
                    {
                        customer.setJsonData(resultSet.getString(4));
                        customer.exists = true;
                        app.stats.bump(Statistics.COUNTER_CUSTOMER_FOUND);
                        return true;
                    }
                }
            }

            app.stats.bump(Statistics.COUNTER_RO_TOTAL);
        }
        catch (SQLException e)
        {
            app.stats.bump(Statistics.COUNTER_RO_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to find customer");
        }

        return false;
    }

    private static final String customerLookupStatement =
            "SELECT CustId, Class, Geo FROM Customers " +
                    "WHERE CustId=:p1 ";

    public boolean customerLookup() throws ApplicationException
    {
        try (Connection conn = app.getReadonly(customer))
        {
            try (PreparedStatement statement = conn.prepareStatement(customerLookupStatement))
            {
                Utils.setBinds(statement, customer.email);

                try (ResultSet resultSet = statement.executeQuery())
                {
                    if (resultSet.next())
                    {
                        app.stats.bump(Statistics.COUNTER_CUSTOMER_FOUND);
                        return true;
                    }
                }
            }

            app.stats.bump(Statistics.COUNTER_RO_TOTAL);
        }
        catch (SQLException e)
        {
            app.stats.bump(Statistics.COUNTER_RO_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to look up customer");
        }

        return false;
    }

    private static final String insertCustomerStatement =
            "INSERT INTO Customers (CustId, FirstName, LastName, CustProfile, Class, Geo, Passwd) " +
                          " VALUES (:p1,    :p2,       :p3,      :p4,         :p5,   :p6, PASSWCREATE(:p7))";

    public void createCustomer(byte[] password) throws ApplicationException
    {
        try (Connection trn = app.getTransaction(customer))
        {
            try (PreparedStatement statement = trn.prepareStatement(insertCustomerStatement))
            {
                Utils.setBinds(statement,
                        customer.email,
                        customer.firstName,
                        customer.lastName,
                        customer.getJsonProfile(),
                        customer.cls,
                        customer.geo,
                        password);

                if (statement.executeUpdate() == 0)
                {
                    app.stats.bump(Statistics.COUNTER_TXN_FAILED);
                    throw new ApplicationException("Failed to add customer");
                }

                customer.exists = true;
            }

            trn.commit();

            app.stats.bump(Statistics.COUNTER_CUSTOMER_INSERT);
            app.stats.bump(Statistics.COUNTER_TXN_TOTAL);
        }
        catch (SQLException e)
        {
            app.stats.bump(Statistics.COUNTER_TXN_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to add customer");
        }
    }

    private static final String insertOrderStatement =
        "INSERT INTO Orders(CustId, OrderId, OrderDate, Status, SumTotal) " +
          " VALUES (:p1, Orders_Seq.NEXTVAL, :p2, 'PRE', :p3) RETURNING ORDERID INTO :p4";
/*
    private static final String finalizeOrderStatement =
        "UPDATE Orders T1" +
        "  SET Status = 'SENT', SumTotal = (SELECT sum(Price*Qty) " +
        "    FROM LineItems T2 WHERE T1.CustId = T2.CustId AND T1.OrderId = T2.OrderId)" +
        "  WHERE CustId=:p1 AND OrderId=:p2";
*/
    private static final String insertItemStatement =
        "INSERT INTO LineItems(CustId, OrderId, ProductId, Price, Qty) VALUES (:p1, :p2, :p3, :p4, :p5)";

    public void submit() throws ApplicationException
    {
        try (Connection trn = app.getTransaction(customer))
        {
            BigDecimal sum = BigDecimal.ZERO;

            for (ItemDef item : pendingItems.values()) {
                sum = sum.add(item.price.multiply(item.qty));
            }

            try (OraclePreparedStatement statement = (OraclePreparedStatement) trn.prepareStatement(insertOrderStatement))
            {
                Utils.setBinds(statement, customer.email, orderDate, sum);
                statement.registerReturnParameter(4, Types.INTEGER);

                if (statement.executeUpdate() != 1) {
                    throw new ApplicationException("Unexpected order creation result");
                }

                orderId = (int) Utils.getGeneratedId(statement, 1)[0];
            }

            try (PreparedStatement statement = trn.prepareStatement(insertItemStatement))
            {
                for (ItemDef item : pendingItems.values())
                {
                    Utils.setBinds(statement,
                            customer.email,
                            orderId,
                            item.itemId,
                            item.price,
                            item.qty)
                        .addBatch();
                }

                int [] result = statement.executeBatch();

                if (!Utils.checkBatchResult(result)) {
                    throw new ApplicationException("Failed to add one or more order lines");
                }
            }
/*
            try (PreparedStatement statement = trn.prepareStatement(finalizeOrderStatement))
            {
                Utils.setBinds(statement, customer.email, orderId);

                if (statement.executeUpdate() != 1) {
                    throw new ApplicationException("Unexpected order creation result");
                }
            }
*/
            trn.commit();

            app.stats.bump(Statistics.COUNTER_ORDER_INSERT);
            app.stats.bump(Statistics.COUNTER_TXN_TOTAL);
        }
        catch (SQLException e)
        {
            app.stats.bump(Statistics.COUNTER_TXN_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Order creation failed");
        }
    }

    private static final String selectProductStatement =
            "SELECT ProductId, LastPrice FROM Products SAMPLE (1) ORDER BY DBMS_RANDOM.VALUE";

    public ItemDef selectRandomProducts(Random rand) throws ApplicationException
    {
        try (Connection conn = app.getReadonly(customer))
        {
            try (PreparedStatement statement = conn.prepareStatement(selectProductStatement))
            {
                try (ResultSet resultSet = statement.executeQuery())
                {
                    ItemDef item = null;

                    if (resultSet.next())
                    {
                        item = new ItemDef(resultSet.getLong(1),
                                resultSet.getBigDecimal(2), RandomGenerator.generateQty(rand));
                    }

                    app.stats.bump(Statistics.COUNTER_RO_TOTAL);

                    return item;
                }
            }
        }
        catch (SQLException e)
        {
            app.stats.bump(Statistics.COUNTER_RO_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Product lookup failed");
        }
    }

    private static final String viewOrderStatement =
            "SELECT OrderDate, OrderId, Status FROM Orders WHERE CustId = :p1";

    public void getOrders(Consumer<ResultSet> onOrder) throws ApplicationException
    {
        try (Connection conn = app.getReadonly(customer))
        {
            try (PreparedStatement statement = conn.prepareStatement(viewOrderStatement))
            {
                Utils.setBinds(statement, customer.email);

                try (ResultSet resultSet = statement.executeQuery())
                {
                    while (resultSet.next())
                    {
                        onOrder.accept(resultSet);
                    }
                }
            }

            app.stats.bump(Statistics.COUNTER_RO_TOTAL);
        }
        catch (SQLException e)
        {
            app.stats.bump(Statistics.COUNTER_RO_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Order lookup failed");
        }
    }

}
