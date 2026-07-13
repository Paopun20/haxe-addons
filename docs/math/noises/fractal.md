# Fractal

Fractal noise combiners — layer multiple octaves of a base noise function.

```haxe
import haxe.addons.math.noises.Fractal;
```

## Methods

```haxe
static function fbm(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float
```

Standard Fractional Brownian Motion.

```haxe
static function billow(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float
```

Billow fractal (abs value of noise before weighting).

```haxe
static function ridged(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float
```

Ridged fractal (`1 - abs(noise)`) for sharp ridge-like features.
