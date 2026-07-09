package haxe.addons.tools;

class FloatTools {
	public static inline function clamp(v:Float, min:Float, max:Float):Float
		return Math.max(min, Math.min(max, v));

	public static inline function lerp(a:Float, b:Float, t:Float):Float
		return a + (b - a) * t;

	public static inline function remap(v:Float, inMin:Float, inMax:Float, outMin:Float, outMax:Float):Float
		return outMin + (v - inMin) / (inMax - inMin) * (outMax - outMin);

	public static inline function snap(v:Float, step:Float):Float
		return Math.round(v / step) * step;

	public static inline function sign(v:Float):Int
		return v > 0 ? 1 : v < 0 ? -1 : 0;

	public static inline function between(v:Float, min:Float, max:Float):Bool
		return v >= min && v <= max;

	public static inline function abs(v:Float):Float
		return v < 0 ? -v : v;

	public static inline function toInt(v:Float):Int
		return Std.int(v);

	public static inline function roundTo(v:Float, decimals:Int):Float {
		var f = Math.pow(10, decimals);
		return Math.round(v * f) / f;
	}

	// Ping-pong: great for oscillating effects
	public static inline function pingPong(v:Float, length:Float):Float {
		v = v % (length * 2);
		return v > length ? length * 2 - v : v;
	}

	public static inline function randomRange(min:Float, max:Float):Float
		return min + Math.random() * (max - min);

	// Useful for proc-gen / loot rolls
	public static inline function chance(percent:Float):Bool
		return Math.random() * 100 < percent;

	// Int wrap
	public static inline function wrap(v:Int, min:Int, max:Int):Int {
		var range = max - min + 1;
		return ((v - min) % range + range) % range + min;
	}

	// quick random int
	public static inline function randomInt(min:Int, max:Int):Int
		return min + Std.int(Math.random() * (max - min + 1));

	/** Smooth 3rd-order interpolation — no overshoot, feels more natural than lerp */
	public static inline function smoothStep(edge0:Float, edge1:Float, v:Float):Float {
		var t = clamp((v - edge0) / (edge1 - edge0), 0, 1);
		return t * t * (3 - 2 * t);
	}

	/** Smoother 5th-order version of smoothStep */
	public static inline function smootherStep(edge0:Float, edge1:Float, v:Float):Float {
		var t = clamp((v - edge0) / (edge1 - edge0), 0, 1);
		return t * t * t * (t * (t * 6 - 15) + 10);
	}

	/** Inverse lerp — what t produces v between a and b? Returns 0–1 */
	public static inline function inverseLerp(a:Float, b:Float, v:Float):Float
		return (v - a) / (b - a);

	/** Deadzone — treat values within ±threshold of zero as exactly zero */
	public static inline function deadzone(v:Float, threshold:Float):Float
		return abs(v) < threshold ? 0.0 : v;

	/** Approach target by fixed step per frame, no overshoot */
	public static inline function approach(current:Float, target:Float, step:Float):Float
		return current < target ? Math.min(current + step, target) : Math.max(current - step, target);

	/** Oscillate with sin — good for idle bobs, breathing effects */
	public static inline function oscillate(time:Float, freq:Float, amplitude:Float, offset:Float = 0):Float
		return Math.sin((time * freq + offset) * Math.PI * 2) * amplitude;

	/** Convert degrees to radians */
	public static inline function toRad(deg:Float):Float
		return deg * (Math.PI / 180);

	/** Convert radians to degrees */
	public static inline function toDeg(rad:Float):Float
		return rad * (180 / Math.PI);
}
