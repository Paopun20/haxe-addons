package haxe.addons.thread;

#if (!target.threaded)
#error "This class is not available on this target"
#end

@:allow(haxe.addons.thread.SimpleThreadPool)
class SimpleThread {
	var pool:SimpleThreadPool;

	function new(stp:SimpleThreadPool) {
		pool = stp;
	}

	public function editGlobalVar(func:() -> Void) {
		pool.globalMutex.acquire();
		var caught:Dynamic = null;
		try {
			func();
		} catch (e:Dynamic) {
			caught = e;
		}
		pool.globalMutex.release();
		if (caught != null)
			throw caught;
	}

	public function isGlobalLock():Bool {
		final acquired = pool.globalMutex.tryAcquire();
		if (acquired) {
			pool.globalMutex.release();
			return false; // it was free — we just grabbed and released it
		}
		return true; // couldn't acquire — someone else holds it
	}
}