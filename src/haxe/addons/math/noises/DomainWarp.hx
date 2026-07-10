package haxe.addons.math.noises;

import haxe.addons.math.noises.NoiseTypes.NoiseFunction;

class DomainWarp {
	public static function warp2D(noise:NoiseFunction, warpNoise:NoiseFunction, x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Float {
		var wx = warpNoise(x, y, seed);

		var wy = warpNoise(x + 31.416, y + 47.853, seed + 1);

		return noise(x + wx * strength, y + wy * strength, seed);
	}

	public static function simplexWarp(x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Float {
		return warp2D(SimplexNoise.sample2D, SimplexNoise.sample2D, x, y, strength, seed);
	}

	public static function fbmWarp(x:Float, y:Float, strength:Float = 1.0, octaves:Int = 5, seed:Int = 0):Float {
		var wx = Fractal.fbm(SimplexNoise.sample2D, x, y, octaves, 0.5, 2.0, seed);

		var wy = Fractal.fbm(SimplexNoise.sample2D, x + 100.0, y + 100.0, octaves, 0.5, 2.0, seed + 50);

		return SimplexNoise.sample2D(x + wx * strength, y + wy * strength, seed);
	}
}
