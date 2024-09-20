package oracle;

import oracle.jdbc.OraclePreparedStatement;

import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.util.function.BiConsumer;
import java.util.function.Consumer;
import java.util.function.Function;

public class Utils {

    public static class ArrayIterator<T> implements Iterator<T>
    {
        int i = 0, end;
        final T[] array;

        public ArrayIterator(T[] array) {
            this.array = array;
            this.end = array.length;
        }

        public ArrayIterator(T[] array, int start, int end) {
            this.i = start;
            this.end = end;
            this.array = array;
        }

        @Override
        public boolean hasNext() {
            return i < end;
        }

        @Override
        public T next() {
            return array[i++];
        }
    }

    public interface StringTransformer { String get(Object x); }

    public static StringBuilder join(StringBuilder builder, String glue,
                                     Iterator<?> it, StringTransformer transformer)
    {
        while (it.hasNext())
        {
            Object x = it.next();
            builder.append(transformer.get(x));
            if (it.hasNext()) { builder.append(glue); }
        }

        return builder;
    }

    public static String join(String glue, Iterator<?> it, StringTransformer transformer)
    {
        return join(new StringBuilder(), glue, it, transformer).toString();
    }

    public static class DefaultStringTransformer implements StringTransformer
    {
        public String get(Object x) { return x.toString(); }
    }

    public static void cleanArray(byte[] a)
    {
        for (int i = 0; i < a.length; ++i) { a[i] = 0; }
    }

    public static boolean checkBatchResult(int[] result) {
        return Arrays.stream(result).allMatch(value -> value >= 0);
    }

    @FunctionalInterface
    public interface BindParameterFunction {
        void accept(PreparedStatement statement, int i, Object x) throws SQLException;
    }

    private static final Map<Class, BindParameterFunction > typeMap = new HashMap<>();

    static
    {
        typeMap.put(String.class,      (statement, i, x) -> { statement.setString(i, (String) x); });
        typeMap.put(Integer.class,     (statement, i, x) -> { statement.setInt(i, (Integer) x); });
        typeMap.put(BigDecimal.class,  (statement, i, x) -> { statement.setBigDecimal(i, (BigDecimal) x); });
        typeMap.put(Double.class,      (statement, i, x) -> { statement.setDouble(i, (Double) x); });
        typeMap.put(Float.class,       (statement, i, x) -> { statement.setFloat(i, (Float) x); });
        typeMap.put(Calendar.class,    (statement, i, x) -> { statement.setTimestamp(i, new java.sql.Timestamp(((Calendar) x).getTimeInMillis())); });
        typeMap.put(Date.class,        (statement, i, x) -> { statement.setDate(i, (Date) x); });
        typeMap.put(Boolean.class,     (statement, i, x) -> { statement.setBoolean(i, (Boolean) x); });
        typeMap.put(Reader.class,      (statement, i, x) -> { statement.setClob(i, (Reader) x); });
        typeMap.put(InputStream.class, (statement, i, x) -> { statement.setBlob(i, (InputStream) x); });
        typeMap.put(byte[].class,      (statement, i, x) -> { statement.setBytes(i, (byte[]) x); });
        typeMap.put(Object.class,      PreparedStatement::setObject );
    }

    public static long[] getGeneratedId(OraclePreparedStatement statement, int count) throws SQLException
    {
        long[] result = new long[count];
        int i = 0;

        try (ResultSet keys = statement.getReturnResultSet())
        {
            while (keys.next() && i < count) {
                result[i++] = keys.getInt(1);
            }
        }

        return result;
    }

    public static PreparedStatement setBinds(PreparedStatement statement, Object ... values) throws SQLException
    {
        int i = 1;

        for (Object x : values)
        {
            if (x == null) {
                statement.setNull(i, Types.NULL);
            } else {
                Class cls = x.getClass();
                BindParameterFunction f = typeMap.get(cls);

                /* should ALWAYS succeed since the map has Object */
                while (f == null && cls != null) { f = typeMap.get(cls = cls.getSuperclass()); };

                if (f == null) { throw new SQLException("Bind function not found"); }

                f.accept(statement, i, x);
            }

            ++i;
        }

        return statement;
    }
}
