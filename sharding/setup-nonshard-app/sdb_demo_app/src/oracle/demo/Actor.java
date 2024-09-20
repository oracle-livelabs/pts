package oracle.demo;

import oracle.RandomGenerator;

import java.util.Random;

public class Actor implements Runnable
{
    final Random random;
    final Application app;

    public Actor(Application app) {
        this(app, new Random());
    }

    public Actor(Application app, Random random) {
        this.app = app;
        this.random = random;
    }

    public final static RandomGenerator<Class<? extends Action>> actions = new RandomGenerator<>();

    public static abstract class Action
    {
        protected Application app = null;
        protected Random random = null;

        void init(Application app, Random random)
        {
            this.app = app;
            this.random = random;
        };

        public abstract void run() throws ApplicationException;
    }

    @Override
    public void run()
    {
        app.stats.bump(Statistics.COUNTER_JOBS_CREATED);

        try {
            /* Randomly choose action */
            Action action = actions.getW(random.nextDouble()).newInstance();

            /* Initialize */
            action.init(app, random);

            /* Execute action */
            action.run();
        }
        catch (Exception e)
        {
            app.reportUnhandledException(e);
        }
    }
}
