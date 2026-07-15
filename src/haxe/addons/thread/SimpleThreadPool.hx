package haxe.addons.thread;

#if (!target.threaded)
#error "This class is not available on this target"
#end
import sys.thread.ElasticThreadPool;
import sys.thread.Mutex;

@:allow(haxe.addons.thread.SimpleThread)
class SimpleThreadPool {
	public var threadsCount(get, never):Int;
	public var isShutdown(get, never):Bool;

	private final pool:ElasticThreadPool;
	private final globalMutex:Mutex;

	public function new(maxThreadsCount:Int, threadTimeout:Float = 60) {
		pool = new ElasticThreadPool(maxThreadsCount, threadTimeout);
		globalMutex = new Mutex();
	}

	public function run(task:SimpleThread->Void):Void {
		if (isShutdown)
			return;

		final simple:SimpleThread = new SimpleThread(this);

		pool.run(() -> {
			task(simple);
		});
	};

	public function shutdown():Void {
		pool.shutdown();
	};

	function get_threadsCount():Int {
		return pool.threadsCount;
	}

	function get_isShutdown():Bool {
		return pool.isShutdown;
	}
}
