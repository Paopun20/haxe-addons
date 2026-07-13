# Path

A [pathlib](https://docs.python.org/3/library/pathlib.html)-style abstraction for filesystem path manipulation.

```haxe
import haxe.addons.system.Path;
```

## Constructor

```haxe
new(path:String)
```

Creates a normalized `Path` from a string.

## Static Methods

| Method        | Description               |
| ------------- | ------------------------- |
| `cwd():Path`  | Current working directory |
| `home():Path` | User home directory       |

## Properties

| Property   | Type            | Description                             |
| ---------- | --------------- | --------------------------------------- |
| `name`     | `String`        | Final path component                    |
| `stem`     | `String`        | Name without extension                  |
| `parent`   | `Path`          | Logical parent directory                |
| `parents`  | `Array<Path>`   | All ancestor directories                |
| `suffix`   | `String`        | File extension (with dot)               |
| `suffixes` | `Array<String>` | All extensions (e.g. `[".tar", ".gz"]`) |

## Methods

| Method                                     | Description                   |
| ------------------------------------------ | ----------------------------- |
| `join(other:String):Path`                  | Join paths (via `/` operator) |
| `parts():Array<String>`                    | Split path into components    |
| `isAbsolute():Bool`                        | Absolute path check           |
| `withName(newName:String):Path`            | Replace final component       |
| `withSuffix(newSuffix:String):Path`        | Replace extension             |
| `resolve():Path`                           | Resolve to absolute           |
| `exists():Bool`                            | Filesystem existence check    |
| `isFile():Bool`                            | Regular file check            |
| `isDir():Bool`                             | Directory check               |
| `stat():sys.FileStat`                      | Filesystem metadata           |
| `mkdir(parents=false, existOk=false):Void` | Create directory              |
| `iterdir():Array<Path>`                    | List directory entries        |
| `readText():String`                        | Read file as text             |
| `writeText(content:String):Void`           | Write text                    |
| `readBytes():haxe.io.Bytes`                | Read file as bytes            |
| `writeBytes(bytes:haxe.io.Bytes):Void`     | Write bytes                   |
| `touch():Void`                             | Create empty file if absent   |
| `unlink(missingOk=false):Void`             | Delete file                   |
| `rmdir():Void`                             | Delete empty directory        |
| `rename(target:String):Path`               | Rename / move                 |

## Operators

| Operator          | Description           |
| ----------------- | --------------------- |
| `path / "subdir"` | Path joining          |
| `path == other`   | Equality comparison   |
| `String(path)`    | String representation |

## Example

```haxe
var p = new Path("/home/user/docs") / "file.txt";
trace(p.stem);     // "file"
trace(p.suffix);   // ".txt"
trace(p.parent);   // /home/user/docs
```
