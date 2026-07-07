package haxe.addons;

#if cpp
typedef Int8 = cpp.types.Int8;
#elseif cs
typedef Int8 = cs.types.Int8;
#elseif java
typedef Int8 = java.types.Int8;
#else
@:forward
@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
abstract Int8(Int) from Int to Int {
	public inline function new(value:Int = 0) {
		this = normalize(value);
	}

	static inline function normalize(value:Int):Int {
		value &= 0xFF;
		if (value >= 128)
			value -= 256;
		return value;
	}

	@:from
	static inline function fromInt(value:Int):Int8 {
		return new Int8(value);
	}

	@:to
	inline function toInt():Int {
		return this;
	}

	@:op(A + B)
	static inline function add(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) + (b : Int));
	}

	@:op(A - B)
	static inline function sub(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) - (b : Int));
	}

	@:op(A * B)
	static inline function mul(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) * (b : Int));
	}

	@:op(A / B)
	static inline function div(a:Int8, b:Int8):Int8 {
		return new Int8(Std.int((a : Int) / (b : Int)));
	}

	@:op(A % B)
	static inline function mod(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) % (b : Int));
	}

	@:op(-A)
	inline function neg():Int8 {
		return new Int8(-this);
	}

	@:op(A & B)
	static inline function and(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) & (b : Int));
	}

	@:op(A | B)
	static inline function or(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) | (b : Int));
	}

	@:op(A ^ B)
	static inline function xor(a:Int8, b:Int8):Int8 {
		return new Int8((a : Int) ^ (b : Int));
	}

	@:op(A << B)
	static inline function shl(a:Int8, b:Int):Int8 {
		return new Int8((a : Int) << (b : Int));
	}

	@:op(A >> B)
	static inline function shr(a:Int8, b:Int):Int8 {
		return new Int8((a : Int) >> (b : Int));
	}

	public inline function toString():String {
		return Std.string(this);
	}
}
#end
