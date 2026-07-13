# Int8

A signed 8-bit integer type with wrapping arithmetic.

```haxe
import haxe.addons.types.Int8;
```

On supported targets (`cpp`, `cs`, `java`), this maps to the native `Int8` type with bounds checking. On other targets it uses a wrapped `Int` under the hood.

## Constructor

```haxe
new(value:Int = 0)
```

Creates an `Int8` with the value normalized to `[-128, 127]`.

## Operators

| Operator     | Description                  |
| ------------ | ---------------------------- |
| `a + b`      | Addition (wrapping)          |
| `a - b`      | Subtraction (wrapping)       |
| `a * b`      | Multiplication (wrapping)    |
| `a / b`      | Integer division             |
| `a % b`      | Modulo                       |
| `-a`         | Negation                     |
| `a & b`      | Bitwise AND                  |
| `a \| b`     | Bitwise OR                   |
| `a ^ b`      | Bitwise XOR                  |
| `a << b`     | Left shift                   |
| `a >> b`     | Right shift (arithmetic)     |
| `Int(value)` | Implicit conversion to `Int` |

## Example

```haxe
var a:Int8 = 100;
var b:Int8 = 50;
trace(a + b); // -106 (wraps past 127)
```
