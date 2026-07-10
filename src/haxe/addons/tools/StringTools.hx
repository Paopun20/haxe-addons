package haxe.addons.tools;

@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) class StringTools {
	public static inline function isNullOrEmpty(s:String):Bool
		return s == null || s.length == 0;

	public static inline function capitalize(s:String):String
		return s.charAt(0).toUpperCase() + s.substr(1).toLowerCase();

	public static inline function trimTo(s:String, max:Int, ellipsis:String = "..."):String
		return s.length > max ? s.substr(0, max - ellipsis.length) + ellipsis : s;

	public static function padLeft(s:String, len:Int, char:String = "0"):String {
		while (s.length < len)
			s = char + s;
		return s;
	}

	public static function padRight(s:String, len:Int, char:String = " "):String {
		while (s.length < len)
			s = s + char;
		return s;
	}

	public static inline function contains(s:String, sub:String):Bool
		return s.indexOf(sub) != -1;

	/** Repeat a string n times — "=-" × 3 → "=-=-=" */
	public static function repeat(s:String, times:Int):String {
		var out = "";
		for (_ in 0...times)
			out += s;
		return out;
	}

	/** Safe parseInt — returns fallback instead of throwing on bad input */
	public static inline function toIntSafe(s:String, fallback:Int = 0):Int {
		var n = Std.parseInt(s);
		return n == null ? fallback : n;
	}

	/** Safe parseFloat */
	public static inline function toFloatSafe(s:String, fallback:Float = 0):Float {
		var n = Std.parseFloat(s);
		return Math.isNaN(n) ? fallback : n;
	}

	/** Reverse a string */
	public static function reverse(s:String):String {
		var chars = s.split("");
		chars.reverse();
		return chars.join("");
	}

	/** Count occurrences of sub in s */
	public static function countOccurrences(s:String, sub:String):Int {
		var count = 0;
		var i = 0;
		while ((i = s.indexOf(sub, i)) != -1) {
			count++;
			i += sub.length;
		}
		return count;
	}

	/** Word-wrap: split s into lines no longer than maxLen */
	public static function wordWrap(s:String, maxLen:Int):Array<String> {
		var words = s.split(" ");
		var lines:Array<String> = [];
		var line = "";
		for (w in words) {
			if (line.length == 0) {
				line = w;
				continue;
			}
			if (line.length + 1 + w.length <= maxLen)
				line += " " + w;
			else {
				lines.push(line);
				line = w;
			}
		}
		if (line.length > 0)
			lines.push(line);
		return lines;
	}
}