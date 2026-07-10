package haxe.addons.math;

import haxe.addons.math.MathTypes.Vector2;
import haxe.addons.math.noises.*;
import haxe.addons.math.noises.NoiseTypes.Noise2D;
import haxe.addons.math.noises.NoiseTypes.Noise3D;
import haxe.addons.math.noises.NoiseTypes.NoiseFunction;

class Noise {
	public static inline function cellularSample2D(x:Float, y:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		return CellularNoise.sample2D(x, y, seed, jitter);
	}

	public static inline function cellularEdge2D(x:Float, y:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		return CellularNoise.edge2D(x, y, seed, jitter);
	}

	public static inline function cellularSample3D(x:Float, y:Float, z:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		return CellularNoise.sample3D(x, y, z, seed, jitter);
	}

	public static inline function cellularEdge3D(x:Float, y:Float, z:Float, seed:Int = 0, jitter:Float = 1.0):Float {
		return CellularNoise.edge3D(x, y, z, seed, jitter);
	}

	public static inline function curlSample2D(noise:NoiseFunction, x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Vector2 {
		return CurlNoise.sample2D(noise, x, y, strength, seed);
	}

	public static inline function curlSimplex(x:Float, y:Float, strength:Float = 1.0, seed:Int = 0):Vector2 {
		return CurlNoise.simplex(x, y, strength, seed);
	}

	public static inline function curlFbm(x:Float, y:Float, strength:Float = 1.0, octaves:Int = 5, seed:Int = 0):Vector2 {
		return CurlNoise.fbm(x, y, strength, octaves, seed);
	}

	public static inline function fractalFbm(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0,
			seed:Int = 0):Float {
		return Fractal.fbm(noise, x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function fractalBillow(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0,
			seed:Int = 0):Float {
		return Fractal.billow(noise, x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function fractalRidged(noise:NoiseFunction, x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0,
			seed:Int = 0):Float {
		return Fractal.ridged(noise, x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function noiseMapBuild2D(width:Int, height:Int, noise:Noise2D, scale:Float = 1.0, xOffset:Float = 0.0, yOffset:Float = 0.0,
			seed:Int = 0):Array<Array<Float>> {
		return NoiseMap.build2D(width, height, noise, scale, xOffset, yOffset, seed);
	}

	public static inline function noiseMapBuild3D(width:Int, height:Int, depth:Int, noise:Noise3D, scale:Float = 1.0, xOffset:Float = 0.0,
			yOffset:Float = 0.0, zOffset:Float = 0.0, seed:Int = 0):Array<Array<Array<Float>>> {
		return NoiseMap.build3D(width, height, depth, noise, scale, xOffset, yOffset, zOffset, seed);
	}

	public static inline function openSimplex2Sample2D(x:Float, y:Float, seed:Int = 0):Float {
		return OpenSimplex2.sample2D(x, y, seed);
	}

	public static inline function openSimplex2Sample3D(x:Float, y:Float, z:Float, seed:Int = 0):Float {
		return OpenSimplex2.sample3D(x, y, z, seed);
	}

	public static inline function openSimplex2Fbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		return OpenSimplex2.fbm2D(x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function openSimplex2Fbm3D(x:Float, y:Float, z:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0,
			seed:Int = 0):Float {
		return OpenSimplex2.fbm3D(x, y, z, octaves, persistence, lacunarity, seed);
	}

	public static inline function perlinSample2D(x:Float, y:Float, seed:Int = 0):Float {
		return PerlinNoise.sample2D(x, y, seed);
	}

	public static inline function perlinFbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		return PerlinNoise.fbm2D(x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function simplexSample2D(x:Float, y:Float, seed:Int = 0):Float {
		return SimplexNoise.sample2D(x, y, seed);
	}

	public static inline function simplexFbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		return SimplexNoise.fbm2D(x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function valueSample2D(x:Float, y:Float, seed:Int = 0):Float {
		return ValueNoise.sample2D(x, y, seed);
	}

	public static inline function valueFbm2D(x:Float, y:Float, octaves:Int = 5, persistence:Float = 0.5, lacunarity:Float = 2.0, seed:Int = 0):Float {
		return ValueNoise.fbm2D(x, y, octaves, persistence, lacunarity, seed);
	}

	public static inline function worleySample2D(x:Float, y:Float, seed:Int = 0):Float {
		return WorleyNoise.sample2D(x, y, seed);
	}

	public static inline function worleyEdge2D(x:Float, y:Float, seed:Int = 0):Float {
		return WorleyNoise.edge2D(x, y, seed);
	}
}
