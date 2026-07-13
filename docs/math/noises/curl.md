# CurlNoise

Curl noise — generates divergence-free vector fields from scalar noise inputs. Useful for fluid-like motion and particle systems.

```haxe
import haxe.addons.math.noises.CurlNoise;
```

## Methods

```haxe
static function sample2D(noise:NoiseFunction, x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Vector2
```

Compute 2D curl from an arbitrary scalar noise function.

```haxe
static function simplex(x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Vector2
```

Curl using simplex noise as the scalar field.

```haxe
static function fbm(x:Float, y:Float, strength:Float = 1.0, octaves:Int = 5, seed:Int = 0):Vector2
```

Curl from an FBM-combined simplex noise field.
