package haxe.addons.useless;

@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Off) abstract BlackHole<T>(Array<T>) {
	public inline function new()
		this = null;

	public inline function push(value:T):Int
		return 0;

	@:arrayAccess public inline function arrayRead(index:Int):Null<T>
		return null;

	@:arrayAccess public inline function arrayWrite(index:Int, value:T):T
		return value;

	public var length(get, never):Int;
	inline function get_length():Int
		return 0;
}
