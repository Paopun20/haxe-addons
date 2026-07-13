# BlackHole

An array that consumes everything and returns nothing.

```haxe
import haxe.addons.useless.BlackHole;
```

```haxe
new()
```

## Methods

| Method                | Description                     |
| --------------------- | ------------------------------- |
| `push(value:T):Int`   | Devours value, always returns 0 |
| `this[index]`         | Always returns `null`           |
| `this[index] = value` | Consumes value silently         |

## Properties

| Property | Value        |
| -------- | ------------ |
| `length` | `0` (always) |

## Example

```haxe
var bh = new BlackHole<Int>();
bh.push(42);
bh.push(999);
trace(bh.length); // 0
trace(bh[0]);     // null
```
