package haxe.addons.tools;

@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class IntTools {
	public static inline function inRange(v:Int, min:Int, max:Int):Bool
		return v >= min && v <= max;

	public static inline function isEven(v:Int):Bool
		return v % 2 == 0;

	public static inline function isOdd(v:Int):Bool
		return v % 2 != 0;

	public static inline function toFloat(v:Int):Float
		return v;

	/** Number of digits in a non-negative integer */
	public static inline function digitCount(v:Int):Int
		return v == 0 ? 1 : Std.int(Math.log(v) / Math.log(10)) + 1;

	/** Greatest common divisor — useful for aspect-ratio reduction */
	public static function gcd(a:Int, b:Int):Int
		return b == 0 ? a : gcd(b, a % b);

	/** Least common multiple */
	public static inline function lcm(a:Int, b:Int):Int
		return Std.int(a / gcd(a, b)) * b;
}
