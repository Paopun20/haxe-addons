package haxe.addons.math.noises;

class SimplexNoise {
	static inline var F2:Float = 0.366025403;
	static inline var G2:Float = 0.211324865;

	static var gradients:Array<Array<Int>> = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]];

	static function hash(x:Int, y:Int, seed:Int):Int {
		var h = x;

		h = h * 374761393;
		h += y * 668265263;
		h += seed * 1442695041;

		h = (h ^ (h >> 13)) * 1274126177;
		h ^= h >> 16;

		return h;
	}

	static inline function dot(g:Array<Int>, x:Float, y:Float):Float {
		return g[0] * x + g[1] * y;
	}

	public static function sample2D(xin:Float, yin:Float, seed:Int = 0):Float {
		// Skew input space
		var s = (xin + yin) * F2;

		var i = Std.int(Math.floor(xin + s));
		var j = Std.int(Math.floor(yin + s));

		// Unskew
		var t = (i + j) * G2;

		var x0 = xin - (i - t);
		var y0 = yin - (j - t);

		var i1:Int;
		var j1:Int;

		if (x0 > y0) {
			i1 = 1;
			j1 = 0;
		} else {
			i1 = 0;
			j1 = 1;
		}

		var x1 = x0 - i1 + G2;
		var y1 = y0 - j1 + G2;

		var x2 = x0 - 1 + 2 * G2;
		var y2 = y0 - 1 + 2 * G2;

		var n0 = contribution(i, j, x0, y0, seed);

		var n1 = contribution(i + i1, j + j1, x1, y1, seed);

		var n2 = contribution(i + 1, j + 1, x2, y2, seed);

		return 70.0 * (n0 + n1 + n2);
	}

	static function contribution(i:Int, j:Int, x:Float, y:Float, seed:Int):Float {
		var t = 0.5 - x * x - y * y;

		if (t < 0)
			return 0;

		var g = gradients[hash(i, j, seed) & 7];

		t *= t;

		return t * t * dot(g, x, y);
	}

	public static function fbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var value = 0.0;

		var amplitude = 1.0;
		var frequency = 1.0;

		var max = 0.0;

		for (i in 0...octaves) {
			value += sample2D(x * frequency, y * frequency, seed + i) * amplitude;

			max += amplitude;

			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return value / max;
	}
}
