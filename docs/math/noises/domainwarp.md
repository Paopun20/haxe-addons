# DomainWarp

Domain warping — distorts the input coordinates by a noise field before sampling, creating organic, swirling patterns.

```haxe
import haxe.addons.math.noises.DomainWarp;
```

## Methods

```haxe
static function warp2D(noise:NoiseFunction, warpNoise:NoiseFunction, x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Float
```

Generic domain warping using two noise functions.

```haxe
static function simplexWarp(x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Float
```

Domain warp using simplex noise.

```haxe
static function fbmWarp(x:Float, y:Float, strength:Float = 1.0, octaves:Int = 5, seed:Int = 0):Float
```

Domain warp using FBM simplex noise.
