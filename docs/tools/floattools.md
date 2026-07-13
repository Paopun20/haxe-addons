# FloatTools

Static utility class for float operations.

```haxe
import haxe.addons.tools.FloatTools;
```

## Methods

| Method                                             | Description                           |
| -------------------------------------------------- | ------------------------------------- |
| `clamp(t:Float, min:Float, max:Float):Float`       | Clamp to range                        |
| `lerp(a:Float, b:Float, t:Float):Float`            | Linear interpolation                  |
| `remap(v, inMin, inMax, outMin, outMax):Float`     | Remap between ranges                  |
| `snap(v:Float, step:Float):Float`                  | Snap to nearest step                  |
| `sign(v:Float):Int`                                | Sign (-1, 0, 1)                       |
| `between(v, min, max):Bool`                        | Inclusive range check                 |
| `abs(v:Float):Float`                               | Absolute value                        |
| `toInt(v:Float):Int`                               | Truncate to integer                   |
| `roundTo(v:Float, decimals:Int):Float`             | Round to N decimal places             |
| `pingPong(v:Float, length:Float):Float`            | Oscillate `0 → length → 0 → ...`      |
| `randomRange(min:Float, max:Float):Float`          | Random float in range                 |
| `chance(percent:Float):Bool`                       | Percentage probability roll           |
| `wrap(v:Int, min:Int, max:Int):Int`                | Integer wrapping                      |
| `randomInt(min:Int, max:Int):Int`                  | Random integer in range               |
| `smoothStep(edge0, edge1, v):Float`                | 3rd-order smooth interpolation        |
| `smootherStep(edge0, edge1, v):Float`              | 5th-order smooth interpolation        |
| `inverseLerp(a, b, v):Float`                       | Inverse linear interpolation          |
| `deadzone(v, threshold):Float`                     | Zero within threshold                 |
| `approach(current, target, step):Float`            | Step toward target without overshoot  |
| `oscillate(time, freq, amplitude, offset=0):Float` | Sinusoidal oscillation                |
| `toRad(deg:Float):Float`                           | Degrees to radians (`deg * PI / 180`) |
| `toDeg(rad:Float):Float`                           | Radians to degrees (`rad * 180 / PI`) |
