# StringTools

Static utility class for string operations.

```haxe
import haxe.addons.tools.StringTools;
```

## Methods

| Method                                                    | Description                 |
| --------------------------------------------------------- | --------------------------- |
| `isNullOrEmpty(s:String):Bool`                            | Null or empty check         |
| `capitalize(s:String):String`                             | Capitalize first letter     |
| `trimTo(s:String, max:Int, ellipsis:String="..."):String` | Truncate with ellipsis      |
| `padLeft(s:String, len:Int, char:String="0"):String`      | Left-pad string             |
| `padRight(s:String, len:Int, char:String=" "):String`     | Right-pad string            |
| `contains(s:String, sub:String):Bool`                     | Substring check             |
| `repeat(s:String, times:Int):String`                      | Repeat string N times       |
| `toIntSafe(s:String, fallback:Int=0):Int`                 | Safe integer parse          |
| `toFloatSafe(s:String, fallback:Float=0):Float`           | Safe float parse            |
| `reverse(s:String):String`                                | Reverse string              |
| `countOccurrences(s:String, sub:String):Int`              | Count substring occurrences |
| `wordWrap(s:String, maxLen:Int):Array<String>`            | Word-wrap text to lines     |
