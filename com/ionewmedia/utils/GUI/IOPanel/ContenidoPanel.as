/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 02/04/2010 12:38
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.geom.Punto;
//--
import com.ionewmedia.utils.GUI.IOPanel.Panel
import com.ionewmedia.utils.GUI.IOPanel.DataContenido
//--
class com.ionewmedia.utils.GUI.IOPanel.ContenidoPanel {
	// import com.ionewmedia.utils.GUI.IOPanel.ContenidoPanel
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var data:DataContenido
	public var panel:Panel
	//--
	private var inicializado:Boolean = false
	private var emisor:EmisorExtendido;
	//--------------------
	// CONSTRUCTORA:
	public function ContenidoPanel(_panel:Panel, _data:DataContenido) {
		trace("(ContenidoPanel.CONSTRUCTORA)!")
		data = _data
		trace(data)
		//--
		panel = _panel
		panel.addEventListener("onInitPanel", this)
		panel.addEventListener("onActualizarDragPanel", this)
		panel.addEventListener("onPararDragPanel", this)
		//--
		emisor = new EmisorExtendido()
		//--
		panel.registrar_contenido(this);
	}
	public function testScope(txt:String) {
		trace("(ContenidoPanel.testScope) ------------ "+txt)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function setData(newData:DataContenido):Void {
		trace("(ContenidoPanel.setData): "+newData)
		data = newData.clone()
		data.posicion = filtrarPosicion(data.posicion)
		if (inicializado) {
			var obj:Object = new Object()
			obj.type = "onActualizarContenido"
			obj.data = data
			emisor.emitir_objeto(obj)
		}
	}
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	private function init() {
		trace("(ContenidoPanel.init)!")
		inicializado = true
		var obj:Object = new Object()
		obj.type = "onInitContenido"
		obj.data = data
		emisor.emitir_objeto(obj)
	}
	private function actualizarPosicion(incX:Number, incY:Number, fijar:Boolean):Void {
		// Reposiciona en base a un incremento en sus coordenadas
		//trace("(ContenidoPanel.init) actualizarPosicion: " + incX + "   incY: " + incY+"  fijar: "+fijar)
		var newData:DataContenido 
		if (fijar) {
			data.posicion.x = data.posicion.x +incX
			data.posicion.y = data.posicion.y +incY
			data.posicion = filtrarPosicion(data.posicion)
			newData = data.clone()
		}else {
			newData = data.clone()
			newData.posicion.x = newData.posicion.x +incX
			newData.posicion.y = newData.posicion.y +incY
			newData.posicion = filtrarPosicion(newData.posicion)
		}
		//--
		var obj:Object = new Object()
		obj.type = "onActualizarContenido"
		obj.data = newData
		emisor.emitir_objeto(obj)
	}
	private function filtrarPosicion(punto:Punto):Punto {
		var newPunto:Punto = punto.clone()
		var limIzq:Number
		var limDer:Number
		var aireX:Number = (data.ancho - panel.ancho) / 2
		if (aireX >= 0) {
			limIzq = -aireX
			limDer = aireX
		}else {
			var margenX:Number = ( panel.ancho -data.ancho) / 2
			limIzq = -margenX
			limDer = margenX
		}
		if (newPunto.x<limIzq) {
			newPunto.x = limIzq
		}
		if (newPunto.x>limDer) {
			newPunto.x = limDer
		}
		//--
		
		var limSup:Number 
		var limInf:Number
		var aireY:Number = (data.alto - panel.alto) / 2
		if (aireY >= 0) {
			limSup = -aireY
			limInf = aireY
		}else {
			var margenY:Number = ( panel.alto -data.alto) / 2
			limSup = -margenY
			limInf = margenY
		}
		if (newPunto.y<limSup) {
			newPunto.y = limSup
		}
		if (newPunto.y>limInf) {
			newPunto.y = limInf
		}
		return newPunto
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
	// Panel:
	private function onInitPanel(obj:Object) {
		trace("(ContenidoPanel.onInitPanel)!")
		init()
	}
	private function onActualizarDragPanel(obj:Object) {
		actualizarPosicion(obj.incX, obj.incY, false)
	}
	private function onPararDragPanel(obj:Object) {
		trace("(ContenidoPanel.onPararDragPanel)!")
		actualizarPosicion(obj.incX, obj.incY, true)
	}
	//--------------------
	// SNIPPETS:
}