package haxe.addons.types;

private class BitFieldOutOfRange extends haxe.Exception {
    override public function new() {
        super("BitField index out of range (0-7)");
    }
}

@:forward
@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) abstract BitField(Int) from Int to Int {
    public inline function new(value:Int = 0) {
        this = value & 0xFF; // keep only 8 bits
    }

    @:from
    static inline function fromBool(value:Bool):BitField {
        return new BitField(value ? 1 : 0);
    }

    @:to
    inline function toBool():Bool {
        return this != 0;
    }

    @:arrayAccess
    public inline function arrayRead(index:Int):Bool {
        if (index < 0 || index > 7)
            throw new BitFieldOutOfRange();

        return (this & (1 << index)) != 0;
    }

    @:arrayAccess
    public inline function arrayWrite(index:Int, value:Bool):Bool {
        if (index < 0 || index > 7)
            throw new BitFieldOutOfRange();

        if (value)
            this |= (1 << index);
        else
            this &= ~(1 << index);

        this &= 0xFF; // keep safe
        return value;
    }

    public inline function set(bit:Int):Void {
        this |= (1 << bit);
        this &= 0xFF;
    }

    public inline function clear(bit:Int):Void {
        this &= ~(1 << bit);
        this &= 0xFF;
    }

    public inline function toggle(bit:Int):Void {
        this ^= (1 << bit);
        this &= 0xFF;
    }

    public inline function has(bit:Int):Bool {
        return (this & (1 << bit)) != 0;
    }

    public inline function setValue(bit:Int, value:Bool):Void {
        if (value) set(bit);
        else clear(bit);
    }

    public inline function reset():Void {
        this = 0;
    }

    public inline function fill(value:Bool):Void {
        this = value ? 0xFF : 0;
    }

    @:op(A | B)
    static inline function or(a:BitField, b:BitField):BitField {
        return new BitField(a.toInt() | b.toInt());
    }

    @:op(A & B)
    static inline function and(a:BitField, b:BitField):BitField {
        return new BitField(a.toInt() & b.toInt());
    }

    @:op(A ^ B)
    static inline function xor(a:BitField, b:BitField):BitField {
        return new BitField(a.toInt() ^ b.toInt());
    }

    @:op(~A)
    static inline function not(a:BitField):BitField {
        return new BitField(~a.toInt() & 0xFF);
    }

    @:to
    public inline function toString():String {
        var s = "";
        for (i in 0...8) {
            s = (((this >> i) & 1) == 1 ? "1" : "0") + s;
        }
        return s;
    }

    @:to
    public inline function toInt():Int {
        return this;
    }
}