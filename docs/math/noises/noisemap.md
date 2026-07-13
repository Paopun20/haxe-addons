# NoiseMap

Generate and manipulate noise maps — 2D/3D grids sampled from a noise function.

```haxe
import haxe.addons.math.noises.NoiseMap;
```

## Methods

```haxe
static function build2D(width:Int, height:Int, noise:Noise2D, scale:Float = 1.0, xOff:Float = 0.0, yOff:Float = 0.0, seed:Int = 0):Array<Array<Float>>
```

Generate a 2D noise map of size `width × height`.

```haxe
static function build3D(width:Int, height:Int, depth:Int, noise:Noise3D, scale:Float = 1.0, xOff:Float = 0.0, yOff:Float = 0.0, zOff:Float = 0.0, seed:Int = 0):Array<Array<Array<Float>>>
```

Generate a 3D noise map of size `width × height × depth`.
