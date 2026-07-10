package haxe.addons.math.noises;

import haxe.addons.math.noises.NoiseTypes.Noise3D;
import haxe.addons.math.noises.NoiseTypes.Noise2D;

@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class NoiseMap {
	public static function build2D(width:Int, height:Int, noise:Noise2D, scale:Float = 1.0, xOffset:Float = 0.0, yOffset:Float = 0.0,
			seed:Int = 0):Array<Array<Float>> {
		if (width <= 0 || height <= 0)
			return [];

		var map = new Array<Array<Float>>();
		var invW = 1.0 / (width - 1);
		var invH = 1.0 / (height - 1);

		for (y in 0...height) {
			var row = new Array<Float>();

			for (x in 0...width) {
				var nx = (x * invW - 0.5) * scale + xOffset;
				var ny = (y * invH - 0.5) * scale + yOffset;
				row.push(noise(nx, ny, seed));
			}

			map.push(row);
		}

		return map;
	}

	public static function build3D(width:Int, height:Int, depth:Int, noise:Noise3D, scale:Float = 1.0, xOffset:Float = 0.0, yOffset:Float = 0.0,
			zOffset:Float = 0.0, seed:Int = 0):Array<Array<Array<Float>>> {
		if (width <= 0 || height <= 0 || depth <= 0)
			return [];

		var map = new Array<Array<Array<Float>>>();
		var invW = 1.0 / (width - 1);
		var invH = 1.0 / (height - 1);
		var invD = 1.0 / (depth - 1);

		for (z in 0...depth) {
			var slice = new Array<Array<Float>>();

			for (y in 0...height) {
				var row = new Array<Float>();

				for (x in 0...width) {
					var nx = (x * invW - 0.5) * scale + xOffset;
					var ny = (y * invH - 0.5) * scale + yOffset;
					var nz = (z * invD - 0.5) * scale + zOffset;
					row.push(noise(nx, ny, nz, seed));
				}

				slice.push(row);
			}

			map.push(slice);
		}

		return map;
	}
}
