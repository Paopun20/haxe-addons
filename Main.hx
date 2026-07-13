package;

import haxe.addons.types.BitField;
import haxe.addons.types.UInt8;
import haxe.addons.types.Int8;
import haxe.addons.collections.Deque;
import haxe.addons.system.Path;

class Main {
	static function dequeTest() {
		var deque = new Deque<Int>(8);
		var i = 0;
		deque.append(++i);
		trace((deque : Array<Int>));
	}

	static function int8Test() {
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
		trace(-b); // -100
	}

	static function uint8Test() {
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
	}

	static function bitfieldTest() {
		var bits = new BitField();

		bits[0] = true;
		bits[3] = true;
		bits[7] = true;

		trace(bits);

		for (i in 0...8)
			trace('bit[$i] = ${bits[i]}');

		bits[3] = false;

		trace(bits);
	}

	static function pathTest() {
		var path:Path = "path/to";
		trace(path.toString());

		var path:Path = new Path(Path.home()) / "video";
		trace(path.toString());

		trace(Sys.programPath());
		trace(new Path(Sys.programPath()));
		trace(new Path(Sys.programPath()).parent);

		var folder = new Path(Sys.programPath()).parent / "newFolder";
		trace(folder);
		folder.mkdir(true, true);
	}

	static function main() {
		dequeTest();
		int8Test();
		uint8Test();
		bitfieldTest();
		pathTest();
	}
}
