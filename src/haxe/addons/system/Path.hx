package haxe.addons.system;

#if sys
import sys.FileSystem;
import sys.io.File;
#else
#error "Path requires a sys target (php, lua, cs, cpp, macro, python, java, neko, hl)"
#end

/**
	A `pathlib`-style path abstraction over a `String`, backed by forward-slash
	separators internally regardless of platform.

	`Path` wraps a normalized string (backslashes converted to `/`, trailing
	slashes trimmed) and provides path manipulation (`join`, `parent`,
	`withName`, ...) as well as filesystem operations (`exists`, `mkdir`,
	`readText`, ...).

	notes:
	- Backslashes are always normalized to `/`, so Windows-style input
	  (`C:\foo\bar`) and Unix-style input (`/foo/bar`) both work.
	- Windows drive roots (e.g. `"C:/"`) and UNC roots (e.g.
	  `"//server/share/"`) are recognized as absolute roots, just like `"/"`
	  is on Unix.
	- Drive-relative paths (e.g. `"C:foo"`, with no slash after the colon)
	  are treated as relative paths, since their meaning is ambiguous
	  without a current drive context.
	- Equality and all string comparisons are case-sensitive, even on
	  platforms with case-insensitive filesystems (e.g. Windows, default
	  macOS).

	Implicit conversions to/from `String` are supported, so a `Path` can be
	used anywhere a `String` is expected, and vice versa.
**/
@:transitive
@:analyzer(optimize, local_dce, fusion, user_var_fusion)
@:nullSafety(Strict) abstract Path(String) from String to String {
	/**
		Creates a new `Path` from `path`, normalizing separators and
		stripping any trailing slashes (except for a root, e.g. `"/"`,
		`"C:/"`, or `"//server/share/"`).
	**/
	public inline function new(path:String) {
		this = normalize(path);
	}

	/**
		Converts backslashes to forward slashes and removes trailing
		slashes, stopping at the root (if any) so that roots like `"/"`,
		`"C:/"`, or `"//server/share/"` are preserved.

		Returns `"."` if `p` is `null` or empty.
	**/
	static function normalize(p:String):String {
		if (p == null || p.length == 0)
			return ".";
		var s = p.split("\\").join("/");
		var rl = rootLength(s);
		while (s.length > rl && StringTools.endsWith(s, "/"))
			s = s.substr(0, s.length - 1);
		if (s.length == 0)
			return ".";
		return s;
	}

	/**
		Returns `true` if `s` begins with an ASCII letter followed by `:`
		(e.g. `"C:"`), the Windows drive-letter marker.
	**/
	static inline function isDriveLetter(s:String):Bool {
		if (s.length < 2 || s.charAt(1) != ":")
			return false;
		var c = s.charCodeAt(0);
		if (c == null)
			return false;
		return (c >= "a".code && c <= "z".code) || (c >= "A".code && c <= "Z".code);
	}

	/**
		Returns the length of the "root" prefix of `s`: `1` for a leading
		`"/"`, `3` for a Windows drive root like `"C:/"`, the length up to
		and including the share component for a UNC root like
		`"//server/share/"`, or `0` if `s` has no recognized root (i.e. is
		relative, or is a drive-relative path like `"C:foo"`).
	**/
	static function rootLength(s:String):Int {
		if (s == null || s.length == 0)
			return 0;
		if (StringTools.startsWith(s, "//")) {
			var shareEnd = s.indexOf("/", 2);
			if (shareEnd < 0)
				return s.length; // e.g. "//server"
			var afterShare = s.indexOf("/", shareEnd + 1);
			return afterShare < 0 ? s.length : afterShare + 1; // include trailing "/"
		}
		if (isDriveLetter(s) && s.length >= 3 && s.charAt(2) == "/")
			return 3; // e.g. "C:/"
		if (StringTools.startsWith(s, "/"))
			return 1;
		return 0;
	}

	/**
		Returns `true` if `s` is an absolute path: starts with `/` (which
		also covers UNC paths, since those start with `//`), or is a
		Windows drive root/absolute drive path like `"C:/foo"`.
	**/
	static function isAbsoluteStr(s:String):Bool {
		if (s == null || s.length == 0)
			return false;
		if (StringTools.startsWith(s, "/"))
			return true;
		if (isDriveLetter(s) && s.length >= 3 && s.charAt(2) == "/")
			return true;
		return false;
	}

	/**
		Joins this path with `other`, usable via the `/` operator
		(e.g. `path / "file.txt"`).

		If `other` is `null` or empty, this path is returned unchanged.
		If `other` is absolute (e.g. starts with `/`, or is a Windows
		drive/UNC path), it replaces this path entirely, mirroring the
		behavior of Python's `pathlib`.
	**/
	@:op(A / B)
	public inline function join(other:String):Path {
		if (other == null || other.length == 0)
			return new Path(this);
		var o = normalize(other);
		if (isAbsoluteStr(o))
			return new Path(o);
		return new Path(this + "/" + o);
	}

	/**
		Returns the final component of the path, i.e. everything after
		the last `/`.
	**/
	public var name(get, never):String;

	public function get_name():String {
		var parts = this.split("/");
		return parts[parts.length - 1];
	}

	/**
		Returns the final component without its suffix.

		A leading dot (as in dotfiles like `.bashrc`) is not treated as a
		suffix separator, so `.bashrc` returns `.bashrc` in full.
	**/
	public var stem(get, never):String;

	public function get_stem():String {
		var n = name;
		var dot = n.lastIndexOf(".");
		if (dot <= 0)
			return n; // no dot, or dotfile like ".bashrc"
		return n.substr(0, dot);
	}

	/**
		Returns the last file extension of the final component, including
		the leading dot (e.g. `".txt"`), or `""` if there is none.
	**/
	public var suffix(get, never):String;

	public function get_suffix():String {
		var n = name;
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
	public var suffixes(get, never):Array<String>;

	public function get_suffixes():Array<String> {
		var n = name;
		var parts = n.split(".");
		if (parts.length <= 1)
			return [];
		parts.shift();
		return [for (p in parts) "." + p];
	}

	/**
		Returns the logical parent directory of this path.

		Returns `"."` if this path has no `/`, or the root itself (e.g.
		`"/"`, `"C:/"`, `"//server/share/"`) if this path is a direct
		child of that root.
	**/
	public var parent(get, never):Path;

	public function get_parent():Path {
		var rl = rootLength(this);
		var idx = this.lastIndexOf("/");
		if (idx < 0)
			return new Path(".");
		if (idx < rl)
			return new Path(this.substr(0, rl));
		return new Path(this.substr(0, idx));
	}

	/**
		Returns all ancestor directories of this path, ordered from the
		immediate parent up to (and, if this path is absolute, including)
		its root (e.g. `"/"`, `"C:/"`, or `"//server/share/"`).
	**/
	public var parents(get, never):Array<Path>;

	public function get_parents():Array<Path> {
		var result:Array<Path> = [];
		var cur:Path = parent;
		while (true) {
			var partString = cur.toString();
			var rl = rootLength(partString);
			var isRoot = rl > 0 && rl == partString.length;
			if (partString == "." || isRoot)
				break;
			result.push(cur);
			var next = cur.parent;
			if (next.toString() == partString)
				break;
			cur = next;
		}
		if (isAbsolute()) {
			var rl = rootLength(this);
			result.push(new Path(this.substr(0, rl)));
		}
		return result;
	}

	/**
		Splits this path into its individual components.

		If the path is absolute, the first element is its root (e.g.
		`"/"`, `"C:/"`, or `"//server/share/"`).
	**/
	public function parts():Array<String> {
		var rl = rootLength(this);
		var root = rl > 0 ? this.substr(0, rl) : null;
		var rest = rl > 0 ? this.substr(rl) : this;
		var arr = rest.split("/").filter(function(s) return s.length > 0);
		if (root != null)
			arr.unshift(root);
		return arr;
	}

	/**
		Returns `true` if this path is absolute: starts with `/` (which
		also covers UNC paths), or is a Windows drive-rooted path like
		`"C:/foo"`. Drive-relative paths like `"C:foo"` are considered
		relative, since their meaning depends on an external current-drive
		context.
	**/
	public inline function isAbsolute():Bool {
		return isAbsoluteStr(this);
	}

	/**
		Returns a new path with the final component replaced by `newName`,
		keeping the same parent directory.
	**/
	public function withName(newName:String):Path {
		return parent / newName;
	}

	/**
		Returns a new path with the suffix of the final component replaced
		by `newSuffix` (which should include the leading dot, e.g. `".md"`).
	**/
	public function withSuffix(newSuffix:String):Path {
		return parent / (stem + newSuffix);
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
			directories along the way (like `mkdir -p`), walking up from
			this path to its nearest existing ancestor.
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
			var toCreate:Array<Path> = [];
			var cur:Path = this;
			while (cur.toString() != "." && !cur.exists()) {
				toCreate.push(cur);
				var next = cur.parent;
				if (next.toString() == cur.toString())
					break;
				cur = next;
			}
			toCreate.reverse();
			for (d in toCreate)
				FileSystem.createDirectory(d);
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
		Returns the current user's home directory as a `Path`.

		Tries, in order: the `HOME` environment variable (set on Unix, and
		often on Windows too, e.g. under Git Bash/MSYS or newer Windows
		versions); `HOMEDRIVE` + `HOMEPATH` (the classic Windows pair, e.g.
		`"C:"` + `"\Users\me"`); and finally `USERPROFILE` (modern
		Windows).
	**/
	public static function home():Path {
		var h = Sys.getEnv("HOME");
		if (h == null) {
			var drive = Sys.getEnv("HOMEDRIVE");
			var path = Sys.getEnv("HOMEPATH");
			if (drive != null && path != null)
				h = drive + path;
		}
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

		This comparison is always case-sensitive, even on platforms whose
		filesystems treat paths case-insensitively (e.g. Windows, default
		macOS).
	**/
	@:op(A == B)
	public inline function equals(other:Path):Bool {
		return this == other.toString();
	}
}
