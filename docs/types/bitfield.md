# BitField

An 8-bit bitfield abstraction backed by `Int`.

```haxe
import haxe.addons.types.BitField;
```

## Constructor

```haxe
new(value:Int = 0)
```

Creates a bitfield, masked to 8 bits (`0xFF`).

## Properties

| Property      | Type   | Description          |
| ------------- | ------ | -------------------- |
| `length`      | `Int`  | Number of bits (8)   |
| `this[index]` | `Bool` | Get/set bit by index |

## Methods

| Method                               | Description                                |
| ------------------------------------ | ------------------------------------------ |
| `set(bit:Int):Void`                  | Set bit to 1                               |
| `clear(bit:Int):Void`                | Clear bit to 0                             |
| `toggle(bit:Int):Void`               | Toggle bit                                 |
| `has(bit:Int):Bool`                  | Check if bit is set                        |
| `setValue(bit:Int, value:Bool):Void` | Set bit to specific value                  |
| `reset():Void`                       | Clear all bits                             |
| `fill(value:Bool):Void`              | Fill all bits                              |
| `toString():String`                  | Binary string (MSB first, e.g. `00101101`) |

## Operators

| Operator      | Description            |
| ------------- | ---------------------- |
| `a \| b`      | Bitwise OR             |
| `a & b`       | Bitwise AND            |
| `a ^ b`       | Bitwise XOR            |
| `~a`          | Bitwise NOT            |
| `Bool(value)` | True if any bit is set |

## Example

```haxe
var bf = new BitField();
bf.set(0);
bf.set(3);
trace(bf.has(0)); // true
trace(bf);        // "00001001"
```
