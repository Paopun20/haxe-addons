package haxe.addons.math.noises;

class ValueNoise {
	static inline function fade(t:Float):Float {
		// Smoothstep
		return t * t * (3.0 - 2.0 * t);
	}

	static inline function lerp(a:Float, b:Float, t:Float):Float {
		return a + (b - a) * t;
	}

	static function hash(x:Int, y:Int, seed:Int):Float {
		var h:Int = x;

		h = h * 374761393;
		h += y * 668265263;
		h += seed * 1442695041;

		h = (h ^ (h >> 13)) * 1274126177;
		h ^= h >> 16;

		// Integer -> [0,1]
		return (h & 0x7fffffff) / 2147483647.0;
	}

	public static function sample2D(x:Float, y:Float, seed:Int = 0):Float {
		var x0 = Std.int(Math.floor(x));
		var y0 = Std.int(Math.floor(y));

		var xf = x - x0;
		var yf = y - y0;

		var u = fade(xf);
		var v = fade(yf);

		var a = hash(x0, y0, seed);
		var b = hash(x0 + 1, y0, seed);
		var c = hash(x0, y0 + 1, seed);
		var d = hash(x0 + 1, y0 + 1, seed);

		var x1 = lerp(a, b, u);
		var x2 = lerp(c, d, u);

		var result = lerp(x1, x2, v);

		// Convert 0..1 -> -1..1
		return result * 2.0 - 1.0;
	}

	public static function fbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var total = 0.0;
		var amplitude = 1.0;
		var frequency = 1.0;
		var amplitudeSum = 0.0;

		for (i in 0...octaves) {
			total += sample2D(x * frequency, y * frequency, seed + i) * amplitude;

			amplitudeSum += amplitude;

			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return total / amplitudeSum;
	}
}
