# ArrayOfBabel

A self-referential infinite array — every element is itself.

```haxe
import haxe.addons.useless.ArrayOfBabel;
```

```haxe
new()
```

Creates an array where `arr[0] == arr`, `arr[0][0] == arr`, and so on infinitely.

```haxe
static function fromArray(arr:Array<ArrayOfBabel>):ArrayOfBabel
```

## Operator

| Operator      | Description                           |
| ------------- | ------------------------------------- |
| `arr[index]`  | Returns `arr` itself                  |
| `String(arr)` | Infinite recursion (use with caution) |
