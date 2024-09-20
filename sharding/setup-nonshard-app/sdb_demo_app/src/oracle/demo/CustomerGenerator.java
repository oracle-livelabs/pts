package oracle.demo;

import oracle.RandomGenerator;

import java.util.Random;

public class CustomerGenerator {
    private final Random rand;
    private Customer customer;

    static final double genderThreshold = 0.5;

    static final RandomGenerator<String> maleNameGen   = RandomGenerator.initStaticGenerator("first-m.txt");
    static final RandomGenerator<String> femaleNameGen = RandomGenerator.initStaticGenerator("first-f.txt");
    static final RandomGenerator<String> lastNameGen   = RandomGenerator.initStaticGenerator("last.txt");

    static final RandomGenerator<String> addrStreet  = RandomGenerator.initStaticUniformGenerator("streets.txt");
    static final RandomGenerator<String> addrCity    = RandomGenerator.initStaticUniformGenerator("us-places.txt");

    static final RandomGenerator<String> addrSuffix = new RandomGenerator<>("Rd", "St", "Ln", "Ave", "Blvd", "Pkwy");
    static final RandomGenerator<String> clsList    = new RandomGenerator<>("free", "silver", "gold");
    static final RandomGenerator<String> geoList    = new RandomGenerator<>("west", "east", "center");

    static final int [] houseMultipliers  = {100, 100, 50, 50, 10, 10, 10, 5, 5, 5, 5, 1};

    public CustomerGenerator(Random rand, Customer customer) {
        this.rand = rand;
        this.customer = customer;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    private int generateHouse()
    {
        return (rand.nextInt(9999) * houseMultipliers[rand.nextInt(houseMultipliers.length)]) % 100000;
    }

    public static String capitalize(String s)
    {
        return s.length() > 0 ? s.substring(0, 1).toUpperCase() + s.substring(1) : s;
    }

    public void generateName()
    {
        if (rand.nextDouble() > genderThreshold) {
            customer.gender = 'M';
            customer.firstName = maleNameGen.getW(rand.nextDouble());
        } else {
            customer.gender = 'F';
            customer.firstName = femaleNameGen.getW(rand.nextDouble());
        }

        customer.lastName = lastNameGen.getW(rand.nextDouble());
        customer.email = customer.firstName + "." + customer.lastName + "@x.bogus";

        customer.firstName = capitalize(customer.firstName);
        customer.lastName  = capitalize(customer.lastName);
    }

    private String generateAddress()
    {
        return String.format("%d %s %s, %s", generateHouse(),
                addrStreet.getI(rand), addrSuffix.getI(rand), addrCity.getI(rand));
    }

    public void generateData()
    {
        customer.age = (int) Math.round(Math.abs(rand.nextGaussian() * 20 + 10) + 18);
        customer.cls = clsList.getG(rand, 1);
        customer.geo = geoList.getI(rand);

        do {
            customer.addressList.add(generateAddress());
        } while (rand.nextDouble() > 0.8);
    }

}
