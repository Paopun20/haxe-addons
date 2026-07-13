# NoiseTypes

Common type aliases for noise function signatures.

```haxe
import haxe.addons.math.noises.NoiseTypes;
```

## Type Aliases

```haxe
typedef NoiseFunction = Float -> Float -> Int -> Float;
typedef Noise2D = Float -> Float -> Int -> Float;
typedef Noise3D = Float -> Float -> Float -> Int -> Float;
```

All take `(x, y [, z], seed)` and return a `Float` in `[-1, 1]`.

- `NoiseFunction` / `Noise2D` — 2D noise: `(x, y, seed) → value`
- `Noise3D` — 3D noise: `(x, y, z, seed) → value`
