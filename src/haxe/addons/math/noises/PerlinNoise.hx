package haxe.addons.math.noises;

class PerlinNoise {
	static inline function fade(t:Float):Float {
		// Ken Perlin's fade curve
		return t * t * t * (t * (t * 6 - 15) + 10);
	}

	static inline function lerp(a:Float, b:Float, t:Float):Float {
		return a + (b - a) * t;
	}

	static function hash(x:Int, y:Int, seed:Int):Int {
		var h = x;

		h = h * 374761393;
		h += y * 668265263;
		h += seed * 1442695041;

		h = (h ^ (h >> 13)) * 1274126177;
		h ^= h >> 16;

		return h;
	}

	static function gradient(x:Int, y:Int, seed:Int):Int {
		var h = hash(x, y, seed);

		return h & 7;
	}

	static function grad(hash:Int, x:Float, y:Float):Float {
		return switch (hash & 7) {
			case 0:
				x + y;

			case 1:
				-x + y;

			case 2:
				x - y;

			case 3:
				-x - y;

			case 4:
				x;

			case 5:
				-x;

			case 6:
				y;

			default:
				-y;
		}
	}

	public static function sample2D(x:Float, y:Float, seed:Int = 0):Float {
		var x0 = Std.int(Math.floor(x));
		var y0 = Std.int(Math.floor(y));

		var xf = x - x0;
		var yf = y - y0;

		var u = fade(xf);
		var v = fade(yf);

		var n00 = grad(gradient(x0, y0, seed), xf, yf);

		var n10 = grad(gradient(x0 + 1, y0, seed), xf - 1, yf);

		var n01 = grad(gradient(x0, y0 + 1, seed), xf, yf - 1);

		var n11 = grad(gradient(x0 + 1, y0 + 1, seed), xf - 1, yf - 1);

		var nx0 = lerp(n00, n10, u);
		var nx1 = lerp(n01, n11, u);

		// normalize roughly into -1..1
		return lerp(nx0, nx1, v) * 0.707;
	}

	public static function fbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var total = 0.0;
		var amplitude = 1.0;
		var frequency = 1.0;
		var maxValue = 0.0;

		for (i in 0...octaves) {
			total += sample2D(x * frequency, y * frequency, seed + i) * amplitude;

			maxValue += amplitude;

			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return total / maxValue;
	}
}
