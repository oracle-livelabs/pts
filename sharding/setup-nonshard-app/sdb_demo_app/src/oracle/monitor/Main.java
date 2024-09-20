package oracle.monitor;

import com.sun.net.httpserver.HttpServer;
import oracle.ArgParser;

import java.io.FileReader;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.logging.Logger;

public class Main implements Runnable
{
    Logger logger = Logger.getGlobal();

    public static void main(String[] args) { new Main(new ArgParser(args)).run(); }

    public Main(ArgParser args)
    {
        try {
            server = HttpServer.create();
            server.createContext("/", FileHandler.monitorFiles);

            for (Properties x : args.propertyFiles) {
                registerDatabase(x);

                if (x.containsKey("monitor.bind")) {
                    String bind = x.getProperty("monitor.bind");
                    int i = bind.indexOf(':');

                    if (i != -1) {
                        String host = bind.substring(0, i);
                        int port = Integer.parseInt(bind.substring(i + 1));

                        if (host.isEmpty()) {
                            logger.info(String.format("Listening on :%d", port));
                            server.bind(new InetSocketAddress(port), 16);
                        } else {
                            logger.info(String.format("Listening on %s:%d", host, port));
                            server.bind(new InetSocketAddress(host, port), 16);
                        }
                    }
                } else {
                    server.bind(new InetSocketAddress(8081), 16);
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private final Map<String, DatabaseMonitor> monitorList = new HashMap<>();
    private HttpServer server;
    ScheduledExecutorService executorService = Executors.newScheduledThreadPool(1);

    public void registerDatabase(Properties db)
    {
        String name = db.getProperty("name");
        FileHandler.databaseName = name;
        DatabaseMonitor dbmon = new DatabaseMonitor(db, executorService);
        monitorList.put(name, dbmon);
        String ctx = "/db/" + name + "/info";
        server.createContext(ctx, dbmon.getInfoHandler());
        logger.info("Context : " + ctx);
    }

    public void run() {
        server.start();
    }
}
