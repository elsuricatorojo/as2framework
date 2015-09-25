/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 07/07/2008 10:44
*/
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.geom.trigonometria.MathUtil
import com.ionewmedia.utils.geom.vectores.Vector
import com.ionewmedia.utils.geom.vectores.VectorUtils
import com.ionewmedia.utils.geom.vectores.Fuerza;
import com.ionewmedia.utils.geom.Punto
import com.ionewmedia.utils.geom.PuntoUtils
//--
class com.ionewmedia.utils.geom.vectores.fuerzas.Distanciador implements Fuerza{
	//--------------------
	// DOCUMENTACION:
	// Dada una distancia optima 'DISTANCIA_OPTIMA' ejerce una fuerza de atracción hacia un punto...
	// ... situado en la linea que une el puntoOrigen y el punto de aplicación en un punto...
	// ... perteneciente a esa linea situado a una distancia 'DISTANCIA_OPTIMA' del puntoOrigen.
	// La máxima fuerza aplicada es 'MAX_ATRACCION' y se aplica en
	//     a) puntoOrigen y
	//     b) a una ditancia RADIO_MAX_ATRACCION
	//--------------------
	// PARAMETROS:
	public var activo:Boolean=true
	public var puntoAplicacion:Punto
	public var puntoOrigen:Punto
	//--
	public var DISTANCIA_OPTIMA:Number = 100
	public var MAX_ATRACCION:Number = 10
	public var RADIO_MAX_ATRACCION:Number = 200
	//--
	private var emisor:EmisorExtendido
	private var ceroAplicable:Number = 0.1
	private var imanActivado:Boolean=false
	//--------------------
	// CONSTRUCTORA:
	function Distanciador(_puntoAplicacion:Punto, _puntoOrigen:Punto, distancia:Number, maxAtraccion:Number, radioMax:Number){
		trace("(Distanciador.CONSTRUCTORA)!")
		emisor=new EmisorExtendido()
		if (maxAtraccion != undefined || maxAtraccion != null) {
			MAX_ATRACCION=maxAtraccion
		}
		if (radioMax != undefined || radioMax != null) {
			RADIO_MAX_ATRACCION=radioMax
		}
		if (distancia != undefined || distancia != null) {
			DISTANCIA_OPTIMA=distancia
		}
		//--
		puntoAplicacion = _puntoAplicacion
		puntoOrigen=_puntoOrigen
	}
	//--------------------
	// METODOS PUBLICOS:
	public function sumarFuerza(vector:Vector):Vector {
		// Devuleve el vector fuerza que se aplica sobre el punto SUMADO a un vector pasado (opcional).
		//		punto: es el punto SOBRE el que actua la fuerza
		// 		puntoOrigen: (opcional) es el punto DESDE el que actua la fuerza
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
		//		punto: es el punto SOBRE el que actua la fuerza
		// 		puntoOrigen: es el punto DESDE el que actua la fuerza
		var componente:Number
		var anguloDeg:Number
		var distancia:Number = PuntoUtils.distancia(puntoOrigen, puntoAplicacion)
		//--
		if (distancia == DISTANCIA_OPTIMA) {
			componente = 0
			anguloDeg = 0
		}else if (distancia < DISTANCIA_OPTIMA) {
			//trace("...dentro!")
			anguloDeg = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoOrigen, puntoAplicacion))
			var anguloRad:Number = MathUtil.degreesToRadians(anguloDeg)
			var puntoAtraccion:Punto = PuntoUtils.polar(DISTANCIA_OPTIMA, anguloRad)
			puntoAtraccion.sumar(puntoOrigen)
			var ditanciaPuntoAtraccion:Number = PuntoUtils.distancia(puntoAplicacion, puntoAtraccion)
			var ratio:Number = 1-(distancia / DISTANCIA_OPTIMA)
			componente = MAX_ATRACCION * ratio
			//trace("   ditanciaPuntoAtraccion: "+ditanciaPuntoAtraccion)
			//trace("   ratio: "+ratio)
			//trace("   componente: "+componente)
			if (distancia < ceroAplicable) {
				if (!imanActivado){
					imanActivado=true
					var obj:Object = new Object()
					obj.type = "onActivarIman"
					obj.punto = puntoOrigen
					emisor.emitir_objeto(obj)
				}
			}else {
				if (imanActivado) {
					imanActivado=false
					var obj:Object = new Object()
					obj.type = "onDesactivarIman"
					obj.punto = puntoOrigen
					emisor.emitir_objeto(obj)
				}
			}
		}else if (distancia > DISTANCIA_OPTIMA) {
			//trace("...fuera!")
			anguloDeg = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoAplicacion, puntoOrigen))
			var anguloDeg2 = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoOrigen, puntoAplicacion))
			var anguloRad2:Number = MathUtil.degreesToRadians(anguloDeg2)
			var anguloRad:Number = MathUtil.degreesToRadians(anguloDeg)
			var puntoAtraccion:Punto = PuntoUtils.polar(DISTANCIA_OPTIMA, anguloRad2)
			puntoAtraccion.sumar(puntoOrigen)
			var ditanciaPuntoAtraccion:Number = PuntoUtils.distancia(puntoAplicacion, puntoAtraccion)
			var rangoExterno:Number=RADIO_MAX_ATRACCION-DISTANCIA_OPTIMA
			var ratio:Number 
			if (ditanciaPuntoAtraccion<rangoExterno) {
				ratio = ditanciaPuntoAtraccion / rangoExterno
			}else {
				ratio = 1
			}
			componente=MAX_ATRACCION*ratio
			//trace("   ditanciaPuntoAtraccion: "+ditanciaPuntoAtraccion)
			//trace("   ratio: "+ratio)
			//trace("   componente: "+componente)
		}
		//--
		var vectorFuerza:Vector = new Vector(componente, anguloDeg)
		return vectorFuerza
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onActivarIman", ref);
		emisor.addEventListener("onDesactivarIman", ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento, ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento, ref);
	}
	//--------------------
	// SNIPPETS:
}