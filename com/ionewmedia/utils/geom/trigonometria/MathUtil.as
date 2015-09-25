import com.ionewmedia.utils.geom.trigonometria.Degree;
/**
* The MathUtil class includes a collection of trigonometry and coordinate system utilities.
* 
* @author Robert Penner (AS 1.0)
* © 2002 Robert Penner
* http://www.robertpenner.com
* 
* @author Richard Wright (AS 2.0 Constants)
* © 2004 Richard Wright
* wisolutions2002@shaw.ca
* 
* @author Mark Walters (AS 2.0)
* © 2006 DigitalFlipbook
* http://www.digitalflipbook.com
* 
* @version	1.0
* 
* @since	ActionScript 2.0; Flash Player 6
*/
class com.ionewmedia.utils.geom.trigonometria.MathUtil {
	/**
	* Change degrees to radians<br>
	* <pre><code>Math.PI/180</code></pre>
	* 
	* @usage	<pre><code>trace (Constant.DEG2RAD * 180);</code></pre>
	*/
	public static var DEG2RAD:Number = 0.0174532925199433;
	/**
	* Change radians to degrees<br>
	* <pre><code>180/Math.PI</code></pre>
	* 
	* @usage	<pre><code>trace (Constant.RAD2DEG * Math.PI);</code></pre>
	*/
	public static var RAD2DEG:Number = 57.2957795130823;
	/**
	* The golden mean (phi)<br>
	* <pre><code>(1+Math.sqrt(5))/2</code></pre>
	* 
	* @usage	<pre><code>trace (Constant.PHI);</code></pre>
	*/
	public static var PHI:Number = 1.61803398874989;
	/**
	* Euler-Mascheroni constant (lambda or C)<br>
	* <pre><code>
	    * 		( n )
	    * 	lim	( sigma 1/k - ln(n) )
	    * 	n->oo	( k=1 )
	* </code></pre>
	* 
	* @usage	<pre><code>trace (Constant.LAMBDA);</code></pre>
	*/
	public static var LAMBDA:Number = 0.57721566490143;
	/*
	* *********************************************************
	* CONSTRUCTOR
	* *********************************************************
	*
	*/
	function MathUtil() {
	}
	/*
	* *********************************************************
	* PUBLIC METHODS
	* *********************************************************
	* 
	*/
	/**
	* Finds the distance between two points.
	* 
	* @param	x1	The x value of the first point.
	* @param	y1	The y value of the first point.
	* @param	x2	The x value of the second point.
	* @param	y2	The y value of the second point.
	* @return	Returns the distance between the two points.
	* 
	* @usage
	* <pre><code>
	* var x1:Number = 10;
	* var y1:Number = 10;
	* var x2:Number = 20;
	* var y2:Number = 20;
	* trace (MathUtil.distance(x1, y1, x2, y2));
	* </code></pre>
	*/
	public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		var dx:Number = x2-x1;
		var dy:Number = y2-y1;
		return Math.sqrt(dx*dx+dy*dy);
	}
	/**
	* Finds the distance between two points.
	* 
	* @param	p1	The first point, with x and y properties.
	* @param	p2	The second point, with x and y properties.
	* @return	Returns the distance between the two points.
	* 
	* @usage
	* <pre><code>
	* var p1:Object = {x:10, y:10};
	* var p2:Object = {x:20, y:20};
	* trace (MathUtil.distancePts(p1, p2));
	* </code></pre>
	*/
	public static function distancePts(p1:Object, p2:Object):Number {
		var dx:Number = p2.x-p1.x;
		var dy:Number = p2.y-p1.y;
		return Math.sqrt(dx*dx+dy*dy);
	}
	/**
	* Finds the angle of the line formed between two points.
	* 
	* @param	x1	The x value of the first point.
	* @param	y1	The y value of the first point.
	* @param	x2	The x value of the second point.
	* @param	y2	The y value of the second point.
	* @return	Returns the angle of the line formed between the two points.
	* 
	* @usage
	* <pre><code>
	* var x1:Number = 10;
	* var y1:Number = 10;
	* var x2:Number = 20;
	* var y2:Number = 20;
	* trace (MathUtil.angleOfLine(x1, y1, x2, y2));
	* </code></pre>
	*/
	public static function angleOfLine(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		return Degree.atan2D(y2-y1, x2-x1);
	}
	/**
	* Finds the angle of the line formed between two points.
	* 
	* @param	p1	The first point, with x and y properties.
	* @param	p2	The second point, with x and y properties.
	* @return	Returns the angle of the line formed between the two points.
	* 
	* @usage
	* <pre><code>
	* var p1:Object = {x:10, y:10};
	* var p2:Object = {x:20, y:20};
	* trace (MathUtil.angleOfLinePts(p1, p2));
	* </code></pre>
	*/
	public static function angleOfLinePts(p1:Object, p2:Object):Number {
		return Degree.atan2D(p2.y-p1.y, p2.x-p1.x);
	}
	/**
	* Takes an angle in degrees and returns the equivalent standardized angle between 0 and 360 degrees.
	* 
	* @param	angle	The angle below 0 or above 360.
	* @return	Returns the equivalent standardized angle between 0 and 360 degrees.
	* 
	* @usage
	* <pre><code>
	* trace (MathUtil.fixAngle(740));
	* trace (MathUtil.fixAngle(-340));
	* trace (MathUtil.fixAngle(20));
	* </code></pre>
	*/
	public static function fixAngle(angle:Number):Number {
		return ((angle %= 360)<0) ? angle+360 : angle;
	}
	/**
	* Changes degrees to radians.
	* 
	* @param	angle	The angle in degrees.
	* @return	Returns the angle in radians.
	* 
	* @usage
	* <pre><code>
	* var angleDegrees:Number = 180;
	* var angleRadians:Number = MathUtil.degreesToRadians(angleDegrees);
	* trace (angleRadians);
	* </code></pre>
	* 
	*/
	public static function degreesToRadians(angle:Number):Number {
		return angle*(Math.PI/180);
	}
	/**
	* Changes radians to degrees.
	* 
	* @param	angle	The angle in radians.
	* @return	Returns the angle in degrees.
	* 
	* @usage
	* <pre><code>
	* trace (MathUtil.radiansToDegrees(Math.PI));
	* </code></pre>
	* 
	*/
	public static function radiansToDegrees(angle:Number):Number {
		return angle*(180/Math.PI);
	}
	/**
	* Returns a random floating-point number between two numbers.
	* 
	* @param	low		The low number of the random range.
	* @param	high	The high number of the random range.
	* @return	Returns a random floating-point number between two numbers.
	* 
	* @usage
	* <pre><code>
	* trace (MathUtil.randRangeFloat(-.1, .1));
	* </code></pre>
	* 
	*/
	public static function randRangeFloat(low:Number, high:Number):Number {
		return Math.random()*(high-low)+low;
	}
	/**
	* Returns a random integer between two numbers.
	* 
	* @param	low		The low number of the random range.
	* @param	high	The high number of the random range.
	* @return	Returns a random integer between two numbers.
	* 
	* @usage
	* <pre><code>
	* trace (MathUtil.randRangeInt(-10, 10));
	* </code></pre>
	* 
	*/
	public static function randRangeInt(low:Number, high:Number):Number {
		return Math.floor(Math.random()*(high-low+1)+low);
	}
}
