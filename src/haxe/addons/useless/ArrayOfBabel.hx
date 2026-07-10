package haxe.addons.useless;

import haxe.Constraints.NotVoid;

@:forward
@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) abstract ArrayOfBabel(Array<ArrayOfBabel>) {
	public function new() {
		this = [];
		this.push(cast this);
	}

	@:to
	inline function toString():String
		return toString(); // The array is too large

	@:arrayAccess
	function arrayRead(index: NotVoid):ArrayOfBabel
		return this[0];
}
