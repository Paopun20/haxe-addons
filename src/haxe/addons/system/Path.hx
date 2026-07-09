package haxe.addons.system;

import sys.FileSystem;
import sys.io.File;

@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Off) abstract Path(String) from String to String {

    public inline function new(path:String) {
        this = normalize(path);
    }

    static function normalize(p:String):String {
        if (p == null || p.length == 0) return ".";
        var s = p.split("\\").join("/");
        while (s.length > 1 && StringTools.endsWith(s, "/"))
            s = s.substr(0, s.length - 1);
        return s;
    }

    @:op(A / B)
    public inline function join(other:String):Path {
        if (other == null || other.length == 0) return new Path(this);
        if (StringTools.startsWith(other, "/")) return new Path(other); // child is absolute
        return new Path(this + "/" + other);
    }

    public function name():String {
        var parts = this.split("/");
        return parts[parts.length - 1];
    }

    public function stem():String {
        var n = name();
        var dot = n.lastIndexOf(".");
        if (dot <= 0) return n; // no dot, or dotfile like ".bashrc"
        return n.substr(0, dot);
    }

    public function suffix():String {
        var n = name();
        var dot = n.lastIndexOf(".");
        if (dot <= 0) return "";
        return n.substr(dot);
    }

    public function suffixes():Array<String> {
        var n = name();
        var parts = n.split(".");
        if (parts.length <= 1) return [];
        parts.shift();
        return [for (p in parts) "." + p];
    }

    public function parent():Path {
        var idx = this.lastIndexOf("/");
        if (idx < 0) return new Path(".");
        if (idx == 0) return new Path("/");
        return new Path(this.substr(0, idx));
    }

    public function parents():Array<Path> {
        var result = [];
        var cur = parent();
        while (cur.toString() != "." && cur.toString() != "/") {
            result.push(cur);
            var next = cur.parent();
            if (next.toString() == cur.toString()) break;
            cur = next;
        }
        if (isAbsolute()) result.push(new Path("/"));
        return result;
    }

    public function parts():Array<String> {
        var isAbs = isAbsolute();
        var arr = this.split("/").filter(function(s) return s.length > 0);
        if (isAbs) arr.unshift("/");
        return arr;
    }

    public function isAbsolute():Bool {
        return StringTools.startsWith(this, "/");
    }


    public function withName(newName:String):Path {
        return parent() / newName;
    }

    public function withSuffix(newSuffix:String):Path {
        return parent() / (stem() + newSuffix);
    }

    public function resolve():Path {
        return new Path(FileSystem.fullPath(this));
    }
  
    public function exists():Bool {
        return FileSystem.exists(this);
    }

    public function isFile():Bool {
        return FileSystem.exists(this) && !FileSystem.isDirectory(this);
    }

    public function isDir():Bool {
        return FileSystem.exists(this) && FileSystem.isDirectory(this);
    }

    public function stat():sys.FileStat {
        return FileSystem.stat(this);
    }

    // ---- filesystem mutation ----
    public function mkdir(parents:Bool = false, existOk:Bool = false):Void {
        if (FileSystem.exists(this)) {
            if (!existOk) throw '$this already exists';
            return;
        }
        if (parents) {
            var acc = isAbsolute() ? "" : ".";
            for (part in parts()) {
                if (part == "/") { acc = "/"; continue; }
                acc = acc == "" || acc == "/" ? acc + part : acc + "/" + part;
                if (!FileSystem.exists(acc)) FileSystem.createDirectory(acc);
            }
        } else {
            FileSystem.createDirectory(this);
        }
    }

    public function iterdir():Array<Path> {
        if (!isDir()) throw '$this is not a directory';
        return [for (f in FileSystem.readDirectory(this)) join(f)];
    }

    public function readText():String {
        return File.getContent(this);
    }

    public function writeText(content:String):Void {
        File.saveContent(this, content);
    }

    public function readBytes():haxe.io.Bytes {
        return File.getBytes(this);
    }

    public function writeBytes(bytes:haxe.io.Bytes):Void {
        var out = File.write(this, true);
        out.write(bytes);
        out.close();
    }

    public function touch():Void {
        if (!exists()) writeText("");
    }

    public function unlink(missingOk:Bool = false):Void {
        if (!exists()) {
            if (!missingOk) throw '$this does not exist';
            return;
        }
        FileSystem.deleteFile(this);
    }

    public function rmdir():Void {
        FileSystem.deleteDirectory(this);
    }

    public function rename(target:String):Path {
        FileSystem.rename(this, target);
        return new Path(target);
    }

    public static function cwd():Path {
        return new Path(Sys.getCwd());
    }

    public static function home():Path {
        var h = Sys.getEnv("HOME");
        if (h == null) h = Sys.getEnv("USERPROFILE");
        return new Path(h);
    }

    @:to
    public inline function toString():String {
        return this;
    }

    @:op(A == B)
    public inline function equals(other:Path):Bool {
        return this == other.toString();
    }
}
