package oracle.demo;

import oracle.JsonSerializer;
import oracle.Utils;

import javax.script.ScriptEngineManager;
import java.util.ArrayList;
import java.util.List;

public class Customer
{
    public byte[] tmpPassword = null;

    public char gender;
    public String firstName;
    public String lastName;
    public String email;
    public String cls;
    public String geo;
    public String jsonData;

    public boolean exists = false;

    public Integer age;
    public List<String> addressList = new ArrayList<>();

    public Customer() { }

    public Customer(String id, byte [] password) {
        this.email = id;
        this.tmpPassword = password;
    }

    public static final String [] addressNames = {"billing", "mailing", "delivery"};

    public String getJsonProfile()
    {
        JsonSerializer json = new JsonSerializer();

        json.put("firstname", firstName);
        json.put("lastname", lastName);
        json.putI("age", age);
        json.put("gender", Character.toString(gender));
        json.begin("addresses");

        if (addressList.size() > 3)
        {
            json.put(addressNames[0], addressList.get(0));
            json.put(addressNames[1], addressList.get(1));
            json.putAsString("delivery", addressList.subList(2, addressList.size()));
        }
        else
        {
            for (int i = 0; i < addressList.size(); ++i)
            {
                json.put(addressNames[i], addressList.get(i));
            }
        }

        json.end();

        return jsonData = json.close().toString();
    }

    @Override
    public String toString() {
        return String.format("%s %s %s %d [%s]", email, firstName, lastName, age,
                Utils.join("; ", addressList.iterator(), Object::toString));
    }

    public void setJsonData(String json)
    {
        this.jsonData = json;
    }
}
