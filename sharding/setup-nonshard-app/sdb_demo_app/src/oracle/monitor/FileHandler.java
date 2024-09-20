package oracle.monitor;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;

import java.io.*;
import java.net.URI;
import java.util.Arrays;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Logger;

public class FileHandler implements HttpHandler
{
    private String[] defaultFiles = null;

    public static final FileHandler monitorFiles = new FileHandler();

    private static String [] webFiles = new String[] {
            "/bootstrap.js",
            "/bootstrap.css",
            "/bootstrap-theme.css",
            "/Chart.js",
            "/Chart.HorizontalBar.js",
            "/DatabaseWidgets.js",
            "/jquery-2.1.4.js",
            "/masonry.pkgd.js",
            "/npm.js",
            "/db.svg",
    };

    public void setDefault(String[] aDefault) {
        this.defaultFiles = aDefault;
    }

    public static String databaseName = "demo";

    public static class SetupContent implements ContentGenerator
    {
        @Override
        public InputStream getContent(URI uri) throws IOException
        {
            return new ByteArrayInputStream(
                    String.format("DatabaseSetup = function () { " +
                            " this.url = '/db/%s/info'; }", databaseName).getBytes("UTF-8"));
        }
    }

    static
    {
        try {
            for (String i : webFiles) {
                monitorFiles.register(i);
            }

            monitorFiles.register("/setup.js", new SetupContent());
            monitorFiles.setDefault(new String[] { "web/dash.html" });
        } catch (FileNotFoundException x) {
            throw new RuntimeException(x);
        }
    }

    interface ContentGenerator
    {
        InputStream getContent(URI uri) throws IOException;
    }

    private final Map<String, String[]> files = new TreeMap<>();
    private final Map<String, ContentGenerator> generatedFiles = new TreeMap<>();

    public void register(String publicName, ContentGenerator content) throws FileNotFoundException
    {
        generatedFiles.put(publicName, content);
    }

    public void register(String publicName) throws FileNotFoundException
    {
/*        register(publicName, new String[]{"web/" + publicName });   */
        register(publicName, new String[]{ "web" + publicName.replace(".", ".min."), "web" + publicName });
    }

    public void register(String publicName, String[] tryFiles) throws FileNotFoundException
    {
        files.put(publicName, tryFiles);
    }

    @Override
    public void handle(HttpExchange httpExchange) throws IOException
    {
        try {
            Logger.getGlobal().fine(String.format("Static file query : %s", httpExchange.getRequestURI().toString()));

            if (!httpExchange.getRequestMethod().equals("GET")) {
                throw new FileNotFoundException(httpExchange.getRequestURI().toString());
            }

            String file = httpExchange.getRequestURI().getPath();

            InputStream dataStream = null;
            String[] tryFiles = files.get(file);

            if (file.equals("/"))
            {
                tryFiles = defaultFiles;
            }

            if (tryFiles == null) {
                ContentGenerator generator = generatedFiles.get(file);

                if (generator != null) {
                    dataStream = generator.getContent(httpExchange.getRequestURI());
                }
            } else {
                Logger.getGlobal().fine("Trying files : " + Arrays.toString(tryFiles));

                for (String x : tryFiles) {
                    File f = new File(x).getAbsoluteFile();

                    Logger.getGlobal().fine("Trying : " + f.toString());

                    if (f.isFile()) {
                        dataStream = new FileInputStream(f);
                        break;
                    }
                }
            }

            if (dataStream == null) {
                throw new FileNotFoundException(file);
            }

            final ByteArrayOutputStream output = new ByteArrayOutputStream();

            {
                int len;
                byte[] buf = new byte[64 * 1024];

                while ((len = dataStream.read(buf)) > 0) {
                    output.write(buf, 0, len);
                }

                output.flush();
                dataStream.close();
            }

            httpExchange.sendResponseHeaders(200, output.size());
            output.writeTo(httpExchange.getResponseBody());
            httpExchange.getResponseBody().close();
        } catch (Exception e) {
            e.printStackTrace();
            httpExchange.sendResponseHeaders(404, 0);
        }

        httpExchange.close();
    }
}
