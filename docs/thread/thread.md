# Thread

Simple thread abstraction built on top of Haxe's `sys.thread` API.

```haxe
import haxe.addons.thread.SimpleThreadPool;
import haxe.addons.thread.SimpleThread;
```

!!! warning "Platform support"
    Only available on threaded targets: `cpp`, `cs`, `hl`, `eval`, `python`, `lua`, `java`, `jvm`.
    Using this module on `js` or `flash` will fail to compile.

---

## Why use this?

Haxe's native `sys.thread.ElasticThreadPool` gives you threads, but no built-in
convention for safely touching state shared across tasks. `SimpleThreadPool`
wraps the pool and hands each task a `SimpleThread` handle so you always have
a single, well-known mutex to reach for instead of managing `Mutex` instances
by hand.

!!! tip "When to reach for this"
    Use `SimpleThreadPool` when you have many short-lived, independent units
    of work (parsing files, hashing, network calls) that occasionally need to
    update a shared result — a counter, a list, a map. If tasks don't share
    state at all, a plain `ElasticThreadPool` is enough and avoids the extra
    indirection.

---

## Quick start

```haxe
import haxe.addons.thread.SimpleThreadPool;

class Main {
    static function main() {
        final pool = new SimpleThreadPool(4);
        var total = 0;

        for (i in 0...10) {
            pool.run(st -> {
                final result = i * i;
                st.editGlobalVar(() -> total += result);
            });
        }

        pool.shutdown();
        trace('Total: $total');
    }
}
```

---

## SimpleThreadPool

A managed pool of worker threads backed by `sys.thread.ElasticThreadPool`.

### Constructor

```haxe
new(maxThreadsCount:Int, threadTimeout:Float = 60)
```

| Parameter         | Type    | Default | Description                                     |
| ----------------- | ------- | ------- | ----------------------------------------------- |
| `maxThreadsCount` | `Int`   | —       | Maximum number of concurrent worker threads     |
| `threadTimeout`   | `Float` | `60`    | Seconds an idle thread waits before being freed |

### Properties

| Property              | Type   | Description                          |
| --------------------- | ------ | ------------------------------------ |
| `#!haxe threadsCount` | `Int`  | Number of active threads (read-only) |
| `#!haxe isShutdown`   | `Bool` | Whether the pool has been shut down  |

### Methods

| Method                                     | Description                                   |
| ------------------------------------------ | --------------------------------------------- |
| `#!haxe run(task:SimpleThread->Void):Void` | Enqueue a task, receives a `SimpleThread` ref |
| `#!haxe shutdown():Void`                   | Shut down the pool and release all threads    |

!!! note "`shutdown()` does not block"
    Calling `shutdown()` stops the pool from accepting new tasks and releases
    idle threads, but it does not wait for already-running tasks to finish.
    If you need to wait for completion, track it yourself — see
    [Waiting for completion](#waiting-for-completion) below.

### Basic example

```haxe
final pool = new SimpleThreadPool(4);

pool.run(st -> {
    st.editGlobalVar(() -> {
        total += compute(id);
    });
});

pool.shutdown();
```

---

## SimpleThread

Handle passed to each task, providing safe access to shared state.

!!! danger "Do not construct directly"
    `SimpleThread` instances are created internally by `SimpleThreadPool`.
    There is no public constructor — always obtain one through the callback
    passed to `run()`.

### Methods

| Method                                       | Description                                                  |
| -------------------------------------------- | ------------------------------------------------------------ |
| `#!haxe editGlobalVar(func:() -> Void):Void` | Execute `func` while holding the pool-wide mutex             |
| `#!haxe isGlobalLock():Bool`                 | Check if the pool-wide mutex is currently held by any thread |

### `editGlobalVar`

Acquires the pool's global mutex, runs `func`, then releases it — even if
`func` throws. Any exception is rethrown in the calling thread **after** the
mutex has been released, so a failing task never leaves the pool locked.

```haxe
pool.run(st -> {
    st.editGlobalVar(() -> {
        if (riskyCheck()) throw "bad state";
        sharedList.push(id);
    });
});
```

### `isGlobalLock`

A non-blocking check — returns `true` if another thread currently holds the
global mutex, `false` otherwise. Useful for skipping non-essential work
rather than waiting on it.

```haxe hl_lines="2"
pool.run(st -> {
    if (!st.isGlobalLock()) {
        st.editGlobalVar(() -> {
            sharedCounter++;
        });
    }
});
```

!!! warning "`isGlobalLock` is a snapshot, not a guarantee"
    The lock state can change between the check and the following
    `editGlobalVar` call. Use it to _avoid unnecessary contention_ (e.g. skip
    a low-priority update), not as a substitute for the mutex itself.

---

## example: parallel word count

A more complete example showing task fan-out, shared-state aggregation, and
waiting for all work to finish.

```haxe
import haxe.addons.thread.SimpleThreadPool;
import sys.thread.Thread;

class WordCount {
    static function main() {
        final files = ["a.txt", "b.txt", "c.txt", "d.txt"];
        final pool = new SimpleThreadPool(4);
        final counts = new Map<String, Int>();

        var remaining = files.length;
        final mainThread = Thread.current();

        for (file in files) {
            pool.run(st -> {
                final words = sys.io.File.getContent(file).split(" ");

                st.editGlobalVar(() -> {
                    for (w in words) {
                        counts.set(w, (counts.exists(w) ? counts.get(w) : 0) + 1);
                    }
                    remaining--;
                    if (remaining == 0) mainThread.sendMessage("done");
                });
            });
        }

        Thread.readMessage(true); // block until "done"
        pool.shutdown();

        trace(counts);
    }
}
```

### Waiting for completion

`SimpleThreadPool` doesn't provide a built-in "join" — the pattern above
(a counter decremented inside `editGlobalVar`, paired with
`Thread.sendMessage` / `Thread.readMessage`) is the recommended way to block
the caller until all enqueued tasks are done.

---

## Common pitfalls

!!! failure "Don't touch shared state outside `editGlobalVar`"
```haxe
// Wrong — race condition
pool.run(st -> total += 1);

    // Right
    pool.run(st -> st.editGlobalVar(() -> total += 1));
    ```

!!! failure "Don't call `run()` after `shutdown()`"
Once `isShutdown` is `true`, further calls to `run()` are ignored (or
throw, depending on target). Check `pool.isShutdown` if you're unsure
whether the pool is still accepting work.

!!! tip "Keep `editGlobalVar` blocks short"
Everything inside `editGlobalVar` runs under a single pool-wide lock —
long-running work there serializes your "parallel" pool. Do the heavy
lifting outside the closure and only touch shared state inside it.
