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
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.Linea;
import com.ionewmedia.utils.geom.LineaUtils;
import com.ionewmedia.utils.geom.trigonometria.MathUtil;
class com.ionewmedia.utils.geom.Segmento {
	//-----------------
	// PARAMETROS:
	private var _p1:Punto;
	private var _p2:Punto;
	//-----------------
	// COSNTRUCTORA:
	function Segmento(p1:Punto, p2:Punto) {
		//trace("(Segmento.CONSTRUCTORA)!")
		this._p1 = p1;
		this._p2 = p2;
		//trace("   p1: " + p1.toString())
		//trace("   p2: "+p2.toString())
	}
	//-----------------
	// GETTERS:
	public function get p1():Punto {
		return this._p1;
	}
	public function get p2():Punto {
		return this._p2;
	}
	public function get angulo():Number {
		//var lineaTemp:Linea = LineaUtils.getLine(_p1, _p2);
		//return lineaTemp.angulo;
		return MathUtil.angleOfLinePts(_p1, _p2);
	}
	public function get linea():Linea {
		var lineaTemp:Linea = LineaUtils.getLine(_p1, _p2);
		return lineaTemp;
	}
	public function get length():Number {
		var dx:Number = _p2.x-_p1.x;
		var dy:Number = _p2.y-_p1.y;
		return Math.sqrt(dx*dx+dy*dy);
	}
	//-----------------
	// SETTERS:
	public function set p1(valor:Punto) {
		this._p1 = valor;
	}
	public function set p2(valor:Punto) {
		this._p2 = valor;
	}
	//-----------------
	// PUBLICAS:
	public function interpolar(f:Number):Punto {
		// dado un f: 0->1 devuelve un punto perteneciente a la linea
		return new Punto((f*_p1.x+(1-f)*_p2.x), (f*_p1.y+(1-f)*_p2.y));
	}
	//-----------------
	// PRIVADAS:
}
