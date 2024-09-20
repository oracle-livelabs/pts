package oracle.demo;

import oracle.ArgParser;
import oracle.demo.actions.AddProducts;
import oracle.demo.actions.CreateOrder;
import oracle.demo.actions.GenerateReport;
import oracle.demo.actions.OrderLookup;

import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.*;

public class Main implements Runnable
{
    final public Application app;
    int threadCount = 4;

    public Main(ArgParser args)
    {
        Properties properties = args.propertyFiles.get(0);

        if (args.propertyFiles.size() == 0) { throw new RuntimeException("No configuration given"); }

        this.app = new Application(properties);
        this.threadCount = Integer.parseInt(properties.getProperty("app.threads", "4"));
    }

    public void fillProducts()
    {
        try {
            Product.initialFill(app);
        } catch (ApplicationException e) {
            throw new RuntimeException(e);
        }
    }

    private class ExceptionCatchingThreadFactory implements ThreadFactory
    {
        private final ThreadFactory delegate;

        private ExceptionCatchingThreadFactory(ThreadFactory delegate) {
            this.delegate = delegate;
        }

        public Thread newThread(final Runnable worker) {
            Thread t = delegate.newThread(worker);
            t.setDaemon(true);
            t.setUncaughtExceptionHandler((t1, e) -> { app.reportUnhandledException(e); });
            return t;
        }
    }

    public void run()
    {
        // First, check that connection works

        try {
            app.getXShard().close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        fillProducts();

        Actor.actions.addWeigthedItem(CreateOrder.class,     20);
        Actor.actions.addWeigthedItem(OrderLookup.class,     80);
//        Actor.actions.addWeigthedItem(GenerateReport.class,  0.1);
//        Actor.actions.addWeigthedItem(AddProducts.class,     0.01);
        Actor.actions.normalizeWeights();

        InfiniteGeneratingQueue queue = new InfiniteGeneratingQueue(() -> new Actor(app));

        ThreadPoolExecutor executor   = new ThreadPoolExecutor(threadCount, threadCount,
                10, TimeUnit.SECONDS, queue,
                new ExceptionCatchingThreadFactory(Executors.defaultThreadFactory()));

        executor.prestartAllCoreThreads();

        try {
            /* Five hours maximum run */
            for (int i = 0; i < 60*60*5; ++i) {
                Thread.sleep(1000);
                app.stats.debug();
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        queue.stop();
        executor.shutdown();
    }

    public static void main(String[] args) { new Main(new ArgParser(args)).run(); }

}
