# MathTypes

Common math-related type aliases.

```haxe
import haxe.addons.math.MathTypes;
```

## Vector2\<T = Float\>

```haxe
typedef Vector2<T = Float> = { x:T; y:T; }
```

A 2D vector structure.

## Vector3\<T = Float\>

```haxe
typedef Vector3<T = Float> = { x:T; y:T; z:T; }
```

A 3D vector structure.

Both default to `Float` components but can be used with any type:

```haxe
var v2:Vector2<Int> = { x: 1, y: 2 };
var v3:Vector3 = { x: 1.0, y: 2.0, z: 3.0 };
```
