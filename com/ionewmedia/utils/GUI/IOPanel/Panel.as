/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 02/04/2010 12:36
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.geom.Punto;
//--
import com.ionewmedia.utils.GUI.IOPanel.ContenidoPanel
import com.ionewmedia.utils.GUI.IOPanel.DataContenido
//--
class com.ionewmedia.utils.GUI.IOPanel.Panel {
	// import com.ionewmedia.utils.GUI.IOPanel.Panel
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var ancho:Number
	public var alto:Number
	public var data:DataContenido
	public var contenido:ContenidoPanel
	//--
	public var limIzq:Number; // Solo READ
	public var limDer:Number; // Solo READ
	public var limSup:Number; // Solo READ
	public var limInf:Number; // Solo READ
	//--
	private var _puntoPress:Punto
	private var _puntoDrag:Punto
	//--
	private var enDrag:Boolean = false
	private var dragBloqueado:Boolean = true
	private var contenidoRegistrado:Boolean = false
	//--
	private var emisor:EmisorExtendido;
	//--------------------
	// CONSTRUCTORA:
	public function Panel(_ancho:Number, _alto:Number, posicion:Punto) {
		trace("(Panel.CONSTRUCTORA)!")
		ancho = _ancho
		alto = _alto
		limIzq = -(ancho/2);
		limDer = (ancho/2);
		limSup = -(alto/2);
		limInf = (alto/2);
		trace("   ancho: "+ancho)
		trace("   alto: "+alto)
		//--
		emisor = new EmisorExtendido()
	}
	public function init() {
		trace("(Panel.init)!")
		//--
		if (contenidoRegistrado) {
			var dataContenido:DataContenido = contenido.data
			emitirActualizacion("onInitPanel", dataContenido)
		}else {
			trace("ATENCION!! La clase Panel requiere que se haya registrado un ContenidoPanel. (No se inicializa la clase)")
		}
	}
	public function testScope(txt:String) {
		trace("(Panel.testScope) ------------------ "+txt)
	}
	//--------------------
	// METODOS PUBLICOS:
	// Pre init:
	public function registrar_contenido(ref:ContenidoPanel):Void {
		trace("(Panel.registrar_contenido)!")
		if(ref!= undefined && ref != null){
			contenidoRegistrado = true
			contenido = ref
			contenido.testScope("(Panel)")
			contenido.addEventListener("onActualizarContenido", this)
		}
	}
	public function bloquearDrag() {
		trace("(Panel.bloquearDrag)!")
		dragBloqueado = true
	}
	public function desbloquearDrag() {
		trace("(Panel.desbloquearDrag)!")
		dragBloqueado = false
	}
	//--
	public function actualizarRatioX(ratioX:Number) {
		// Reposiciona el contenido en x en base al ratio
		var mitadX:Number
		var ratioAnchos:Number
		var rangoX:Number
		var ratioX:Number
		var posicionX:Number
		if (ancho >= contenido.data.ancho) {
			// Los contenidos son mas estrechos que la mascara.
			ratioAnchos = contenido.data.ancho / ancho
			rangoX = ancho -  contenido.data.ancho
			mitadX = rangoX / 2
			posicionX = rangoX*ratioX-mitadX
		}else {
			// Los contenidos son mas anchos que la mascara
			ratioAnchos = ancho / contenido.data.ancho
			rangoX =  contenido.data.ancho - ancho
			mitadX = rangoX / 2
			posicionX = rangoX*ratioX-mitadX
		}
		var posicion:Punto = contenido.data.posicion.clone()
		posicion.x = posicionX
		var newData:DataContenido = new DataContenido(contenido.data.ancho, contenido.data.alto, posicion)
		contenido.setData(newData)
	}
	public function actualizarRatioY(ratioY:Number) {
		// Reposiciona el contenido en y en base al ratio
		var mitadY:Number
		var ratioAltos:Number
		var rangoY:Number
		var ratioY:Number
		var posicionY:Number
		if (alto >= contenido.data.alto) {
			// Los contenidos son mas estrechos que la mascara.
			ratioAltos = contenido.data.alto / alto
			rangoY = alto -  contenido.data.alto
			mitadY = rangoY / 2
			posicionY = rangoY*ratioY-mitadY
		}else {
			// Los contenidos son mas anchos que la mascara
			ratioAltos = alto / contenido.data.alto
			rangoY =  contenido.data.alto - alto
			mitadY = rangoY / 2
			posicionY = rangoY*ratioY-mitadY
		}
		var posicion:Punto = contenido.data.posicion.clone()
		posicion.y = posicionY
		var newData:DataContenido = new DataContenido(contenido.data.ancho, contenido.data.alto, posicion)
		contenido.setData(newData)
	}
	public function initDrag(punto:Punto) {
		//trace("(Panel.initDrag)!")
		if (!dragBloqueado) {
			enDrag=true
			_puntoPress = filtrarPunto(punto)
			var obj:Object = new Object()
			obj.type = "onInitDragPanel"
			obj.puntoPress = puntoPress
			obj.puntoDrag = filtrarPunto(puntoPress)
			obj.incX = puntoDrag.x - puntoPress.x
			obj.incY = puntoDrag.y - puntoPress.y
			emisor.emitir_objeto(obj)
		}
	}
	public function actualizarDrag(punto:Punto) {
		//trace("(Panel.actualizarDrag): " + punto)
		if (enDrag) {
			_puntoDrag = filtrarPunto(punto)
			var obj:Object = new Object()
			obj.type = "onActualizarDragPanel"
			obj.puntoPress = puntoPress
			obj.puntoDrag = _puntoDrag
			obj.incX = _puntoDrag.x - _puntoPress.x
			obj.incY = _puntoDrag.y - _puntoPress.y
			//trace("   incX: "+obj.incX)
			emisor.emitir_objeto(obj)
		}
	}
	public function pararDrag(punto:Punto) {
		//trace("(Panel.pararDrag)!")
		if (enDrag) {
			enDrag = false
			_puntoDrag = filtrarPunto(punto)
			var obj:Object = new Object()
			obj.type = "onPararDragPanel"
			obj.puntoPress = puntoPress
			obj.puntoDrag = _puntoDrag
			obj.incX = _puntoDrag.x - _puntoPress.x
			obj.incY = _puntoDrag.y - _puntoPress.y
			emisor.emitir_objeto(obj)
			//--
			//_puntoDrag = null
		}
	}
	public function filtrarPunto2(punto:Punto):Punto {
		// ORIGINAL DEL MODIFICADO (PASADO A PUBLICO) 25/07/2012 13:30
		var limIzq:Number = -(ancho/2);
		var limDer:Number = (ancho/2);
		var limSup:Number = -(alto/2);
		var limInf:Number = (alto / 2);
		var newPunto:Punto = punto.clone()
		//trace("newPunto: "+newPunto)
		if (newPunto.x < limIzq) {
			newPunto.x = limIzq
		}
		if (newPunto.x > limDer) {
			newPunto.x = limDer
		}
		if (newPunto.y < limSup) {
			newPunto.y = limSup
		}
		if (newPunto.y > limInf) {
			newPunto.y = limInf
		}
		//trace("newPunto': "+newPunto)
		return newPunto
	}
	public function filtrarPunto(punto:Punto):Punto {
		// MODIFICADO (PASADO A PUBLICO) 25/07/2012 13:30
		var newPunto:Punto = punto.clone()
		newPunto.x = filtrarPuntoX(newPunto.x)
		newPunto.y = filtrarPuntoY(newPunto.y)
		return newPunto
	}
	public function filtrarPuntoX(valorX:Number):Number {
		// NUEVO 25/07/2012 13:30
		var limIzq:Number = -(ancho/2);
		var limDer:Number = (ancho/2);
		if (valorX < limIzq) {
			valorX = limIzq
		}
		if (valorX > limDer) {
			valorX = limDer
		}
		return valorX
	}
	public function filtrarPuntoY(valorY:Number):Number {
		// NUEVO 25/07/2012 13:30
		var limSup:Number = -(alto/2);
		var limInf:Number = (alto/2);
		if (valorY < limSup) {
			valorY = limSup
		}
		if (valorY > limInf) {
			valorY = limInf
		}
		return valorY
	}
	// Getters:
	public function get puntoDrag():Punto { return _puntoDrag; }
	public function get puntoPress():Punto { return _puntoPress; }
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	
	private function emitirActualizacion(evento:String, dataContenido:DataContenido) {
		var obj:Object = new Object()
		obj.type = evento
		obj.anchoPanel = ancho
		obj.altoPanel = alto
		obj.dataContenido = dataContenido
		//--
		var mitadX:Number
		var ratioAnchos:Number
		var rangoX:Number
		var ratioX:Number
		if (ancho >= dataContenido.ancho) {
			// Los contenidos son mas estrechos que la mascara.
			ratioAnchos = dataContenido.ancho / ancho
			rangoX = ancho -  dataContenido.ancho
			mitadX = rangoX / 2
			ratioX = (dataContenido.posicion.x + mitadX) / rangoX
		}else {
			// Los contenidos son mas anchos que la mascara
			ratioAnchos = ancho / dataContenido.ancho
			rangoX =  dataContenido.ancho - ancho
			mitadX = rangoX / 2
			ratioX = (dataContenido.posicion.x + mitadX) / rangoX
		}
		obj.ratioAnchos = ratioAnchos
		obj.rangoX = rangoX
		obj.ratioX = ratioX
		//--
		//--
		var mitadY:Number
		var ratioAltos:Number
		var rangoY:Number
		var ratioY:Number
		if (alto >= dataContenido.alto) {
			// Los contenidos son mas cortos que la mascara.
			ratioAltos = dataContenido.alto / alto
			rangoY = alto -  dataContenido.alto
			mitadY = rangoY / 2
			ratioY = (dataContenido.posicion.y + mitadY) / rangoY
		}else {
			// Los contenidos son mas altos que la mascara
			ratioAltos = alto / dataContenido.alto
			rangoY =  dataContenido.alto - alto
			mitadY = rangoY / 2
			ratioY = (dataContenido.posicion.y + mitadY) / rangoY
		}
		obj.ratioAltos = ratioAltos
		//trace("---ratioAltos: "+ratioAltos)
		obj.rangoY = rangoY
		obj.ratioY = ratioY
		//--
		emisor.emitir_objeto(obj)
	}
	//--------------------
	// EMISOR:
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento, ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento, ref);
	}
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// EVENTOS:
	private function onActualizarContenido(objEvento:Object) {
		var dataContenido:DataContenido = objEvento.data
		emitirActualizacion("onActualizarContenidoPanel", dataContenido)
	}
	//--------------------
	// SNIPPETS:
}