package;

import haxe.addons.BitField;
import haxe.addons.UInt8;
import haxe.addons.Int8;

class Main {
    static function main() {
        trace("=== Int8 ===");

        var a:Int8 = 127;
        trace(a); // 127

        a += 1;
        trace(a); // -128

        a += 1;
        trace(a); // -127

        a = -128;
        a -= 1;
        trace(a); // 127

        var b:Int8 = 100;
        var c:Int8 = 50;

        trace(b + c); // -106
        trace(b - c); // 50
        trace(b * c); // wrap
        trace(-b);    // -100

        trace("");

        trace("=== UInt8 ===");

        var u:UInt8 = 255;
        trace(u);

        u += 1;
        trace(u); // 0

        u -= 1;
        trace(u); // 255

        var x:UInt8 = 200;
        var y:UInt8 = 100;

        trace(x + y); // 44
        trace(x - y); // 100

        trace("");

        trace("=== BitField ===");

        var bits = new BitField();

        bits[0] = true;
        bits[3] = true;
        bits[7] = true;

        trace(bits);

        for (i in 0...8)
            trace('bit[$i] = ${bits[i]}');

        bits[3] = false;

        trace(bits);

        trace("");

        trace("=== Cast ===");

        var i:Int = a;
        trace(i);

        var ii:Int8 = 300;
        trace(ii); // 44

        var uu:UInt8 = -1;
        trace(uu); // 255

        trace("");

        trace("=== Bitwise ===");

        var p:Int8 = 25;
        var q:Int8 = 67;

        trace(p & q);
        trace(p | q);
        trace(p ^ q);
        trace(~p);

        trace("");

        trace("=== Shift ===");

        trace((p << 1));
        trace((p >> 1));
    }
}