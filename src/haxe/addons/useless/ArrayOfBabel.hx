package haxe.addons.useless;

abstract ArrayOfBabel(Array<ArrayOfBabel>) {
	public function new() {
		this = [];
		this.push(cast this);
	}

	@:arrayAccess
	function arrayRead(index:Int):ArrayOfBabel
		return this[0];

	@:arrayAccess
	function arrayWrite(index:Int, value:ArrayOfBabel): ArrayOfBabel {
		return this[index] = value;
	}
}
