package haxe.addons.collections;

using haxe.addons.tools.ArrayTools;

/**
	Internal storage container for `Deque` values.

	Holds the underlying array and the optional maximum length
	used to bound the deque's size.
**/
@:private
#if cpp
@:unreflective
#end
@:allow(haxe.addons.collections.Deque)
final class DequeData<T> implements ArrayAccess<T> {
	/**
		The underlying array storing the deque's elements.
	**/
	private var data:Array<T>;

	/**
		The maximum number of elements allowed in the deque.

		A value of `0` (the default) means the deque is unbounded.
	**/
	private final maxlen:Int;

	/**
		Creates a new `DequeData` instance.

		@param maxlen The maximum number of elements allowed, or `0` for unbounded.
	**/
	private function new(maxlen:Int = 0) {
		this.maxlen = maxlen;
		this.data = [];
	}
}

/**
	A double-ended queue (deque) abstract type backed by an `Array`.

	Supports efficient insertion and removal from both ends, and can
	optionally be bounded to a maximum length, in which case elements
	are automatically dropped from the opposite end when the bound
	is exceeded.

	Can be implicitly created from an `Array<T>` and converted back
	to an `Array<T>`.
**/
@:transitive
@:forward(length, iterator, push, pop)
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) abstract Deque<T>(DequeData<T>) {
	/**
		Creates a new, empty `Deque`.

		@param maxlen The maximum number of elements allowed in the deque.
		If greater than `0`, appending/prepending beyond this length will
		automatically remove elements from the opposite end. Defaults to `0` (unbounded).
	**/
	public inline function new(?maxlen:Int = 0) {
		this = new DequeData<T>(maxlen);
	}

	/**
		Implicitly converts an `Array<T>` into a `Deque<T>` by appending
		each element of the array, in order.

		@param array The array to convert.
		@return A new `Deque<T>` containing the array's elements.
	**/
	@:from
	static inline function fromArray<T>(array:Array<T>):Deque<T> {
		var deque = new Deque<T>();
		array.forEach(deque.append);
		return deque;
	}

	/**
		Implicitly converts this `Deque<T>` into a plain `Array<T>`.

		Returns a shallow copy of the underlying data, so mutating the
		returned array does not affect the deque.

		@return A new array containing the deque's elements, in order.
	**/
	@:to
	inline function toArray():Array<T>
		return this.data.copy();

	/**
		Appends a value to the right (end) of the deque.

		If a `maxlen` was specified and the deque exceeds that length
		after appending, the leftmost element is removed.

		@param value The value to append.
	**/
	public inline function append(value:T):Void {
		this.data.push(value);

		if (this.maxlen > 0 && this.data.length > this.maxlen)
			this.data.shift();
	}

	/**
		Appends a value to the left (start) of the deque.

		If a `maxlen` was specified and the deque exceeds that length
		after appending, the rightmost element is removed.

		@param value The value to prepend.
	**/
	public inline function appendLeft(value:T):Void {
		this.data.unshift(value);

		if (this.maxlen > 0 && this.data.length > this.maxlen)
			this.data.pop();
	}

	/**
		Removes and returns the value at the right (end) of the deque.

		@return The removed value, or `null` if the deque is empty.
	**/
	public inline function pop():Null<T>
		return this.data.pop();

	/**
		Removes and returns the value at the left (start) of the deque.

		@return The removed value, or `null` if the deque is empty.
	**/
	public inline function popLeft():Null<T>
		return this.data.shift();
}
