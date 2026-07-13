# QuantumBoolean

Schrödinger's boolean — simultaneously `true` and `false` until observed.

```haxe
import haxe.addons.useless.QuantumBoolean;
```

```haxe
new()
```

Initializes to `true` (the unobserved state).

## Methods

| Method                                          | Description                               |
| ----------------------------------------------- | ----------------------------------------- |
| `observe():Bool`                                | "Measure" — collapses to a random boolean |
| `collapse():Bool`                               | Direct value read without random collapse |
| `entangle(other:QuantumBoolean):QuantumBoolean` | Entangle two quantum booleans             |

## Operators

| Operator      | Description                                   |
| ------------- | --------------------------------------------- |
| `Bool(value)` | Collapses to random boolean (observer effect) |

## Example

```haxe
var q = new QuantumBoolean();
trace(q.observe()); // true or false (random)
trace(q.observe()); // different each time
```
