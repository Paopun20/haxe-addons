package haxe.addons.useless;

@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) abstract QuantumBoolean(Bool) {
	public inline function new()
		this = true;

	@:to public inline function toBool():Bool
		return this = Math.random() < 0.5;

	public inline function observe():Bool
		return toBool();

	public inline function collapse():Bool
		return this;

	public inline function entangle(other:QuantumBoolean):QuantumBoolean
		return new QuantumBoolean();
}
