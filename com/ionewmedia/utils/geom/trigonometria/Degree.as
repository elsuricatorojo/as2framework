/**
* The Degree class includes wrappers for the built-in Math functions
* (sin, cos, tan, and their inverses) that allow you
* to work with angles in degrees instead of radians.
* 
* @author Robert Penner (AS 1.0)
* © 2002 Robert Penner
* http://www.robertpenner.com
* 
* @author Mark Walters (AS 2.0)
* © 2006 DigitalFlipbook
* http://www.digitalflipbook.com
* 
* @version	1.0
* 
* @since	ActionScript 2.0; Flash Player 6
*/
class com.ionewmedia.utils.geom.trigonometria.Degree {
	/*
	* *********************************************************
	* CONSTRUCTOR
	* *********************************************************
	*
	*/
	function Degree() {
	}
	/*
	* *********************************************************
	* PUBLIC METHODS
	* *********************************************************
	* 
	*/
	/**
	* Takes an angle in degrees and returns its sine.
	* 
	* @param	angle	The angle in degrees.
	* @return	Returns the sine of the angle.
	* 
	* @usage	<pre><code>trace (Degree.sinD(90));</code></pre>
	*/
	public static function sinD(angle:Number):Number {
		return Math.sin(angle*(Math.PI/180));
	}
	/**
	* Takes an angle in degrees and returns its cosine.
	* 
	* @param	angle	The angle in degrees.
	* @return	Returns the cosine of the angle.
	* 
	* @usage	<pre><code>trace (Degree.cosD(0));</code></pre>
	*/
	public static function cosD(angle:Number):Number {
		return Math.cos(angle*(Math.PI/180));
	}
	/**
	* Takes an angle in degrees and returns its tangent.
	* 
	* @param	angle	The angle in degrees.
	* @return	Returns the tangent of the angle.
	* 
	* @usage	<pre><code>trace (Degree.tanD(45));</code></pre>
	*/
	public static function tanD(angle:Number):Number {
		return Math.tan(angle*(Math.PI/180));
	}
	/**
	* Takes the inverse sine of a slope ratio and returns its angle in degrees.
	* 
	* @param	ratio	The slope ratio.
	* @return	Returns the angle in degrees.
	* 
	* @usage	<pre><code>trace (Degree.asinD(1));</code></pre>
	*/
	public static function asinD(ratio:Number):Number {
		return Math.asin(ratio)*(180/Math.PI);
	}
	/**
	* Takes the inverse cosine of a slope ratio and returns its angle in degrees.
	* 
	* @param	ratio	The slope ratio.
	* @return	Returns the angle in degrees.
	* 
	* @usage	<pre><code>trace (Degree.acosD(1));</code></pre>
	*/
	public static function acosD(ratio:Number):Number {
		return Math.acos(ratio)*(180/Math.PI);
	}
	/**
	* Takes the inverse tangent of a slope ratio and returns its angle in degrees.
	* 
	* @param	ratio	The slope ratio.
	* @return	Returns the angle in degrees.
	* 
	* @usage	<pre><code>trace (Degree.atanD(1));</code></pre>
	*/
	public static function atanD(ratio:Number):Number {
		return Math.atan(ratio)*(180/Math.PI);
	}
	/**
	* Takes the inverse tangent of a slope ratio and returns its angle in degrees.
	* 
	* @param	y	The y coordinate of the slope ratio.
	* @param	x	The x coordinate of the slope ratio.
	* @return	Returns the angle in degrees.
	* 
	* @usage	<pre><code>trace (Degree.atan2D(7, 7));</code></pre>
	*/
	public static function atan2D(y:Number, x:Number):Number {
		return Math.atan2(y, x)*(180/Math.PI);
	}
}
