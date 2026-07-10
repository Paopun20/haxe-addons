package haxe.addons.math.noises;

import haxe.addons.math.MathTypes.Vector2;
import haxe.addons.math.noises.NoiseTypes.NoiseFunction;

class CurlNoise {
	/**
	 * Calculate 2D curl from scalar noise field
	 */
	public static function sample2D(noise:NoiseFunction, x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Vector2 {
		var eps = 0.0001;
		var n1 = noise(x, y + eps, seed);
		var n2 = noise(x, y - eps, seed);
		var a = (n1 - n2) / (2.0 * eps);
		var n3 = noise(x + eps, y, seed);
		var n4 = noise(x - eps, y, seed);
		var b = (n3 - n4) / (2.0 * eps);
		return {
			x: a * strength,
			y: -b * strength
		};
	}

	public static function simplex(x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Vector2 {
		return sample2D(SimplexNoise.sample2D, x, y, strength, seed);
	}

	public static function fbm(x:Float, y:Float, strength:Float = 1.0, octaves:Int = 5, seed:Int = 0):Vector2 {
		return sample2D(function(a:Float, b:Float, s:Int) {
			return Fractal.fbm(SimplexNoise.sample2D, a, b, octaves, 0.5, 2.0, s);
		}, x, y, strength, seed);
	}
}
