# UInt8

An unsigned 8-bit integer type with wrapping arithmetic.

```haxe
import haxe.addons.types.UInt8;
```

On supported targets (`cpp`, `cs`) this maps to the native `UInt8` type. On other targets it uses a wrapped `Int`.

## Constructor

```haxe
new(v:Int)
```

Creates a `UInt8` with the value wrapped to `[0, 255]`.

## Operators

| Operator            | Description               |
| ------------------- | ------------------------- |
| `a + b`             | Addition (wrapping)       |
| `a - b`             | Subtraction (wrapping)    |
| `a * b`             | Multiplication (wrapping) |
| `a / b`             | Integer division          |
| `a % b`             | Modulo                    |
| `-a`                | Negation                  |
| `a & b`             | Bitwise AND               |
| `a \| b`            | Bitwise OR                |
| `a ^ b`             | Bitwise XOR               |
| `~a`                | Bitwise NOT               |
| `a << b`            | Left shift                |
| `a >> b`            | Right shift               |
| `a == b` / `a != b` | Equality                  |
| `a < b` / `a <= b`  | Less than                 |
| `a > b` / `a >= b`  | Greater than              |

## Methods

| Method                            | Description                                    |
| --------------------------------- | ---------------------------------------------- |
| `toUInt8():Int`                   | Unsigned integer view                          |
| `isNegative():Bool`               | Sign check (always false for `UInt8` in range) |
| `abs():UInt8`                     | Absolute value                                 |
| `clamp(lo:UInt8, hi:UInt8):UInt8` | Clamp to range                                 |
| `toString():String`               | String representation                          |
| `Int(value)`                      | Implicit conversion to `Int`                   |

## Example

```haxe
var u:UInt8 = 200;
var v:UInt8 = 100;
trace(u + v); // 44 (wraps at 256)
```
