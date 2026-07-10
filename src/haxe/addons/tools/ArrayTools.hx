package haxe.addons.tools;

@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class ArrayTools {
	public static function shuffle<T>(arr:Array<T>):Array<T> {
		var i = arr.length;
		while (i > 1) {
			var j = Std.int(Math.random() * i--);
			var tmp = arr[i];
			arr[i] = arr[j];
			arr[j] = tmp;
		}
		return arr;
	}

	public static inline function forEach<T>(arr:Array<T>, f:(T) -> Void)
		for (v in arr)
			f(v);

	public static inline function randomItem<T>(arr:Array<T>):Null<T>
		return arr.length > 0 ? arr[Std.int(Math.random() * arr.length)] : null;

	public static inline function first<T>(arr:Array<T>):Null<T>
		return arr.length > 0 ? arr[0] : null;

	public static inline function last<T>(arr:Array<T>):Null<T>
		return arr.length > 0 ? arr[arr.length - 1] : null;

	public static function flatten<T>(arr:Array<Array<T>>):Array<T> {
		var out:Array<T> = [];
		for (a in arr)
			out = out.concat(a);
		return out;
	}

	public static function removeDuplicates<T>(arr:Array<T>):Array<T> {
		var seen = new Map<String, Bool>();
		return arr.filter(v -> {
			var k = Std.string(v);
			var fresh = !seen.exists(k);
			seen.set(k, true);
			fresh;
		});
	}

	public static inline function isEmpty<T>(arr:Array<T>):Bool
		return arr.length == 0;

	public static inline function clear<T>(arr:Array<T>):Array<T> {
		arr.splice(0, arr.length);
		return arr;
	}

	/** Sum of all elements */
	public static function sum(arr:Array<Float>):Float {
		var total = 0.0;
		for (v in arr)
			total += v;
		return total;
	}

	/** Average of all elements */
	public static inline function average(arr:Array<Float>):Float
		return arr.length == 0 ? 0 : sum(arr) / arr.length;

	/** Min value in array */
	public static function minOf(arr:Array<Float>):Float {
		var m = Math.POSITIVE_INFINITY;
		for (v in arr)
			if (v < m)
				m = v;
		return m;
	}

	/** Max value in array */
	public static function maxOf(arr:Array<Float>):Float {
		var m = Math.NEGATIVE_INFINITY;
		for (v in arr)
			if (v > m)
				m = v;
		return m;
	}

	/** Split array into chunks of size n */
	public static function chunk<T>(arr:Array<T>, size:Int):Array<Array<T>> {
		var out:Array<Array<T>> = [];
		var i = 0;
		while (i < arr.length) {
			out.push(arr.slice(i, i + size));
			i += size;
		}
		return out;
	}

	/** Rotate array left by n positions — [1,2,3,4].rotate(1) → [2,3,4,1] */
	public static function rotate<T>(arr:Array<T>, n:Int):Array<T> {
		var len = arr.length;
		if (len == 0)
			return arr;
		n = ((n % len) + len) % len;
		return arr.slice(n).concat(arr.slice(0, n));
	}

	/** Count elements matching a predicate */
	public static function count<T>(arr:Array<T>, pred:T->Bool):Int {
		var n = 0;
		for (v in arr)
			if (pred(v))
				n++;
		return n;
	}

	/** True if any element matches predicate */
	public static function any<T>(arr:Array<T>, pred:T->Bool):Bool {
		for (v in arr)
			if (pred(v))
				return true;
		return false;
	}

	/** True if all elements match predicate */
	public static function all<T>(arr:Array<T>, pred:T->Bool):Bool {
		for (v in arr)
			if (!pred(v))
				return false;
		return true;
	}

	/** Zip two arrays into pairs — stops at the shorter length */
	public static function zip<A, B>(a:Array<A>, b:Array<B>):Array<{a:A, b:B}> {
		var len = Std.int(Math.min(a.length, b.length));
		var out = [];
		for (i in 0...len)
			out.push({a: a[i], b: b[i]});
		return out;
	}
}
