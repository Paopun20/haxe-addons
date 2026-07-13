# ArrayTools

Static helper methods for arrays.

```haxe
import haxe.addons.tools.ArrayTools;
```

## Methods

| Method                                              | Description                              |
| --------------------------------------------------- | ---------------------------------------- |
| `shuffle<T>(arr:Array<T>):Array<T>`                 | Fisher-Yates shuffle (returns new array) |
| `forEach<T>(arr:Array<T>, f:T->Void):Void`          | Inline iteration                         |
| `randomItem<T>(arr:Array<T>):Null<T>`               | Random element                           |
| `first<T>(arr:Array<T>):Null<T>`                    | First element                            |
| `last<T>(arr:Array<T>):Null<T>`                     | Last element                             |
| `flatten<T>(arr:Array<Array<T>>):Array<T>`          | Flatten nested arrays                    |
| `removeDuplicates<T>(arr:Array<T>):Array<T>`        | Remove duplicate values                  |
| `isEmpty<T>(arr:Array<T>):Bool`                     | Check if empty                           |
| `clear<T>(arr:Array<T>):Array<T>`                   | Remove all elements                      |
| `sum(arr:Array<Float>):Float`                       | Arithmetic sum                           |
| `average(arr:Array<Float>):Float`                   | Arithmetic mean                          |
| `minOf(arr:Array<Float>):Float`                     | Minimum value                            |
| `maxOf(arr:Array<Float>):Float`                     | Maximum value                            |
| `chunk<T>(arr:Array<T>, size:Int):Array<Array<T>>`  | Split into fixed-size chunks             |
| `rotate<T>(arr:Array<T>, n:Int):Array<T>`           | Left rotate by `n` positions             |
| `count<T>(arr:Array<T>, pred:T->Bool):Int`          | Count elements matching predicate        |
| `any<T>(arr:Array<T>, pred:T->Bool):Bool`           | Any element matches                      |
| `all<T>(arr:Array<T>, pred:T->Bool):Bool`           | All elements match                       |
| `zip<A,B>(a:Array<A>, b:Array<B>):Array<{a:A,b:B}>` | Zip two arrays into pairs                |
