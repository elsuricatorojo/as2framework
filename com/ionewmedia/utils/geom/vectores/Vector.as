/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 03/07/2008 10:55
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
// Geom:
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.PuntoUtils
import com.ionewmedia.utils.geom.trigonometria.MathUtil
class com.ionewmedia.utils.geom.vectores.Vector {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var componente:Number // Solo READ, Siempre positivo
	public var anguloDeg:Number // Solo READ, Valores de 0 a 360
	public var anguloRad:Number // Solo READ
	public var puntoOrigen:Punto // Solo READ
	public var puntoFinal:Punto // Solo READ
	//--------------------
	// CONSTRUCTORA:
	function Vector(_componente:Number, _anguloDeg:Number){
		//trace("(Vector.CONSTRUCTORA)!")
		puntoOrigen = new Punto(0, 0)
		//--
		componente = Math.abs(_componente)
		anguloDeg = MathUtil.fixAngle(_anguloDeg)
		//--
		anguloRad = MathUtil.degreesToRadians(anguloDeg)
		puntoFinal = PuntoUtils.polar(componente, anguloRad)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function sumarVector(vector:Vector) {
		var puntoResultante:Punto = PuntoUtils.sumarPuntos(puntoFinal, vector.puntoFinal)
		componente = PuntoUtils.distancia(puntoOrigen, puntoResultante)
		anguloDeg = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoOrigen, puntoResultante))
		//--
		anguloRad = MathUtil.degreesToRadians(anguloDeg)
		puntoFinal = PuntoUtils.polar(componente, anguloRad)
	}
	public function set_componente(valor:Number) {
		componente = Math.abs(valor)
		anguloRad = MathUtil.degreesToRadians(anguloDeg)
		puntoFinal = PuntoUtils.polar(componente, anguloRad)
	}
	public function set_anguloDeg(angulo):Void {
		anguloDeg = MathUtil.fixAngle(angulo)
		anguloRad = MathUtil.degreesToRadians(anguloDeg)
		puntoFinal = PuntoUtils.polar(componente, anguloRad)
	}
	public function toString():String {
		return("Vector {componente: "+componente+"  anguloDeg: "+anguloDeg+"}")
	}
	public function clone():Vector {
		var clon:Vector = new Vector(componente, anguloDeg)
		return clon
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
