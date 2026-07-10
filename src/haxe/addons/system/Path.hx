package haxe.addons.system;

import sys.FileSystem;
import sys.io.File;

/**
	A `pathlib`-style path abstraction over a `String`, backed by forward-slash
	separators internally regardless of platform.

	`Path` wraps a normalized string (backslashes converted to `/`, trailing
	slashes trimmed) and provides path manipulation (`join`, `parent`,
	`withName`, ...) as well as filesystem operations (`exists`, `mkdir`,
	`readText`, ...).

	Implicit conversions to/from `String` are supported, so a `Path` can be
	used anywhere a `String` is expected, and vice versa.
**/
@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) abstract Path(String) from String to String {
	/**
		Creates a new `Path` from `path`, normalizing separators and
		stripping any trailing slashes.
	**/
	public inline function new(path:String) {
		this = normalize(path);
	}

	/**
		Converts backslashes to forward slashes and removes trailing
		slashes (except for a lone root `"/"`).

		Returns `"."` if `p` is `null` or empty.
	**/
	static function normalize(p:String):String {
		if (p == null || p.length == 0)
			return ".";
		var s = p.split("\\").join("/");
		while (s.length > 1 && StringTools.endsWith(s, "/"))
			s = s.substr(0, s.length - 1);
		return s;
	}

	/**
		Joins this path with `other`, usable via the `/` operator
		(e.g. `path / "file.txt"`).

		If `other` is `null` or empty, this path is returned unchanged.
		If `other` is absolute (starts with `/`), it replaces this path
		entirely, mirroring the behavior of Python's `pathlib`.
	**/
	@:op(A / B)
	public inline function join(other:String):Path {
		if (other == null || other.length == 0)
			return new Path(this);
		if (StringTools.startsWith(other, "/"))
			return new Path(other); // child is absolute
		return new Path(this + "/" + other);
	}

	/**
		Returns the final component of the path, i.e. everything after
		the last `/`.
	**/
	public function name():String {
		var parts = this.split("/");
		return parts[parts.length - 1];
	}

	/**
		Returns the final component without its suffix.

		A leading dot (as in dotfiles like `.bashrc`) is not treated as a
		suffix separator, so `.bashrc` returns `.bashrc` in full.
	**/
	public function stem():String {
		var n = name();
		var dot = n.lastIndexOf(".");
		if (dot <= 0)
			return n; // no dot, or dotfile like ".bashrc"
		return n.substr(0, dot);
	}

	/**
		Returns the last file extension of the final component, including
		the leading dot (e.g. `".txt"`), or `""` if there is none.
	**/
	public function suffix():String {
		var n = name();
		var dot = n.lastIndexOf(".");
		if (dot <= 0)
			return "";
		return n.substr(dot);
	}

	/**
		Returns all suffixes of the final component, in order
		(e.g. `"archive.tar.gz"` yields `[".tar", ".gz"]`).

		Returns an empty array if the final component has no dots.
	**/
	public function suffixes():Array<String> {
		var n = name();
		var parts = n.split(".");
		if (parts.length <= 1)
			return [];
		parts.shift();
		return [for (p in parts) "." + p];
	}

	/**
		Returns the logical parent directory of this path.

		Returns `"."` if this path has no `/`, or `"/"` if this path is a
		direct child of the root.
	**/
	public function parent():Path {
		var idx = this.lastIndexOf("/");
		if (idx < 0)
			return new Path(".");
		if (idx == 0)
			return new Path("/");
		return new Path(this.substr(0, idx));
	}

	/**
		Returns all ancestor directories of this path, ordered from the
		immediate parent up to (and, if this path is absolute, including)
		the root `"/"`.
	**/
	public function parents():Array<Path> {
		var result = [];
		var cur = parent();
		while (cur.toString() != "." && cur.toString() != "/") {
			result.push(cur);
			var next = cur.parent();
			if (next.toString() == cur.toString())
				break;
			cur = next;
		}
		if (isAbsolute())
			result.push(new Path("/"));
		return result;
	}

	/**
		Splits this path into its individual components.

		If the path is absolute, the first element is `"/"`.
	**/
	public function parts():Array<String> {
		var isAbs = isAbsolute();
		var arr = this.split("/").filter(function(s) return s.length > 0);
		if (isAbs)
			arr.unshift("/");
		return arr;
	}

	/**
		Returns `true` if this path starts with `/`.
	**/
	public function isAbsolute():Bool {
		return StringTools.startsWith(this, "/");
	}

	/**
		Returns a new path with the final component replaced by `newName`,
		keeping the same parent directory.
	**/
	public function withName(newName:String):Path {
		return parent() / newName;
	}

	/**
		Returns a new path with the suffix of the final component replaced
		by `newSuffix` (which should include the leading dot, e.g. `".md"`).
	**/
	public function withSuffix(newSuffix:String):Path {
		return parent() / (stem() + newSuffix);
	}

	/**
		Resolves this path to an absolute path, using the current working
		directory to resolve relative components.
	**/
	public function resolve():Path {
		return new Path(FileSystem.fullPath(this));
	}

	/**
		Returns `true` if a file or directory exists at this path.
	**/
	public function exists():Bool {
		return FileSystem.exists(this);
	}

	/**
		Returns `true` if this path exists and is a regular file
		(i.e. not a directory).
	**/
	public function isFile():Bool {
		return FileSystem.exists(this) && !FileSystem.isDirectory(this);
	}

	/**
		Returns `true` if this path exists and is a directory.
	**/
	public function isDir():Bool {
		return FileSystem.exists(this) && FileSystem.isDirectory(this);
	}

	/**
		Returns filesystem stat information (size, timestamps, etc.) for
		this path.
	**/
	public function stat():sys.FileStat {
		return FileSystem.stat(this);
	}

	/**
		Creates this path as a directory.

		@param parents If `true`, creates any missing intermediate
			directories along the way (like `mkdir -p`).
		@param existOk If `true`, does nothing when the path already
			exists instead of throwing.

		@throws String if the path already exists and `existOk` is `false`.
	**/
	public function mkdir(parents:Bool = false, existOk:Bool = false):Void {
		if (FileSystem.exists(this)) {
			if (!existOk)
				throw '$this already exists';
			return;
		}
		if (parents) {
			var acc = isAbsolute() ? "" : ".";
			for (part in parts()) {
				if (part == "/") {
					acc = "/";
					continue;
				}
				acc = acc == "" || acc == "/" ? acc + part : acc + "/" + part;
				if (!FileSystem.exists(acc))
					FileSystem.createDirectory(acc);
			}
		} else {
			FileSystem.createDirectory(this);
		}
	}

	/**
		Returns the entries of this directory as full `Path`s.

		@throws String if this path is not a directory.
	**/
	public function iterdir():Array<Path> {
		if (!isDir())
			throw '$this is not a directory';
		return [for (f in FileSystem.readDirectory(this)) join(f)];
	}

	/**
		Reads and returns the entire contents of this file as a `String`.
	**/
	public function readText():String {
		return File.getContent(this);
	}

	/**
		Writes `content` to this file, overwriting any existing content.
	**/
	public function writeText(content:String):Void {
		File.saveContent(this, content);
	}

	/**
		Reads and returns the entire contents of this file as `Bytes`.
	**/
	public function readBytes():haxe.io.Bytes {
		return File.getBytes(this);
	}

	/**
		Writes `bytes` to this file, overwriting any existing content.
	**/
	public function writeBytes(bytes:haxe.io.Bytes):Void {
		var out = File.write(this, true);
		out.write(bytes);
		out.close();
	}

	/**
		Creates an empty file at this path if it does not already exist.
		Does nothing if the file already exists.
	**/
	public function touch():Void {
		if (!exists())
			writeText("");
	}

	/**
		Deletes the file at this path.

		@param missingOk If `true`, does nothing when the path does not
			exist instead of throwing.

		@throws String if the path does not exist and `missingOk` is `false`.
	**/
	public function unlink(missingOk:Bool = false):Void {
		if (!exists()) {
			if (!missingOk)
				throw '$this does not exist';
			return;
		}
		FileSystem.deleteFile(this);
	}

	/**
		Deletes the (empty) directory at this path.
	**/
	public function rmdir():Void {
		FileSystem.deleteDirectory(this);
	}

	/**
		Renames/moves this path to `target` and returns the new `Path`.
	**/
	public function rename(target:String):Path {
		FileSystem.rename(this, target);
		return new Path(target);
	}

	/**
		Returns the current working directory as a `Path`.
	**/
	public static function cwd():Path {
		return new Path(Sys.getCwd());
	}

	/**
		Returns the current user's home directory as a `Path`, read from
		the `HOME` environment variable (or `USERPROFILE` on Windows).
	**/
	public static function home():Path {
		var h = Sys.getEnv("HOME");
		if (h == null)
			h = Sys.getEnv("USERPROFILE");
		return new Path(h);
	}

	/**
		Implicitly converts this `Path` back to its underlying `String`
		representation.
	**/
	@:to
	public inline function toString():String {
		return this;
	}

	/**
		Compares two paths for equality based on their normalized string
		representation, usable via the `==` operator.
	**/
	@:op(A == B)
	public inline function equals(other:Path):Bool {
		return this == other.toString();
	}
}
