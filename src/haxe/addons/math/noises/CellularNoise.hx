package haxe.addons.math.noises;

@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class CellularNoise {
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

	static function random(x:Int, y:Int, seed:Int):Float {
		return ((hash(x, y, seed) & 0x7fffffff) / 2147483647.0);
	}

	static function random3D(x:Int, y:Int, z:Int, seed:Int):Float {
		return ((hash3D(x, y, z, seed) & 0x7fffffff) / 2147483647.0);
	}

	static inline function distance(ax:Float, ay:Float, bx:Float, by:Float):Float {
		var dx = ax - bx;
		var dy = ay - by;
		return Math.sqrt(dx * dx + dy * dy);
	}

	static inline function distance3D(ax:Float, ay:Float, az:Float, bx:Float, by:Float, bz:Float):Float {
		var dx = ax - bx;
		var dy = ay - by;
		var dz = az - bz;
		return Math.sqrt(dx * dx + dy * dy + dz * dz);
	}

	public static function sample2D(x:Float, y:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		var cellX = Std.int(Math.floor(x));
		var cellY = Std.int(Math.floor(y));

		var nearest = 999999.0;

		for (yy in -1...2) {
			for (xx in -1...2) {
				var cx = cellX + xx;
				var cy = cellY + yy;

				var px = cx + (random(cx, cy, seed) - 0.5) * jitter;
				var py = cy + (random(cx, cy, seed + 12345) - 0.5) * jitter;

				var d = distance(x, y, px, py);

				if (d < nearest)
					nearest = d;
			}
		}

		return nearest;
	}

	public static function edge2D(x:Float, y:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		var cellX = Std.int(Math.floor(x));
		var cellY = Std.int(Math.floor(y));

		var f1 = 999999.0;
		var f2 = 999999.0;

		for (yy in -1...2) {
			for (xx in -1...2) {
				var cx = cellX + xx;
				var cy = cellY + yy;

				var px = cx + (random(cx, cy, seed) - 0.5) * jitter;
				var py = cy + (random(cx, cy, seed + 12345) - 0.5) * jitter;

				var d = distance(x, y, px, py);

				if (d < f1) {
					f2 = f1;
					f1 = d;
				} else if (d < f2) {
					f2 = d;
				}
			}
		}

		return f2 - f1;
	}

	public static function sample3D(x:Float, y:Float, z:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		var cellX = Std.int(Math.floor(x));
		var cellY = Std.int(Math.floor(y));
		var cellZ = Std.int(Math.floor(z));

		var nearest = 999999.0;

		for (zz in -1...2) {
			for (yy in -1...2) {
				for (xx in -1...2) {
					var cx = cellX + xx;
					var cy = cellY + yy;
					var cz = cellZ + zz;

					var px = cx + (random3D(cx, cy, cz, seed) - 0.5) * jitter;
					var py = cy + (random3D(cx, cy, cz, seed + 17) - 0.5) * jitter;
					var pz = cz + (random3D(cx, cy, cz, seed + 31) - 0.5) * jitter;

					var d = distance3D(x, y, z, px, py, pz);

					if (d < nearest)
						nearest = d;
				}
			}
		}

		return nearest;
	}

	public static function edge3D(x:Float, y:Float, z:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		var cellX = Std.int(Math.floor(x));
		var cellY = Std.int(Math.floor(y));
		var cellZ = Std.int(Math.floor(z));

		var f1 = 999999.0;
		var f2 = 999999.0;

		for (zz in -1...2) {
			for (yy in -1...2) {
				for (xx in -1...2) {
					var cx = cellX + xx;
					var cy = cellY + yy;
					var cz = cellZ + zz;

					var px = cx + (random3D(cx, cy, cz, seed) - 0.5) * jitter;
					var py = cy + (random3D(cx, cy, cz, seed + 17) - 0.5) * jitter;
					var pz = cz + (random3D(cx, cy, cz, seed + 31) - 0.5) * jitter;

					var d = distance3D(x, y, z, px, py, pz);

					if (d < f1) {
						f2 = f1;
						f1 = d;
					} else if (d < f2) {
						f2 = d;
					}
				}
			}
		}

		return f2 - f1;
	}
}
