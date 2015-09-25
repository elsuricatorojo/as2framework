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
import com.ionewmedia.utils.geom.vectores.VectorUtils
import com.ionewmedia.utils.geom.vectores.Fuerza;
import com.ionewmedia.utils.geom.Punto
import com.ionewmedia.utils.geom.PuntoUtils
class com.ionewmedia.utils.geom.vectores.fuerzas.Atractor implements Fuerza {
	//--------------------
	// DOCUMENTACION:
	// Ejerce una fuerza de atraccion directamente proporcional a la distancia hasta
	// ...'RADIO_MAX_ATRACCION' apartir de la cual ejerce la máxima atraccion 'MAX_ATRACCION'.
	// Es decir, Cuanto mas lejos mas atracción con un maximo a partir de una distancia.
	//--------------------
	// PARAMETROS:
	public var activo:Boolean=true
	public var puntoAplicacion:Punto
	public var puntoOrigen:Punto
	//--
	public var MAX_ATRACCION:Number = 10
	public var RADIO_MAX_ATRACCION:Number = 100
	//--
	private var emisor:EmisorExtendido
	private var ceroAplicable:Number = 0.5
	private var imanActivado:Boolean=false
	//--------------------
	// CONSTRUCTORA:
	function Atractor(_puntoAplicacion:Punto, _puntoOrigen:Punto, maxAtraccion:Number, radioMax:Number){
		trace("(Atractor.CONSTRUCTORA)!")
		emisor=new EmisorExtendido()
		if (maxAtraccion != undefined || maxAtraccion != null) {
			MAX_ATRACCION=maxAtraccion
		}
		if (radioMax != undefined || radioMax != null) {
			RADIO_MAX_ATRACCION=radioMax
		}
		//--
		puntoAplicacion = _puntoAplicacion
		puntoOrigen = _puntoOrigen
	}
	//--------------------
	// METODOS PUBLICOS:
	public function sumarFuerza(vector:Vector):Vector {
		// Devuleve el vector fuerza que se aplica sobre el punto SUMADO a un vector pasado (opcional).
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
		var vectorFuerza:Vector
		var componente:Number
		var anguloDeg:Number = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoAplicacion, puntoOrigen))
		var distancia:Number = PuntoUtils.distancia(puntoOrigen, puntoAplicacion)
		if (distancia>=RADIO_MAX_ATRACCION) {
			componente=MAX_ATRACCION
		}else {
			var ratio:Number = distancia / RADIO_MAX_ATRACCION
			componente = MAX_ATRACCION * ratio
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
		}
		vectorFuerza = new Vector(componente, anguloDeg)
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