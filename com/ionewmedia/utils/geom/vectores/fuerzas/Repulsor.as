/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 07/07/2008 9:13
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
//--
import com.ionewmedia.utils.geom.trigonometria.MathUtil
import com.ionewmedia.utils.geom.vectores.Vector
import com.ionewmedia.utils.geom.vectores.VectorUtils;
import com.ionewmedia.utils.geom.vectores.Fuerza;
import com.ionewmedia.utils.geom.Punto
import com.ionewmedia.utils.geom.PuntoUtils
class com.ionewmedia.utils.geom.vectores.fuerzas.Repulsor implements Fuerza {
	//--------------------
	// DOCUMENTACION:
	// Ejerce una fuerza de repulsion inversamente proporcional a la distancia.
	// A una distancia 0 ejerce la máxima repulsion definida por 'MAX_REPULSION' hasta...
	// ...'RADIO_MAX_REPULSION' apartir de la cual no ejerce repulsión alguna.
	//--------------------
	// PARAMETROS:
	public var activo:Boolean=true
	public var puntoAplicacion:Punto
	public var puntoOrigen:Punto
	//--
	public var MAX_REPULSION:Number = 10
	public var RADIO_MAX_REPULSION:Number = 100
	//--------------------
	// CONSTRUCTORA:
	function Repulsor(_puntoAplicacion:Punto, _puntoOrigen:Punto, maxRepulsion:Number, radioMax:Number){
		trace("(Repulsor.CONSTRUCTORA)!")
		if (maxRepulsion != undefined || maxRepulsion != null) {
			MAX_REPULSION=maxRepulsion
		}
		if (radioMax != undefined || radioMax != null) {
			RADIO_MAX_REPULSION=radioMax
		}
		//--
		puntoAplicacion = _puntoAplicacion
		puntoOrigen = _puntoOrigen
	}
	//--------------------
	// METODOS PUBLICOS:
	public function sumarFuerza(vector:Vector):Vector {
		//trace("(Repulsor.sumarFuerza) vector: "+vector.toString())
		// Devuleve el vector fuerza que se aplica sobre el punto SUMADO a un vector pasado.
		//		puntoAplicacion: es el punto SOBRE el que actua la fuerza
		// 		puntoOrigen: es el punto DESDE el que actua la fuerza
		if (vector == undefined || vector == null) {
			vector= new Vector(0, 0)
		}
		var vectorResultante:Vector
		if (activo) {
			var vectorFuerza:Vector = getFuerza()
			vectorResultante = VectorUtils.sumarVectores(vector, vectorFuerza)
		}else {
			vectorResultante=vector
		}
		return vectorResultante
	}
	public function getFuerza():Vector {
		// Devuleve el vector fuerza que se aplica sobre el punto.
		//		puntoAplicacion: es el punto SOBRE el que actua la fuerza
		// 		puntoOrigen: es el punto DESDE el que actua la fuerza
		//--
		//trace("   puntoOrigen: " + puntoOrigen.toString())
		//trace("   puntoAplicacion: "+puntoAplicacion.toString())
		var componente:Number
		var anguloDeg:Number = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoOrigen, puntoAplicacion))
		var distancia:Number = PuntoUtils.distancia(puntoOrigen, puntoAplicacion)
		if (distancia >= RADIO_MAX_REPULSION) {
			componente = 0
			anguloDeg = 0
		}else {
			var ratio:Number = 1-(distancia / RADIO_MAX_REPULSION)
			componente=MAX_REPULSION*ratio
		}
		var vectorFuerza:Vector = new Vector(componente, anguloDeg)
		return vectorFuerza
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		// NADA
	}
	public function addEventListener(evento:String, ref:Object) {
		// NADA
	}
	public function removeListener(ref:Object) {
		// NADA
	}
	public function removeEventListener(evento:String, ref:Object) {
		// NADA
	}
	//--------------------
	// SNIPPETS:
}