package oracle.demo;

import java.util.Collection;
import java.util.Iterator;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.function.Supplier;

public class InfiniteGeneratingQueue implements BlockingQueue<Runnable> {
    private static final int PRECREATED_SIZE = Integer.MAX_VALUE;

    private final Supplier<Runnable> supplier;
    private AtomicBoolean stopped = new AtomicBoolean(false);

    public InfiniteGeneratingQueue(Supplier<Runnable> supplier) {
        this.supplier = supplier;
    }

    public void stop() { stopped.set(true); }

    @Override
    public int size() {
        return stopped.get() ? 0 : PRECREATED_SIZE;
    }

    @Override
    public boolean isEmpty() {
        return stopped.get();
    }

    @Override
    public Runnable poll() {
        return stopped.get() ? null : supplier.get();
    }

    @Override
    public Runnable take() throws InterruptedException {
        if (stopped.get()) {
            Thread.currentThread().interrupt();
        }

        return poll();
    }

    @Override
    public Runnable poll(long timeout, TimeUnit unit) throws InterruptedException {
        return poll();
    }

    @Override
    public int remainingCapacity() {
        return 0;
    }

    @Override public Runnable element() {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public Runnable peek() {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean add(Runnable runnable) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean offer(Runnable runnable) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public Runnable remove() {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public void put(Runnable runnable) throws InterruptedException {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean offer(Runnable runnable, long timeout, TimeUnit unit) throws InterruptedException {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean remove(Object o) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean containsAll(Collection<?> c) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean addAll(Collection<? extends Runnable> c) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean removeAll(Collection<?> c) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean retainAll(Collection<?> c) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public void clear() {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public boolean contains(Object o) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public Iterator<Runnable> iterator() {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public Object[] toArray() {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public <T> T[] toArray(T[] a) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public int drainTo(Collection<? super Runnable> c) {
        throw new UnsupportedOperationException("Unimplemented method");
    }

    @Override public int drainTo(Collection<? super Runnable> c, int maxElements) { throw new UnsupportedOperationException("Unimplemented method");  }
}
