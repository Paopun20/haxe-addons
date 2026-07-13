# OpenSimplex2

OpenSimplex2 noise implementation — improved simplex noise with fewer directional artifacts.

```haxe
import haxe.addons.math.noises.OpenSimplex2;
```

## Methods

| Method                                                                     | Description     |
| -------------------------------------------------------------------------- | --------------- |
| `sample2D(x:Float, y:Float, seed:Int=0):Float`                             | 2D noise sample |
| `sample3D(x:Float, y:Float, z:Float, seed:Int=0):Float`                    | 3D noise sample |
| `fbm2D(x, y, octaves=5, persistence=0.5, lacunarity=2.0, seed=0):Float`    | 2D FBM          |
| `fbm3D(x, y, z, octaves=5, persistence=0.5, lacunarity=2.0, seed=0):Float` | 3D FBM          |
