# Deque

A double-ended queue (deque) implementation with optional max-length bound.

```haxe
import haxe.addons.collections.Deque;
```

## Constructor

```haxe
new(?maxlen:Int = 0)
```

Creates an empty deque. If `maxlen > 0`, the deque is bounded — pushing beyond the limit evicts elements from the opposite end.

## Properties

| Property | Type  | Description        |
| -------- | ----- | ------------------ |
| `length` | `Int` | Number of elements |

## Methods

### append(value:T):Void

Push to the right end. Evicts leftmost element if bounded and full.

### appendLeft(value:T):Void

Push to the left end. Evicts rightmost element if bounded and full.

### pop():Null<T\>

Remove and return the rightmost element. Returns `null` if empty.

### popLeft():Null<T\>

Remove and return the leftmost element. Returns `null` if empty.

### iterator():Iterator<T\>

Iterate from left to right.

## Static Methods

### fromArray<T\>(array:Array<T\>):Deque<T\>

Create a deque from an existing array.

## Operators

| Operator               | Description           |
| ---------------------- | --------------------- |
| `deque[index]`         | Array-access read     |
| `deque[index] = value` | Array-access write    |
| `for (item in deque)`  | Iterator              |
| `String(deque)`        | String representation |

## Example

```haxe
var d = new Deque<Int>(3);
d.append(1);
d.append(2);
d.append(3);
d.append(4); // evicts 1
trace(d.popLeft()); // 2
```
