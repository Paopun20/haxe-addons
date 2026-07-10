package haxe.addons.math.noises;

class WorleyNoise {
	static function hash(x:Int, y:Int, seed:Int):Int {
		var h = x;

		h = h * 374761393;
		h += y * 668265263;
		h += seed * 1442695041;

		h = (h ^ (h >> 13)) * 1274126177;
		h ^= h >> 16;

		return h;
	}

	static function random(x:Int, y:Int, seed:Int):Float {
		return (hash(x, y, seed) & 0x7fffffff) / 2147483647.0;
	}

	static function distance(ax:Float, ay:Float, bx:Float, by:Float):Float {
		var dx = ax - bx;
		var dy = ay - by;

		return Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Returns distance to nearest cell point.
	 * Range is roughly 0..1
	 */
	public static function sample2D(x:Float, y:Float, seed:Int = 0):Float {
		var cellX = Std.int(Math.floor(x));
		var cellY = Std.int(Math.floor(y));

		var nearest = 999999.0;

		// Check surrounding cells
		for (yy in -1...2) {
			for (xx in -1...2) {
				var cx = cellX + xx;
				var cy = cellY + yy;

				// Random point inside cell
				var px = cx + random(cx, cy, seed);

				var py = cy + random(cx, cy, seed + 12345);

				var d = distance(x, y, px, py);

				if (d < nearest)
					nearest = d;
			}
		}

		return nearest;
	}

	/**
	 * F1 - F2 pattern
	 * Creates cellular edges
	 */
	public static function edge2D(x:Float, y:Float, seed:Int = 0):Float {
		var cellX = Std.int(Math.floor(x));
		var cellY = Std.int(Math.floor(y));

		var f1 = 999999.0;
		var f2 = 999999.0;

		for (yy in -1...2) {
			for (xx in -1...2) {
				var cx = cellX + xx;
				var cy = cellY + yy;

				var px = cx + random(cx, cy, seed);

				var py = cy + random(cx, cy, seed + 12345);

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
}
