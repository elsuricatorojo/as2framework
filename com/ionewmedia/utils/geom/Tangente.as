/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070802
* Define una Tangente como un Punto y una Linea
*/
//
import com.ionewmedia.utils.geom.trigonometria.MathUtil;
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.Linea;
import com.ionewmedia.utils.geom.LineaUtils;
class com.ionewmedia.utils.geom.Tangente {
	//--------------
	// PARAMETROS:
	private var _punto:Punto;
	private var _linea:Linea;
	//--
	// Determina la orientación
	public var puntoVector:Punto = null;
	//--
	public var angulo:Number;
	//--------------
	// CONSTRUCTORA:
	function Tangente(puntoAplicacion:Punto, linea:Linea, _puntoVector:Punto) {
		//trace(punto.toString());
		//trace(linea.toString());
		this._punto = puntoAplicacion;
		this._linea = LineaUtils.getLine2(puntoAplicacion, linea);
		if (_puntoVector != null && _puntoVector != undefined) {
			puntoVector = _puntoVector;
		}
		this.puntoVector = puntoVector;
		eval_angulo();
		//trace(angulo);
		//trace("---");
	}
	//----------------
	// GETTERS:
	public function get punto():Punto {
		return this._punto;
	}
	public function get linea():Linea {
		return this._linea;
	}
	//--------------
	// SETTERS:
	public function set punto(valor:Punto) {
		this._punto = valor;
		eval_angulo();
	}
	public function set linea(valor:Linea) {
		this._linea = valor;
		eval_angulo();
	}
	//--------------
	// PUBLICAS:
	//--------------
	// PRIVADAS:
	private function eval_angulo():Void {
		//trace("Tenemos puntoVector: "+puntoVector.toString());
		if (puntoVector == null) {
			// Escojemos 2 puntos y hayamos el angulo
			//trace(_linea.c);
			if (_linea.c != null) {
				// Es vertical
				angulo = 180;
			} else {
				var obj1:Object = new Object();
				obj1.x = -100;
				obj1.y = _linea.get_y(-100);
				var obj2:Object = new Object();
				obj2.x = 100;
				obj2.y = _linea.get_y(100);
				//--
				//trace("obj1.x: "+obj1.x);
				//trace("obj1.y: "+obj1.y);
				//trace("obj2.x: "+obj2.x);
				//trace("obj2.y: "+obj2.y);
				angulo = MathUtil.angleOfLinePts(obj1, obj2);
				angulo = MathUtil.fixAngle(angulo);
			}
		} else {
			
			var obj1:Object = new Object();
			obj1.x = _punto.x;
			obj1.y = _punto.y;
			var obj2:Object = new Object();
			obj2.x = puntoVector.x;
			obj2.y = puntoVector.y;
			angulo = MathUtil.angleOfLinePts(obj1, obj2);
			angulo = MathUtil.fixAngle(angulo);
		}
	}
}
