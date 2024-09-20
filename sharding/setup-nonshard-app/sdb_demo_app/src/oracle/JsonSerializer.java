package oracle;

import java.util.Stack;

public class JsonSerializer
{
    private final StringBuilder builder;

    private class ScopeStack
    {
        public ScopeStack(char closeParen) {
            this.closeParen = closeParen;
        }

        boolean empty = true;
        char separator = ',';
        char closeParen;
    }

    private final Stack<ScopeStack> modes = new Stack<>();

    static String enquote(String in)
    {
        return "\"" + in.replaceAll("\"", "\\\"") + "\"";
    }

    public JsonSerializer()
    {
        this(new StringBuilder());
    }

    public JsonSerializer(StringBuilder builder) {
        this.builder = builder;
        builder.append("{");
        modes.push(new ScopeStack('}'));
    }

    public StringBuilder close()
    {
        while (!modes.empty())
        {
            builder.append(modes.pop().closeParen);
        }

        return builder;
    }

    private JsonSerializer key(String key)
    {
        if (key != null) {
            builder.append(enquote(key)).append(":");
        }

        return this;
    }

    public JsonSerializer put(String key, String avalue)
    {
        return checkSeparator().key(key).value(avalue);
    }

    public JsonSerializer putI(String key, long value)
    {
        return checkSeparator().key(key).valueI(value);
    }

    public JsonSerializer putF(String key, double value)
    {
        return checkSeparator().key(key).valueF(value);
    }

    public JsonSerializer put(String avalue)
    {
        return checkSeparator().value(avalue);
    }

    public JsonSerializer putI(long value)
    {
        return checkSeparator().valueI(value);
    }

    public JsonSerializer putF(double value)
    {
        return checkSeparator().valueF(value);
    }

    private JsonSerializer checkSeparator()
    {
        if (modes.peek().empty) {
            modes.peek().empty = false;
        } else {
            builder.append(modes.peek().separator);
        }

        return this;
    }

    private JsonSerializer value(String value)
    {
        builder.append(enquote(value == null ? "" : value));
        return this;
    }

    private JsonSerializer valueI(long value)
    {
        builder.append(value);
        return this;
    }

    private JsonSerializer valueF(double value)
    {
        builder.append(value);
        return this;
    }

    public JsonSerializer begin(String key)
    {
        checkSeparator();
        builder.append(enquote(key)).append(":{");
        modes.push(new ScopeStack('}'));
        return this;
    }

    public JsonSerializer begin() {
        checkSeparator();
        builder.append("{");
        modes.push(new ScopeStack('}'));
        return this;
    }

    public JsonSerializer array(String key)
    {
        checkSeparator();
        builder.append(enquote(key)).append(":[");
        modes.push(new ScopeStack(']'));
        return this;
    }

    public JsonSerializer array()
    {
        checkSeparator();
        builder.append("[");
        modes.push(new ScopeStack(']'));
        return this;
    }

    public JsonSerializer end()
    {
        builder.append(modes.pop().closeParen);
        return this;
    }

    public JsonSerializer put(String key, JsonSerializer avalue)
    {
        return checkSeparator().key(key).jsonValue(avalue);
    }

    private JsonSerializer jsonValue(JsonSerializer avalue)
    {
        builder.append(avalue.close());
        return this;
    }

    public JsonSerializer putAsIs(String key, Iterable<? extends Object> value)
    {
        checkSeparator().key(key);
        Utils.join(builder.append("["), ",", value.iterator(), Object::toString).append("]");
        return this;
    }

    public JsonSerializer putAsDouble(String key, Iterable<Double> value)
    {
        checkSeparator().key(key);
        Utils.join(builder.append("["), ",", value.iterator(), x -> Double.toString((Double) x)).append("]");
        return this;
    }

    public JsonSerializer putAsDoubleArray(String key, double [] value)
    {
        array(key);
        for (double x : value) { putF(x); }
        return end();
    }

    public JsonSerializer putAsIntArray(String key, int [] value)
    {
        array(key);
        for (int x : value) { putI(x); }
        return end();
    }

    public JsonSerializer putAsString(String key, Iterable<? extends Object> value)
    {
        checkSeparator().key(key);
        Utils.join(builder.append("["), ",", value.iterator(), x -> enquote(x.toString())).append("]");
        return this;
    }
}
