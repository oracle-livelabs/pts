package oracle.demo;

import java.util.concurrent.atomic.AtomicIntegerArray;
import java.util.concurrent.atomic.AtomicReference;

public class Statistics
{
    AtomicIntegerArray counters = new AtomicIntegerArray(64);

    static final int COUNTER_CUSTOMER_INSERT  = 0;
    static final int COUNTER_ORDER_INSERT     = 1;
    static final int COUNTER_CUSTOMER_FOUND   = 2;
    public static final int COUNTER_TXN_TOTAL = 3;
    public static final int COUNTER_RO_TOTAL  = 4;

    private static final int COUNTER_SUCCESS_LIMIT = 9;

    public static final int COUNTER_RO_FAILED  = 10;
    static final int COUNTER_FAILED_LISTENER   = 11;
    static final int COUNTER_FAILED_READONLY   = 12; /* Transaction failed because of chunk OR partition readonly */
    static final int COUNTER_FAILED_OTHER      = 13;
    public static final int COUNTER_TXN_FAILED = 14;
    static final int COUNTER_FAILED_SQL_TOTAL  = 15;

    private static final int COUNTER_FAILED_LIMIT = 19;

    static final int COUNTER_JOBS_CREATED = 20;

    public void bump(int counter) { counters.incrementAndGet(counter); };

    int  oldJobCount = 0;
    long oldMs = System.currentTimeMillis();
    int  lines = 0;

    public void debug()
    {
        int jobCount = counters.get(COUNTER_JOBS_CREATED);
        long ms = System.currentTimeMillis();

        if (lines % 20 == 0) {
            System.out.println(" RO Queries | RW Queries | RO Failed  | RW Failed  | APS ");
        }

        ++lines;

        System.out.println(String.format(" %10d   %10d   %10d   %10d   %10d",
                counters.get(COUNTER_RO_TOTAL),
                counters.get(COUNTER_TXN_TOTAL),
                counters.get(COUNTER_RO_FAILED),
                counters.get(COUNTER_TXN_FAILED),
                (int) ((double) (jobCount - oldJobCount) * 1000 / (ms - oldMs))));

        oldJobCount = jobCount;
        oldMs = ms;
    }
}
