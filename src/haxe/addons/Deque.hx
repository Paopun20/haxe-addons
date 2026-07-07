package haxe.addons;

@:private
#if cpp
@:unreflective
#end
private final class DequeData<T> {
	public var data:Array<T>;
	public var maxlen:Int;

	public function new(maxlen:Int = 0) {
		this.maxlen = maxlen;
		this.data = [];
	}
}

@:forward(length, iterator)
abstract Deque<T>(DequeData<T>) from Array<T> to Array<T> {
	public inline function new(?maxlen:Int = 0) {
		this = new DequeData<T>(maxlen);
	}

	@:from
	static inline function fromArray<T>(array:Array<T>):Deque<T> {
		var d = new Deque<T>();

		for (v in array)
			d.append(v);

		return d;
	}

	@:to
	inline function toArray():Array<T> {
		return this.data.copy();
	}

	public inline function append(value:T):Void {
		this.data.push(value);

		if (this.maxlen > 0 && this.data.length > this.maxlen)
			this.data.shift();
	}

	public inline function appendLeft(value:T):Void {
		this.data.unshift(value);

		if (this.maxlen > 0 && this.data.length > this.maxlen)
			this.data.pop();
	}

	public inline function pop():Null<T> {
		return this.data.pop();
	}

	public inline function popLeft():Null<T> {
		return this.data.shift();
	}
}
