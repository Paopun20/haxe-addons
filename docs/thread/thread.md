# Thread

Simple thread abstraction built on top of Haxe's `sys.thread` API.

```haxe
import haxe.addons.thread.SimpleThreadPool;
import haxe.addons.thread.SimpleThread;
```

Only available on threaded targets (`cpp`, `cs`, `hl`, `eval`, `python`, `lua`, `java`, `jvm`).

---

## SimpleThreadPool

A managed pool of worker threads backed by `sys.thread.ElasticThreadPool`.

### Constructor

```haxe
new(maxThreadsCount:Int, threadTimeout:Float = 60)
```

Creates a pool with up to `maxThreadsCount` concurrent threads. Idle threads are terminated after `threadTimeout` seconds.

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

### Example

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

> Instances are created internally by `SimpleThreadPool` — do not construct directly.

### Methods

| Method                                       | Description                                                  |
| -------------------------------------------- | ------------------------------------------------------------ |
| `#!haxe editGlobalVar(func:() -> Void):Void` | Execute `func` while holding the pool-wide mutex             |
| `#!haxe isGlobalLock():Bool`                 | Check if the pool-wide mutex is currently held by any thread |

### `editGlobalVar`

Acquires the pool's global mutex, runs `func`, then releases it. Any exception thrown by `func` is rethrown in the calling thread after the mutex is released.

### `isGlobalLock`

Non-blocking check — returns `true` if another thread currently holds the global mutex, `false` otherwise.

### Example

```haxe
pool.run(st -> {
    if (!st.isGlobalLock()) {
        st.editGlobalVar(() -> {
            sharedCounter++;
        });
    }
});
```
