/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 25/04/2008 12:45
*/
import mx.data.encoders.Num;
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
import com.ionewmedia.utils.estaticas.Array2
class com.ionewmedia.utils.GUI.IOWindows.GestorMinimizadas {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var minAnchoMinimizada:Number = 75
	public var maxAnchoMinimizada:Number = 200
	//--
	private var stageListener:Object
	private var emisor:EmisorExtendido
	private var data:Object	
	//--------------------
	// CONSTRUCTORA:
	function GestorMinimizadas(){
		trace("(GestorMinimizadas.CONSTRUCTORA)!")
		emisor=new EmisorExtendido()
		data = new Object()
		data.anchoMinimizada=null
		data.array_items = new Array()
		init_StageListeners()
	}
	//--------------------
	// METODOS PUBLICOS:
	public function minimizar(ventanaId:String, posX:Number, posY:Number):Void {
		trace("(GestorMinimizadas.minimizar): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			trace("ATENCION: La ventana "+ventanaId+" ya estaba minimizada!")
		}else {
			data[ventanaId] = new Object()
			data[ventanaId].posX_restaurada = posX
			data[ventanaId].posY_restaurada = posY
			data.array_items.push(ventanaId)
			//--
			eval_estado()
			//--
			var obj:Object = new Object()
			obj.type = "onVentanaMinimizada"
			obj.ventanaId = ventanaId
			obj.anchoMinimizada = data.anchoMinimizada
			emisor.emitir_objeto(obj)
			//--
			actualizarMinimizadas()
		}
	}
	public function restaurar(ventanaId:String, posX:Number, posY:Number):Void {
		trace("(GestorMinimizadas.restaurar): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			//--
			if (posX==undefined || posX==null) {
				posX=data[ventanaId].posX_restaurada
			}
			if (posY==undefined || posY==null) {
				posY=data[ventanaId].posY_restaurada
			}
			//--
			data.array_items = Array2.quitarElem(data.array_items, ventanaId) 
			data[ventanaId]=null
			//--
			eval_estado()
			//--
			var obj:Object = new Object()
			obj.type = "onVentanaRestaurada"
			obj.ventanaId = ventanaId
			obj.posX = posX
			obj.posY = posY
			emisor.emitir_objeto(obj)
			//--
			actualizarMinimizadas()
		}else {
			trace("ATENCION: Se pide restaurar una ventana no minimizada")
		}
	}
	public function cerrarVentana(ventanaId:String):Void {
		trace("(GestorMinimizadas.cerrarVentana): "+ventanaId)
		//--
		data.array_items = Array2.quitarElem(data.array_items, ventanaId) 
		data[ventanaId] = null
		//--
		eval_estado()
		//--
		actualizarMinimizadas()
	}
	public function cerrarTodas() {
		trace("(GestorMinimizadas.cerrarTodas)!")
		for (var i = 0; i < data.array_items.length; i++ ) {
			var ventanaId:String=data.array_items[i]
			data[ventanaId] = new Object()
		}
		data.array_items = new Array()
		//--
		eval_estado()
		//--
		actualizarMinimizadas()
	}
	public function get_arrayMinimizadas():Array {
		return data.array_items
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_StageListeners() {
		var donde = this;
		stageListener = new Object();
		stageListener.onResize = function() {
			donde.eval_estado();
			donde.actualizarMinimizadas();
		};
		Stage.addListener(stageListener);
	}
	private function eval_estado() {
		var numMinimizadas:Number = data.array_items.length
		var anchoPreferido:Number = numMinimizadas * maxAnchoMinimizada
		var anchoMinimizada:Number
		if (anchoPreferido>Stage.width) {
			anchoMinimizada = Math.floor(Stage.width / numMinimizadas)
			if (anchoMinimizada < minAnchoMinimizada) {
				anchoMinimizada=minAnchoMinimizada
			}
		}else {
			anchoMinimizada = Math.floor(anchoPreferido / numMinimizadas)
		}
		data.anchoMinimizada=anchoMinimizada
		for (var i = 0; i < data.array_items.length; i++ ) {
			var ventanaId:String = data.array_items[i]
			data[ventanaId].posX_minimizada = i * anchoMinimizada
			data[ventanaId].anchoMinimizada=anchoMinimizada
		}
	}
	private function actualizarMinimizadas() {
		var obj:Object = new Object()
		obj.type = "onActualizarMinimizadas"
		obj.data = data
		emisor.emitir_objeto(obj)
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onVentanaMinimizada", ref);
		emisor.addEventListener("onVentanaRestaurada", ref);
		emisor.addEventListener("onActualizarMinimizadas", ref);
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
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// SNIPPETS:
}