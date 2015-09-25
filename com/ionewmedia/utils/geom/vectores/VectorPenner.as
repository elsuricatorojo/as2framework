import com.robertpenner.utils.Degree;

/**
* The VectorPenner class is designed to represent vectors and points
* in two-dimensional space. Vectors can be added together,
* scaled, rotated, and otherwise manipulated with these methods.
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
class com.ionewmedia.utils.geom.vectores.VectorPenner {
	
	/*
	* CLASS PROPERTIES
	*/
	private var $x:Number;
	private var $y:Number;

	
	/*
	* *********************************************************
	* CONSTRUCTOR
	* *********************************************************
	*
	*/
	
	/**
	* Creates an instance of the VectorPenner class.
	* 
	* @param	x	The x value of the vector.
	* @param	y	The y value of the vector.
	* 
	* @usage
	* <pre><code>
	* var v:VectorPenner = new VectorPenner(-9,4);
	* trace (v.x);
	* trace (v.y);
	* </code></pre>
	*/
	function VectorPenner (x:Number, y:Number) {
		this.initialize (x, y);
	}
	
	
	/*
	* *********************************************************
	* PRIVATE METHODS
	* *********************************************************
	* 
	*/
	private function initialize (x:Number, y:Number):Void {
		this.x = x;
		this.y = y;
	}
	
	
	/*
	* *********************************************************
	* PUBLIC METHODS
	* *********************************************************
	* 
	*/
	
	/**
	* Returns a string representation of the vector object.
	* 
	* @return	Returns the string representation of the vector object.
	* 
	* @usage
	* <pre><code>
	* var position:VectorPenner = new VectorPenner(5,8);
	* trace (position.toString());
	* trace (position);
	* </code></pre>
	*/
	public function toString ():String {
		var rx:Number = Math.round (this.x * 1000) / 1000;
		var ry:Number = Math.round (this.y * 1000) / 1000;
		return "[" + rx + ", " + ry + "]";
	}
	
	/**
	* Reinitializes the vector object.
	* 
	* @param	x	The x value of the vector.
	* @param	y	The y value of the vector.
	* 
	* @usage
	* <pre><code>
	* var velocity:VectorPenner = new VectorPenner(5,1);
	* velocity.reset(-9,7);
	* trace (velocity);
	* </code></pre>
	*/
	public function reset (x:Number, y:Number):Void {
		this.initialize (x, y);
	}
	
	/**
	* Returns a new vector object containing the x and y values of the current vector.
	* 
	* @return	Returns a copy of the current vector object.
	* 
	* @usage
	* <pre><code>
	* var forceA:VectorPenner = new VectorPenner(2,4);
	* var forceB:VectorPenner = forceA.getClone();
	* trace (forceA);
	* trace (forceB);
	* trace (forceA == forceB);
	* </code></pre>
	*/
	public function getClone ():VectorPenner {
		return new VectorPenner (this.x, this.y);
	}
	
	/**
	* Tests the equality of two vector objects.
	* 
	* @param	v	The vector object to compare with the current vector.
	* @return	Returns true if the values of the two x properties and the two y properties are the same.
	* 
	* @usage
	* <pre><code>
	* var forceA:VectorPenner = new VectorPenner(2,4);
	* var forceB:VectorPenner = forceA.getClone();
	* trace (forceB.equals(forceA));
	* forceA.reset(0,0);
	* trace (forceB.equals(forceA));
	* </code></pre>
	*/
	public function equals (v:VectorPenner):Boolean {
		return (this.x == v.x && this.y == v.y);
	}
	
	/**
	* Adds a vector object to the current vector.
	* 
	* @param	v	The vector object to add to the current vector.
	* 
	* @usage
	* <pre><code>
	* var position:VectorPenner = new VectorPenner(1,3);
	* var velocity:VectorPenner = new VectorPenner(3,0);
	* position.plus(velocity);
	* trace (position);
	* </code></pre>
	*/
	public function plus (v:VectorPenner):Void {
		this.x += v.x;
		this.y += v.y;
	}
	
	/**
	* Performs addition on two vector objects and returns the result of the addition as a new vector.
	* 
	* @param	v	The vector object to add to the current vector.
	* @return	Returns the result of the addition as a new vector.
	* 
	* @usage
	* <pre><code>
	* var position:VectorPenner = new VectorPenner(4,1);
	* var velocity:VectorPenner = new VectorPenner(-2,0);
	* var newPosition:VectorPenner = position.plusNew(velocity);
	* trace (newPosition);
	* </code></pre>
	*/
	public function plusNew (v:VectorPenner):VectorPenner {
		return new VectorPenner (this.x + v.x, this.y + v.y);
	}
	
	/**
	* Subtracts a vector object from the current vector.
	* 
	* @param	v	The vector object to subtract from the current vector.
	* 
	* @usage
	* <pre><code>
	* var forceA:VectorPenner = new VectorPenner(1,1);
	* var forceB:VectorPenner = new VectorPenner(-2,-1);
	* forceA.minus(forceB);
	* trace (forceA);
	* </code></pre>
	*/
	public function minus (v:VectorPenner):Void {
		this.x -= v.x;
		this.y -= v.y;
	}
	
	/**
	* Performs subtraction on two vector objects and returns the result of the subtraction as a new vector.
	* 
	* @param	v	The vector object to subtract from the current vector.
	* @return	Returns the result of the subtraction as a new vector.
	* 
	* @usage
	* <pre><code>
	* var pointA:VectorPenner = new VectorPenner(0,1);
	* var pointB:VectorPenner = new VectorPenner(-2,0);
	* var displacement:VectorPenner = pointB.minusNew(pointA);
	* trace (displacement);
	* </code></pre>
	*/
	public function minusNew (v:VectorPenner):VectorPenner {
		return new VectorPenner (this.x - v.x, this.y - v.y);
	}
	
	/**
	* Reverses the direction of the current vector.
	* 
	* @usage
	* <pre><code>
	* var direction:VectorPenner = new VectorPenner(2,3);
	* direction.negate();
	* trace (direction);
	* </code></pre>
	*/
	public function negate ():Void {
		this.x = -this.x;
		this.y = -this.y;
	}
	
	/**
	* Reverses the direction of the current vector and returns the result as a new vector.
	* 
	* @return	Returns the reversed vector object as a new vector.
	* 
	* @usage
	* <pre><code>
	* var forward:VectorPenner = new VectorPenner(99,0);
	* var backward:VectorPenner = forward.negateNew();
	* trace (backward);
	* </code></pre>
	*/
	public function negateNew ():VectorPenner {
		return new VectorPenner (-this.x, -this.y);
	}
	
	/**
	* Scales the length of the current vector object by a scale factor.
	* 
	* @param	s	The scale factor to multiply the current vector by.
	* 
	* @usage
	* <pre><code>
	* var windForce:VectorPenner = new VectorPenner(2,3);
	* windForce.scale(2);
	* trace (windForce);
	* </code></pre>
	*/
	public function scale (s:Number):Void {
		this.x *= s;
		this.y *= s;
	}
	
	/**
	* Scales the length of the current vector object by a scale factor and returns the result of the scale as a new vector.
	* 
	* @param	s	The scale factor to multiply the current vector by.
	* @return	Returns the scaled vector object as a new vector.
	* 
	* @usage
	* <pre><code>
	* var windForce:VectorPenner = new VectorPenner(-2,1);
	* var galeForce:VectorPenner = windForce.scaleNew(2); //strong wind
	* trace (galeForce);
	* </code></pre>
	*/
	public function scaleNew (s:Number):VectorPenner {
		return new VectorPenner (this.x * s, this.y * s);
	}
	
	/**
	* Gets the size of the current vector.
	* 
	* @return	Returns the size of the current vector.
	* 
	* @usage
	* <pre><code>
	* var velocity:VectorPenner = new VectorPenner(3,4);
	* var speed:Number = velocity.getLength();
	* trace (speed);
	* </code></pre>
	*/
	public function getLength ():Number {
		return Math.sqrt (this.x*this.x + this.y*this.y);
	}
	
	/**
	* Sets the size of the current vector.
	* 
	* @param	len		The length that the current vector will be set.
	* 
	* @usage
	* <pre><code>
	* var velocity:VectorPenner = new VectorPenner(3,4);
	* var newSpeed:Number = 10;
	* velocity.setLength(newSpeed);
	* trace (velocity);
	* trace (velocity.getLength());
	* </code></pre>
	*/
	public function setLength (len:Number):Void {
		var r:Number = this.getLength();
		r ? this.scale(len/r) : this.x = len;
	}
	
	/**
	* Gets the angle of the current vector.
	* 
	* @return	Returns the angle of the current vector.
	* 
	* @usage
	* <pre><code>
	* var destination:VectorPenner = new VectorPenner(5,5);
	* var compassBearing:Number = destination.getAngle();
	* trace (compassBearing);
	* </code></pre>
	*/
	public function getAngle ():Number {
		return Degree.atan2D (this.y, this.x);
	}
	
	/**
	* Sets the angle of the current vector.
	* 
	* @param	ang		The angle that the current vector will be set.
	* 
	* @usage
	* <pre><code>
	* var velocity:VectorPenner = new VectorPenner(7,0);
	* var newBearing:Number = 180;
	* velocity.setAngle(newBearing);
	* trace (velocity);
	* trace (velocity.getAngle());
	* </code></pre>
	*/
	public function setAngle (ang:Number):Void {
		var r:Number = this.getLength();
		this.x = r * Degree.cosD (ang);
		this.y = r * Degree.sinD (ang);
	}
	
	/**
	* Rotates the angle of the current vector object by a certain amount of degrees.
	* 
	* @param	ang		The amount of degrees that the current vector object will be rotated by.
	* 
	* @usage
	* <pre><code>
	* var direction:VectorPenner = new VectorPenner(5,5);
	* trace (direction.getAngle());
	* direction.rotate(-90);
	* trace (direction);
	* trace (direction.getAngle());
	* </code></pre>
	*/
	public function rotate (ang:Number):Void {
		var ca:Number = Degree.cosD (ang);
		var sa:Number = Degree.sinD (ang);

		var rx:Number = this.x * ca - this.y * sa;
		var ry:Number = this.x * sa + this.y * ca;
		this.x = rx;
		this.y = ry;
	}
	
	/**
	* Rotates the angle of the current vector object by a certain amount of degrees and returns the result of the rotation as a new vector.
	* 
	* @param	ang		The amount of degrees that the current vector object will be rotated by.
	* @return	Returns the result of the rotation as a new vector.
	* 
	* @usage
	* <pre><code>
	* var direction:VectorPenner = new VectorPenner(5,5);
	* var newDirection:VectorPenner = direction.rotateNew(10);
	* trace (newDirection.getAngle());
	* </code></pre>
	*/
	public function rotateNew (ang:Number):VectorPenner {
		var v:VectorPenner = new VectorPenner (this.x, this.y);
		v.rotate (ang);
		return v;
	}
	
	/**
	* Performs multiplication on two vector objects and returns the dot product.
	* 
	* @param	v	The vector object to multiply the current vector by.
	* @return	Returns the dot product.
	* 
	* @usage
	* <pre><code>
	* var v:VectorPenner = new VectorPenner(2,3);
	* var w:VectorPenner = new VectorPenner(4,5);
	* trace (v.dot(w));
	* trace (w.dot(v));
	* </code></pre>
	*/
	public function dot (v:VectorPenner):Number {
		return this.x * v.x + this.y * v.y;
	}
	
	/**
	* Finds a normal for the current vector.
	* 
	* @return	Returns the vector object that is the normal to the current vector.
	* 
	* @usage
	* <pre><code>
	* var wallDirection:VectorPenner = new VectorPenner(3,5);
	* var forceDirection:VectorPenner = wallDirection.getNormal();
	* trace (forceDirection);
	* </code></pre>
	*/
	public function getNormal ():VectorPenner {
		return new VectorPenner (-this.y, this.x);
	}
	
	/**
	* Tests if the current vector is perpendicular to another vector.
	* 
	* @param	v	The vector object to check perpendicularity against.
	* @return	Returns true if the dot product is zero (indicating perpendicularity).
	* 
	* @usage
	* <pre><code>
	* var goingLeft:VectorPenner = new VectorPenner(-3,0);
	* var goingRight:VectorPenner = new VectorPenner(5,0);
	* trace (goingLeft.isPerpTo(goingRight));
	* var goingUp:VectorPenner = new VectorPenner(0,8);
	* trace (goingUp.isPerpTo(goingLeft));
	* </code></pre>
	*/
	public function isPerpTo (v:VectorPenner):Boolean {
		return (this.dot (v) == 0);
	}
	
	/**
	* Tests if the current vector is the normal of another vector.
	* 
	* @param	v	The vector object to check perpendicularity against.
	* @return	Returns true if the dot product is zero.
	* 
	* @usage
	* <pre><code>
	* var goingLeft:VectorPenner = new VectorPenner(-3,0);
	* var goingRight:VectorPenner = new VectorPenner(5,0);
	* trace (goingLeft.isNormalTo(goingRight));
	* var goingUp:VectorPenner = new VectorPenner(0,8);
	* trace (goingUp.isNormalTo(goingLeft));
	* </code></pre>
	*/
	public function isNormalTo (v:VectorPenner):Boolean {
		return this.isPerpTo (v);
	}
	
	/**
	* Returns the angle between the current vector and another vector.
	* 
	* @param	v	The vector object to check the angle between.
	* @return	Returns the angle between the current vector and another vector.
	* 
	* @usage
	* <pre><code>
	* var pullForce:VectorPenner = new VectorPenner(4,0);
	* var frictionForce:VectorPenner = new VectorPenner(-1,0);
	* var theta:Number = pullForce.angleBetween(frictionForce);
	* trace (theta);
	* </code></pre>
	*/
	public function angleBetween (v:VectorPenner):Number {
		var dp:Number = this.dot (v);
		var cosAngle:Number = dp / (this.getLength() * v.getLength());
		return Degree.acosD (cosAngle);
	}
	
	
	/*
	* *********************************************************
	* GETTERS/SETTERS
	* *********************************************************
	* 
	*/
	
	/**
	* The x property of the vector object.
	* 
	* @usage
	* <pre><code>
	* v.x = 9;
	* </code></pre>
	*/
	public function get x ():Number {
		return this.$x;
	}
	public function set x (x:Number):Void {
		this.$x = x;
	}
	
	/**
	* The y property of the vector object.
	* 
	* @usage
	* <pre><code>
	* v.y = -4;
	* </code></pre>
	*/
	public function get y ():Number {
		return this.$y;
	}
	public function set y (y:Number):Void {
		this.$y = y;
	}
	
	/**
	* The length of the vector object.
	* 
	* @usage
	* <pre><code>
	* var velocity:VectorPenner = new VectorPenner(3,4);
	* var newSpeed:Number = 10;
	* velocity.length = newSpeed;
	* trace (velocity);
	* trace (velocity.length);
	* </code></pre>
	*/
	public function get length ():Number {
		return this.getLength();
	}
	public function set length (len:Number):Void {
		this.setLength(len);
	}
	
	/**
	* The angle of the vector object.
	* 
	* @usage
	* <pre><code>
	* var destination:VectorPenner = new VectorPenner(5,5);
	* var compassBearing:Number = destination.angle;
	* trace (compassBearing);
	* </code></pre>
	*/
	public function get angle ():Number {
		return this.getAngle();
	}
	public function set angle (ang:Number):Void {
		this.setAngle(ang);
	}
}
