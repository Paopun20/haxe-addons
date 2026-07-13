# SimplexNoise

Simplex noise implementation.

```haxe
import haxe.addons.math.noises.SimplexNoise;
```

## Methods

| Method                                                                  | Description             |
| ----------------------------------------------------------------------- | ----------------------- |
| `sample2D(x:Float, y:Float, seed:Int=0):Float`                          | 2D simplex noise sample |
| `fbm2D(x, y, octaves=5, persistence=0.5, lacunarity=2.0, seed=0):Float` | 2D FBM                  |
