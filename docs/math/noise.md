# Noise API

Facade class that provides static shortcuts to all noise generation algorithms.

```haxe
import haxe.addons.math.Noise;
```

## Methods

### Cellular / Worley Noise

| Method                                          | Return  |
| ----------------------------------------------- | ------- |
| `cellularSample2D(x, y, seed=0, jitter=1.0)`    | `Float` |
| `cellularEdge2D(x, y, seed=0, jitter=1.0)`      | `Float` |
| `cellularSample3D(x, y, z, seed=0, jitter=1.0)` | `Float` |
| `cellularEdge3D(x, y, z, seed=0, jitter=1.0)`   | `Float` |

### Curl Noise

| Method                                            | Return    |
| ------------------------------------------------- | --------- |
| `curlSample2D(noise, x, y, strength=1.0, seed=0)` | `Vector2` |
| `curlSimplex(x, y, strength=1.0, seed=0)`         | `Vector2` |
| `curlFbm(x, y, strength=1.0, octaves=5, seed=0)`  | `Vector2` |

### Fractal Noise

| Method                                                                           | Return  |
| -------------------------------------------------------------------------------- | ------- |
| `fractalFbm(noise, x, y, octaves=5, persistence=0.5, lacunarity=2.0, seed=0)`    | `Float` |
| `fractalBillow(noise, x, y, octaves=5, persistence=0.5, lacunarity=2.0, seed=0)` | `Float` |
| `fractalRidged(noise, x, y, octaves=5, persistence=0.5, lacunarity=2.0, seed=0)` | `Float` |

### Noise Maps

| Method                                                                                          | Return                       |
| ----------------------------------------------------------------------------------------------- | ---------------------------- |
| `noiseMapBuild2D(width, height, noise, scale=1.0, xOff=0.0, yOff=0.0, seed=0)`                  | `Array<Array<Float>>`        |
| `noiseMapBuild3D(width, height, depth, noise, scale=1.0, xOff=0.0, yOff=0.0, zOff=0.0, seed=0)` | `Array<Array<Array<Float>>>` |

### OpenSimplex2

| Method                                       | Return  |
| -------------------------------------------- | ------- |
| `openSimplex2Sample2D(x, y, seed=0)`         | `Float` |
| `openSimplex2Sample3D(x, y, z, seed=0)`      | `Float` |
| `openSimplex2Fbm2D(x, y, octaves=5, ...)`    | `Float` |
| `openSimplex2Fbm3D(x, y, z, octaves=5, ...)` | `Float` |

### Perlin Noise

| Method                              | Return  |
| ----------------------------------- | ------- |
| `perlinSample2D(x, y, seed=0)`      | `Float` |
| `perlinFbm2D(x, y, octaves=5, ...)` | `Float` |

### Simplex Noise

| Method                               | Return  |
| ------------------------------------ | ------- |
| `simplexSample2D(x, y, seed=0)`      | `Float` |
| `simplexFbm2D(x, y, octaves=5, ...)` | `Float` |

### Value Noise

| Method                             | Return  |
| ---------------------------------- | ------- |
| `valueSample2D(x, y, seed=0)`      | `Float` |
| `valueFbm2D(x, y, octaves=5, ...)` | `Float` |

### Worley Noise

| Method                         | Return  |
| ------------------------------ | ------- |
| `worleySample2D(x, y, seed=0)` | `Float` |
| `worleyEdge2D(x, y, seed=0)`   | `Float` |
