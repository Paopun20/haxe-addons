package haxe.addons.math;

@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class Interpolation {
	public static function lerp(a:Float, b:Float, t:Float):Float {
		return a + (b - a) * t;
	}

	public static function clamp(t:Float, min:Float = 0, max:Float = 1):Float {
		return (t < min) ? min : ((t > max) ? max : t);
	}

	public static function smoothStep(edge0:Float, edge1:Float, v:Float):Float {
		var t = clamp((v - edge0) / (edge1 - edge0), 0, 1);
		return t * t * (3 - 2 * t);
	}

	public static function smootherStep(edge0:Float, edge1:Float, v:Float):Float {
		var t = clamp((v - edge0) / (edge1 - edge0), 0, 1);
		return t * t * t * (t * (t * 6 - 15) + 10);
	}

	public static function easeInQuad(t:Float):Float {
		return t * t;
	}

	public static function easeOutQuad(t:Float):Float {
		return t * (2 - t);
	}

	public static function easeInOutQuad(t:Float):Float {
		return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t;
	}

	public static function easeInCubic(t:Float):Float {
		return t * t * t;
	}

	public static function easeOutCubic(t:Float):Float {
		var x = t - 1;
		return x * x * x + 1;
	}

	public static function easeInOutCubic(t:Float):Float {
		return t < 0.5 ? 4 * t * t * t : 1 + Math.pow(2 * t - 2, 3) / 2;
	}

	public static function exponential(t:Float, power:Float = 2):Float {
		return Math.pow(t, power);
	}

	public static function bounce(t:Float):Float {
		if (t < 1 / 2.75)
			return 7.5625 * t * t;

		if (t < 2 / 2.75) {
			t -= 1.5 / 2.75;
			return 7.5625 * t * t + 0.75;
		}

		if (t < 2.5 / 2.75) {
			t -= 2.25 / 2.75;
			return 7.5625 * t * t + 0.9375;
		}

		t -= 2.625 / 2.75;
		return 7.5625 * t * t + 0.984375;
	}

	public static function pingPong(t:Float):Float {
		t %= 2;
		return t < 1 ? t : 2 - t;
	}
}
