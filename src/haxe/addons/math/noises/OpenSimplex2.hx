package haxe.addons.math.noises;

class OpenSimplex2 {
	static inline var F2:Float = 0.3660254037844386;
	static inline var G2:Float = 0.21132486540518713;
	static inline var F3:Float = 1.0 / 3.0;
	static inline var G3:Float = 1.0 / 6.0;

	static var gradients2D:Array<Array<Int>> = [
		[1, 0], [-1, 0],  [0, 1], [0, -1],
		[1, 1], [-1, 1], [1, -1], [-1, -1]
	];

	static var gradients3D:Array<Array<Int>> = [
		[1, 1, 0], [-1, 1, 0], [1, -1, 0], [-1, -1, 0],
		[1, 0, 1], [-1, 0, 1], [1, 0, -1], [-1, 0, -1],
		[0, 1, 1], [0, -1, 1], [0, 1, -1], [0, -1, -1]
	];

	static function hash(x:Int, y:Int, seed:Int):Int {
		var h = x;

		h = h * 374761393;
		h += y * 668265263;
		h += seed * 1442695041;

		h = (h ^ (h >> 13)) * 1274126177;
		h ^= h >> 16;

		return h;
	}

	static function hash3D(x:Int, y:Int, z:Int, seed:Int):Int {
		var h = x;

		h = h * 374761393;
		h += y * 668265263;
		h += z * 2147483647;
		h += seed * 1442695041;

		h = (h ^ (h >> 13)) * 1274126177;
		h ^= h >> 16;

		return h;
	}

	static inline function dot(g:Array<Int>, x:Float, y:Float):Float {
		return g[0] * x + g[1] * y;
	}

	static inline function dot3(g:Array<Int>, x:Float, y:Float, z:Float):Float {
		return g[0] * x + g[1] * y + g[2] * z;
	}

	public static function sample2D(xin:Float, yin:Float, seed:Int = 0):Float {
		var s = (xin + yin) * F2;

		var i = Std.int(Math.floor(xin + s));
		var j = Std.int(Math.floor(yin + s));

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
		var x2 = x0 - 1.0 + 2.0 * G2;
		var y2 = y0 - 1.0 + 2.0 * G2;

		var n0 = contribution2D(i, j, x0, y0, seed);
		var n1 = contribution2D(i + i1, j + j1, x1, y1, seed);
		var n2 = contribution2D(i + 1, j + 1, x2, y2, seed);

		return 70.0 * (n0 + n1 + n2);
	}

	static function contribution2D(i:Int, j:Int, x:Float, y:Float, seed:Int):Float {
		var t = 0.5 - x * x - y * y;

		if (t < 0.0)
			return 0.0;

		var g = gradients2D[hash(i, j, seed) & 7];
		t *= t;
		return t * t * dot(g, x, y);
	}

	public static function sample3D(xin:Float, yin:Float, zin:Float, seed:Int = 0):Float {
		var s = (xin + yin + zin) * F3;

		var i = Std.int(Math.floor(xin + s));
		var j = Std.int(Math.floor(yin + s));
		var k = Std.int(Math.floor(zin + s));

		var t = (i + j + k) * G3;

		var x0 = xin - (i - t);
		var y0 = yin - (j - t);
		var z0 = zin - (k - t);

		var i1:Int;
		var j1:Int;
		var k1:Int;
		var i2:Int;
		var j2:Int;
		var k2:Int;

		if (x0 >= y0) {
			if (y0 >= z0) {
				i1 = 1;
				j1 = 0;
				k1 = 0;
				i2 = 1;
				j2 = 1;
				k2 = 0;
			} else if (x0 >= z0) {
				i1 = 1;
				j1 = 0;
				k1 = 0;
				i2 = 1;
				j2 = 0;
				k2 = 1;
			} else {
				i1 = 0;
				j1 = 0;
				k1 = 1;
				i2 = 1;
				j2 = 0;
				k2 = 1;
			}
		} else {
			if (y0 < z0) {
				i1 = 0;
				j1 = 0;
				k1 = 1;
				i2 = 0;
				j2 = 1;
				k2 = 1;
			} else if (x0 < z0) {
				i1 = 0;
				j1 = 1;
				k1 = 0;
				i2 = 0;
				j2 = 1;
				k2 = 1;
			} else {
				i1 = 0;
				j1 = 1;
				k1 = 0;
				i2 = 1;
				j2 = 1;
				k2 = 0;
			}
		}

		var x1 = x0 - i1 + G3;
		var y1 = y0 - j1 + G3;
		var z1 = z0 - k1 + G3;
		var x2 = x0 - i2 + 2.0 * G3;
		var y2 = y0 - j2 + 2.0 * G3;
		var z2 = z0 - k2 + 2.0 * G3;
		var x3 = x0 - 1.0 + 3.0 * G3;
		var y3 = y0 - 1.0 + 3.0 * G3;
		var z3 = z0 - 1.0 + 3.0 * G3;

		var n0 = contribution3D(i, j, k, x0, y0, z0, seed);
		var n1 = contribution3D(i + i1, j + j1, k + k1, x1, y1, z1, seed);
		var n2 = contribution3D(i + i2, j + j2, k + k2, x2, y2, z2, seed);
		var n3 = contribution3D(i + 1, j + 1, k + 1, x3, y3, z3, seed);

		return 32.0 * (n0 + n1 + n2 + n3);
	}

	static function contribution3D(i:Int, j:Int, k:Int, x:Float, y:Float, z:Float, seed:Int):Float {
		var t = 0.6 - x * x - y * y - z * z;

		if (t < 0.0)
			return 0.0;

		var g = gradients3D[hash3D(i, j, k, seed) & 11];
		t *= t;
		return t * t * dot3(g, x, y, z);
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

	public static function fbm3D(x:Float, y:Float, z:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var value = 0.0;
		var amplitude = 1.0;
		var frequency = 1.0;
		var max = 0.0;

		for (i in 0...octaves) {
			value += sample3D(x * frequency, y * frequency, z * frequency, seed + i) * amplitude;
			max += amplitude;
			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return value / max;
	}
}
