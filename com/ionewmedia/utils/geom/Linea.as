/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070802
* Por "Segmento" entendemos el tramo de una Linea determinado por 2 puntos pertenecientes a la misma
*/
//
import com.ionewmedia.utils.geom.trigonometria.MathUtil;
import com.ionewmedia.utils.geom.Punto;
class com.ionewmedia.utils.geom.Linea {
	//-----------------
	// PARAMETROS:
	// Caso linea NO vertical: y=ax+b
	private var _a:Number = null;
	private var _b:Number = null;
	// Caso linea vertical: x=2
	private var _c:Number = null;
	//--
	public var angulo:Number;
	public var existe:Boolean = true;
	//-----------------
	// COSNTRUCTORA:
	function Linea(_a:Number, _b:Number, _c:Number) {
		this._a = a;
		this._b = b;
		this._c = c;
		eval_angulo();
	}
	//-----------------
	// GETTERS:
	function get a():Number {
		return (this._a);
	}
	function get b():Number {
		return (this._b);
	}
	function get c():Number {
		return (this._c);
	}
	//-----------------
	// SETTERS:
	function set a(valor:Number):Void {
		this._c = null;
		this._a = valor;
		eval_angulo();
	}
	function set b(valor:Number):Void {
		this._c = null;
		this._b = valor;
		eval_angulo();
	}
	function set c(valor:Number):Void {
		this._a = null;
		this._b = null;
		this._c = valor;
		eval_angulo();
	}
	//-----------------
	// PUBLICAS:
	public function get_y(valor_x:Number):Number {
		//
		var valor_y:Number;
		if (c != null) {
			// Es vertical
			valor_y = null;
		} else {
			valor_y = (a*valor_x)+b;
		}
		return (valor_y);
	}
	public function get_x(valor_y:Number):Number {
		//
		var valor_x:Number = ((valor_y-b)/a);
		return (valor_x);
	}
	public function toString() {
		return ("(Linea.toString) a: "+a+"  b: "+b+"  c: "+c);
	}
	//-----------------
	// PRIVADAS:
	private function eval_angulo():Void {
		// Escojemos 2 puntos y hayamos el angulo
		if (!isNaN(c)) {
			// Es vertical
			angulo = 90;
		} else {
			//var punto1:Punto = new Punto(get_x(0), get_y(-100));
			//var punto2:Punto = new Punto(get_x(0), get_y(100));
			//CORREGIDO 16/02/2009 17:32:
			var punto1:Punto = new Punto(-100, get_y(-100));
			var punto2:Punto = new Punto(100, get_y(100));
			angulo = MathUtil.angleOfLinePts(punto1, punto2);
		}
	}
}
