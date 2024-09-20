package oracle;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.logging.LogRecord;

public class SmartLogFormatter extends java.util.logging.Formatter
{
    public static String logPlaceIdentifier(LogRecord record)
    {
        return String.format("%s.%s",
                record.getSourceClassName() != null  ? record.getSourceClassName() : record.getLoggerName(),
                record.getSourceMethodName() != null ? record.getSourceMethodName() : "<unknown>");
    }

    private static final DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S");

    @Override
    public String format(LogRecord record)
    {
        String placeIdentifier = logPlaceIdentifier(record);
        String result = "@" + placeIdentifier + " : ";

        Throwable error = record.getThrown();

        if (error != null) {
            result += String.format("%s : %s", error.getClass().getName(), error.getMessage());
        } else {
            result += String.format("%s %s : %s", record.getLevel().getName(),
                    df.format(new Date(record.getMillis())), formatMessage(record));
        }

        if (!result.endsWith("\n")) { result = result + "\n"; }

        return result;
    }
}
