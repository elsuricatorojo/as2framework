/*
DOCUMENTACION:
* Adaptación de la clase MyPoint Bajada de: http://nodename.com/blog/2005/09/26/point-class-slow/ 
* el: 20070301
* Puede actuar en cierta forma como sustituto de la clase Point del player 8.
*/
// 
import com.ionewmedia.utils.numeros.Autonumerico2
class com.ionewmedia.utils.geom.Punto {
	//--------------
	// PARAMETROS:
	private var id:String
	private var _x;
	private var _y;
	//--------------
	// CONSTRUCTORA:
	function Punto(x:Number, y:Number, _id:String) {
		id="punto_"+Autonumerico2.get()
		this._x = x || 0;
		this._y = y || 0;
	}
	//----------------
	// GETTERS:
	public function get x():Number {
		return this._x;
	}
	public function get y():Number {
		return this._y;
	}
	//--------------
	// SETTERS:
	public function set x(valor:Number) {
		this._x = valor;
	}
	public function set y(valor:Number) {
		this._y = valor;
	}
	//--------------
	// PUBLICAS:
	public function get length():Number {
		// Devuelve la distancia a 0,0
		return Math.sqrt(this._x*this._x+this._y*this._y);
	}
	public function clone():Punto {
		// Devuelve un punto clon del actual
		return new Punto(this._x, this._y);
	}
	public function offset(dx:Number, dy:Number):Void {
		// Aplica incrementos en x e y al punto.
		this._x += dx;
		this._y += dy;
	}
	public function eval_iguales(toCompare:Object):Boolean {
		//	slower!
		//	return ((toCompare instanceof Punto) && (toCompare._x == this._x) && (toCompare._y == this._y));
		//	faster!
		if (!(toCompare instanceof Punto)) {
			return false;
		}
		if (toCompare._x != this._x) {
			return false;
		}
		if (toCompare._y != this._y) {
			return false;
		}
		return true;
	}
	public function restar(other:Punto):Void {
		// Sobre el punto actual se restan los valores de otro punto.
		this._x -= other.x;
		this._y -= other.y;
	}
	public function sumar(other:Punto):Void {
		// Sobre el punto actual se suman los valores de otro punto.
		this._x += other.x;
		this._y += other.y;
	}
	public function normalize(length:Number):Void {
		// En la linea que une el punto con 0,0..
		// Acomoda los valores _x e _y de tal forma que
		// se sigue perteneciendo a la linea original
		// pero la distancia al 0,0 es ahora = length
		var l = this.length;
		if (l>0) {
			var factor = length/l;
			this._x *= factor;
			this._y *= factor;
		}
	}
	public function toString():String {
		return ("(x="+this._x+", y="+this._y+")");
	}
}
