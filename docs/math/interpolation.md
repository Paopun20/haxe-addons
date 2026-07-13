# Interpolation

Static utility class providing common interpolation and easing functions.

```haxe
import haxe.addons.math.Interpolation;
```

## Methods

### lerp(a:Float, b:Float, t:Float):Float

Linear interpolation between `a` and `b` by `t`.

### clamp(t:Float, min:Float = 0, max:Float = 1):Float

Clamp `t` to the range `[min, max]`.

### smoothStep(edge0:Float, edge1:Float, v:Float):Float

3rd-order Hermite interpolation (smoothstep).

### smootherStep(edge0:Float, edge1:Float, v:Float):Float

5th-order smoother interpolation.

### easeInQuad(t:Float):Float

Quadratic ease-in.

### easeOutQuad(t:Float):Float

Quadratic ease-out.

### easeInOutQuad(t:Float):Float

Quadratic ease-in-out.

### easeInCubic(t:Float):Float

Cubic ease-in.

### easeOutCubic(t:Float):Float

Cubic ease-out.

### easeInOutCubic(t:Float):Float

Cubic ease-in-out.

### exponential(t:Float, power:Float = 2):Float

Exponential tween.

### bounce(t:Float):Float

Bounce easing — simulates a bouncing ball.

### pingPong(t:Float):Float

Oscillates `t` between 0 and 1 in a sawtooth pattern (`0 → 1 → 0 → 1 → ...`).
