# WorleyNoise

Worley (cellular) noise - distance to nearest random cell point.

```haxe
import haxe.addons.math.noises.WorleyNoise;
```

## Methods

```haxe
static function sample2D(x:Float, y:Float, seed:Int = 0):Float
```

Distance to nearest cell center point.

```haxe
static function edge2D(x:Float, y:Float, seed:Int = 0):Float
```

F1 - F2 edge pattern (difference between nearest and second-nearest distance).
