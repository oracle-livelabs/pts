package oracle.demo.actions;

import oracle.RandomGenerator;
import oracle.Utils;
import oracle.demo.Actor;
import oracle.demo.ApplicationException;
import oracle.demo.Statistics;

import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GenerateReport extends Actor.Action
{
    static final String productReportQuery =
            "SELECT ProductId Id, P.Name, P.DescrUri, sum(L.Qty) totalQty, sum(L.Qty * L.Price) totalSum " +
            "  FROM Products P natural join " +
            "    LineItems L join Orders R on (R.CustId = L.CustId AND R.OrderId = L.OrderId) " +
            "  WHERE R.Status = 'SENT' GROUP BY ProductId, P.Name, P.DescrUri ORDER BY totalQty Desc";

    static final String customerReportQuery =
        "SELECT C.FirstName, C.LastName, CustId, count(R.OrderId), sum(R.SumTotal) totalSum FROM "+
            "  CUSTOMERS C NATURAL JOIN ORDERS R "+
            "  WHERE R.Status = 'SENT' "+
            "  GROUP BY CustId, C.FirstName, C.LastName ORDER BY totalSum Desc";

    @Override
    public void run() throws ApplicationException
    {
        long t0, t1;

        try (Connection catalogConnection = app.getXShard())
        {
            OutputStreamWriter writer = new FileWriter("/tmp/report-" + Long.toString(System.currentTimeMillis()) + ".html");

            writer.write("<html><head>");
            writer.write(reportHeader);
            writer.write("</head>");

            t0 = System.currentTimeMillis();

            try (PreparedStatement statement = catalogConnection.prepareStatement(productReportQuery))
            {
                try (ResultSet resultSet = statement.executeQuery())
                {
                    writer.write("<h1>Products by the Number Sold</h1>");
                    writer.write("<table><tr><th>Product Name</th><th>Items Sold</th><th>Volume</th></tr>\n");

                    while (resultSet.next())
                    {
                        String name = resultSet.getString(2);
                        String desc = resultSet.getString(3);

                        if (desc != null && !desc.isEmpty()) { name = String.format("<a href='%s'>%s</a>", desc, name); }

                        writer.write(String.format("<tr><td>%s</td><td>%.0f</td><td style='text-align:right;'>%.2f</td></tr>\n",
                                name, resultSet.getDouble(4), resultSet.getDouble(5)));
                    }

                    writer.write("</table>");
                }

            }

            t1 = System.currentTimeMillis();
            writer.write(String.format("<p>Generated in %.3f seconds</p>", (double) (t1 - t0) / 1000));

            t0 = System.currentTimeMillis();

            try (PreparedStatement statement = catalogConnection.prepareStatement(customerReportQuery))
            {
                try (ResultSet resultSet = statement.executeQuery()) {
                    writer.write("<h1>Customers by Total Transaction Volume (in Dollars)</h1>");

                    writer.write("<table><tr><th>Name</th><th>Id</th><th>Items Sold</th><th>Volume</th></tr>\n");

                    while (resultSet.next())
                    {
                        writer.write(String.format("<tr><td>%s %s</td><td>%s</td><td>%.0f</td><td style='text-align:right;'>%.2f</td></tr>\n",
                                resultSet.getString(1), resultSet.getString(2), resultSet.getString(3),
                                    resultSet.getDouble(4), resultSet.getDouble(5)));
                    }

                    writer.write("</table>");
                }
            }

            t1 = System.currentTimeMillis();
            writer.write(String.format("<p>Generated in %.3f seconds</p>", (double) (t1 - t0) / 1000));

            writer.write("</html>");
            writer.close();

            app.stats.bump(Statistics.COUNTER_RO_TOTAL);
        } catch (SQLException e) {
            app.stats.bump(Statistics.COUNTER_RO_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to generate report");
        } catch (IOException e) {
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to generate report");
        }
    }

    static final String reportHeader = "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=US-ASCII\">\n" +
            "<meta name=\"generator\" content=\"SQL*Plus 12.1.0\">\n" +
            "<style type='text/css'> \n" +
            "  body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} \n" +
            "  p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} \n" +
            "  table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black; background:#f7f7e7; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px; border-coll\n" +
            "  th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; border-bottom:1px solid black;} \n" +
            "  td {padding:2px; border: #cccc99 1px solid; }\n" +
            "  th {padding:2px;}\n" +
            "  h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; border-bottom:1px solid #cccc99; margin-top:0pt; margin-\n" +
            "  h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} \n" +
            "  a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}\n" +
            "</style>\n" +
            "<title>SQL*Plus Report</title>";

}
