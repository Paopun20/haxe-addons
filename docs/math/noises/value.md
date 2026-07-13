# ValueNoise

Value noise interpolates random lattice values for a smooth, grid-based noise.

```haxe
import haxe.addons.math.noises.ValueNoise;
```

## Methods

| Method                                                                  | Description           |
| ----------------------------------------------------------------------- | --------------------- |
| `sample2D(x:Float, y:Float, seed:Int=0):Float`                          | 2D value noise sample |
| `fbm2D(x, y, octaves=5, persistence=0.5, lacunarity=2.0, seed=0):Float` | 2D FBM                |
