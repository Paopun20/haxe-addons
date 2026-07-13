# CellularNoise

Cellular (Voronoi) noise — nearest-distance-to-cell-center sampling.

```haxe
import haxe.addons.math.noises.CellularNoise;
```

## Methods

| Method                                                                    | Description                        |
| ------------------------------------------------------------------------- | ---------------------------------- |
| `sample2D(x:Float, y:Float, seed:Int=0, jitter:Float=1.0):Float`          | Distance to nearest cell center    |
| `edge2D(x:Float, y:Float, seed:Int=0, jitter:Float=1.0):Float`            | F2 - F1 edge detection             |
| `sample3D(x:Float, y:Float, z:Float, seed:Int=0, jitter:Float=1.0):Float` | 3D distance to nearest cell center |
| `edge3D(x:Float, y:Float, z:Float, seed:Int=0, jitter:Float=1.0):Float`   | 3D edge detection                  |
