/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070731
*/
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.bezier.v1.BezierUtils;
class com.ionewmedia.utils.geom.bezier.v1.Bezier {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var _p1:Punto;
	private var _p2:Punto;
	private var _c1:Punto;
	private var _c2:Punto;
	//--------------------
	// CONSTRUCTORA:
	function Bezier(p1:Punto, c1:Punto, p2:Punto, c2:Punto) {
		trace("(Bezier.CONSTRUCTORA)!");
		this.p1 = p1;
		this.p2 = p2;
		this.c1 = c1;
		this.c2 = c2;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function interpolar(t:Number):Punto {
		//t: valores de 0 -> 1
		var punto = BezierUtils.interpolar(this, t);
		return (punto);
	}
	// SETTERS
	public function set p1(p:Punto) {
		this._p1 = p;
	}
	public function set c1(p:Punto) {
		this._c1 = p;
	}
	public function set p2(p:Punto) {
		this._p2 = p;
	}
	public function set c2(p:Punto) {
		this._c2 = p;
	}
	// GETTERS:
	public function get p1():Punto {
		return this._p1;
	}
	public function get p2():Punto {
		return this._p2;
	}
	public function get c1():Punto {
		return this._c1;
	}
	public function get c2():Punto {
		return this._c2;
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
