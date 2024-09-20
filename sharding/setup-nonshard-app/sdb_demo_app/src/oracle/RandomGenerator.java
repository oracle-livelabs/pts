package oracle;

import java.io.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class RandomGenerator<T> {

    public static BigDecimal generatePrice(Random rand)
    {
        int base = ((1 + rand.nextInt(100)) * 100 - 5);
        int expo = rand.nextInt(3);

        return BigDecimal.valueOf(base).scaleByPowerOfTen(expo);
    }

    public static BigDecimal generateQty(Random rand)
    {
        return BigDecimal.ONE.add(
                BigDecimal.valueOf(Math.floor(Math.abs(rand.nextGaussian()))));
    }


    public static class Item<T> implements Comparable<Double>
    {
        double prob;
        double pMark;

        T value;

        public T getValue() {
            return value;
        }

        private Item(double prob, double pMark, T value) {
            this.prob = prob;
            this.pMark = pMark;
            this.value = value;
        }

        @Override
        public int compareTo(Double o) { return - o.compareTo(pMark); }

        @Override
        public String toString() {
            return String.format("%.6f %s", pMark, value.toString());
        }
    }

    private final List<Item<T>> items = new ArrayList<>();

    public Iterable<Item<T>> getItems() { return items; };

    public static BufferedReader getResource(String resource) {
        try {
            File tryFileFirst = new File("./data/" + resource);

            if (tryFileFirst.isFile())
            {
                return new BufferedReader(new FileReader(tryFileFirst));
            }
            else
            {
                InputStream resourceStream = RandomGenerator.class.getResourceAsStream("/data/" + resource);

                if (resourceStream == null)
                {
                    throw new FileNotFoundException(resource);
                }

                return new BufferedReader(new InputStreamReader(resourceStream));
            }

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static RandomGenerator<String> initStaticGenerator(String dataFile)
    {
        try {
            return RandomGenerator.initByDistribution(getResource(dataFile));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static RandomGenerator<String> initStaticUniformGenerator(String dataFile)
    {
        try {
            return RandomGenerator.initUniform(getResource(dataFile));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static RandomGenerator<String> initByDistribution(BufferedReader reader)
            throws IOException
    {
        RandomGenerator<String> result = new RandomGenerator<>();

        String line;
        double total = 0.0;

        while (null != (line = reader.readLine()))
        {
            String[] data = line.split("\\s+");
            double p = Double.parseDouble(data[1]) / 100;
            total += p;
            result.items.add(new Item<String>(p, total, data[0].toLowerCase()));
        }

        final double finalTotal = total;

        /* Normalize */
        result.items.forEach(item -> item.pMark /= finalTotal);

        return result;
    }

    public void addWeigthedItem(T item, double weight)
    {
        items.add(new Item<T>(weight, 0, item));
    }

    public void normalizeWeights()
    {
        double total = 0.0;

        for (Item<T> i : items) {
            total += i.prob;
            i.pMark = total;
        }

        final double finalTotal = total;

        /* Normalize */
        items.forEach(item -> item.pMark /= finalTotal);
    }

    public RandomGenerator() { }

    @SafeVarargs
    public RandomGenerator(T ... list)
    {
        double total = 0.0;

        for (T i : list) {
            total += 1.0;
            items.add(new Item<T>(1.0, total, i));
        }

        final double finalTotal = total;

        /* Normalize */
        items.forEach(item -> item.pMark /= finalTotal);
    }

    public static RandomGenerator<String> initUniform(BufferedReader reader)
            throws IOException
    {
        RandomGenerator<String> result = new RandomGenerator<>();

        String line;
        double total = 0.0;

        while (null != (line = reader.readLine()))
        {
            total += 1.0;
            result.items.add(new Item<String>(1.0, total, line));
        }

        final double finalTotal = total;

        /* Normalize */
        result.items.forEach(item -> item.pMark /= finalTotal);

        return result;
    }

    public T getW(double p)
    {
        int i = Collections.binarySearch(items, p);
        return items.get(Math.min(i < 0 ? (-i - 1) : i, items.size() - 1)).value;
    }

    public T getI(Random rand)
    {
        return items.get(rand.nextInt(items.size())).value;
    }

    public T getG(Random rand, double sigma)
    {
        return items.get(Math.min((int) Math.floor(Math.abs(rand.nextGaussian() * sigma)), items.size() - 1)).value;
    }

    public void debug()
    {
        items.forEach(item -> { System.out.println(item.toString()); });
    }
}
