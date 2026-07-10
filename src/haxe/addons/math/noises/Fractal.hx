package haxe.addons.math.noises;

import haxe.addons.math.noises.NoiseTypes.NoiseFunction;

@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class Fractal {
	public static function fbm(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var value = 0.0;

		var amplitude = 1.0;
		var frequency = 1.0;

		var maxAmplitude = 0.0;

		for (i in 0...octaves) {
			value += noise(x * frequency, y * frequency, seed + i) * amplitude;

			maxAmplitude += amplitude;

			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return value / maxAmplitude;
	}

	public static function billow(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var value = 0.0;

		var amplitude = 1.0;
		var frequency = 1.0;

		var maxAmplitude = 0.0;

		for (i in 0...octaves) {
			var n = noise(x * frequency, y * frequency, seed + i);

			// -1..1 -> 0..1 -> folded
			n = Math.abs(n);

			value += n * amplitude;

			maxAmplitude += amplitude;

			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return value / maxAmplitude;
	}

	public static function ridged(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		var value = 0.0;

		var amplitude = 1.0;
		var frequency = 1.0;

		var maxAmplitude = 0.0;

		for (i in 0...octaves) {
			var n = noise(x * frequency, y * frequency, seed + i);

			// Create sharp ridges
			n = 1.0 - Math.abs(n);

			n *= n;

			value += n * amplitude;

			maxAmplitude += amplitude;

			amplitude *= persistence;
			frequency *= lacunarity;
		}

		return value / maxAmplitude;
	}
}
