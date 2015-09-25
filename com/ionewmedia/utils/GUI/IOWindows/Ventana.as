/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20080312
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
//--
import com.ionewmedia.utils.GUI.IOWindows.GestorVentanas
class com.ionewmedia.utils.GUI.IOWindows.Ventana {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var ancho:Number = null // Se ataca directamente sin settter
	public var alto:Number = null // Se ataca directamente sin settter
	public var autoKill:Boolean=true
	//--
	private var ventanaId:String = null
	private var familiaId:String = null
	private var posX:Number = null
	private var posY:Number = null
	private var posXRel:Number = null
	private var posYRel:Number = null
	private var stageListener:Object
	private var enfocada:Boolean
	//--
	private var logicaVentanas:Object = null
	private var mcRef:MovieClip
	private var emisor:EmisorExtendido
	//--------------------
	// CONSTRUCTORA:
	function Ventana(_mcRef:MovieClip, _ventanaId:String, _posX:Number, _posY:Number, _logicaVentanas:Object, _familiaId:String){
		trace("(Ventana.CONSTRUCTORA)!")
		emisor= new EmisorExtendido()
		mcRef = _mcRef
		posX = _posX
		posY = _posY
		ventanaId = _ventanaId
		familiaId = _familiaId
		logicaVentanas = _logicaVentanas
		logicaVentanas.addListener(this)
		//--
		init_stageListener()
	}
	public function init() {
		trace("(Ventana.init)!")
		if (ancho == null || alto == null) {
			trace("Se intenta inicializar una ventana y ésta no tiene ancho y alto definido!!!")	
		}else{
			filtrarPosiciones()
			set_posicionRel()
			enfocada = logicaVentanas.eval_enfocada(ventanaId)
			//--
			var obj:Object = new Object()
			obj.type = "onVentanaInicializada"
			obj.enfocada = enfocada
			emisor.emitir_objeto(obj)
			//--
			actualizarPosicionView(false)
		}
	}
	//--------------------
	// METODOS PUBLICOS:
	public function enfocar() {
		trace("(Ventana.enfocar)!")
		logicaVentanas.enfocarVentana(ventanaId)
	}
	public function updateSize(nuevoAncho:Number, nuevoAlto:Number) {
		ancho = nuevoAncho
		alto = nuevoAlto
		eval_reposicionarPorResize()
	}
	public function updatePos(_posX:Number, _posY:Number):Void {
		trace("(Ventana.updatePos): "+_posX+","+_posY)
		posX = get_safeX(_posX)
		posY = get_safeY(_posY)
		set_posicionRel()
	}
	//--------
	// DRAG:
	public function comenzarDrag() {
		var objLimites:Object = get_objLimites()
		mcRef.startDrag(false, objLimites.limIzq, objLimites.limSup, objLimites.limDer, objLimites.limInf)
	}
	public function pararDrag() {
		mcRef.stopDrag()
		posX = mcRef._x
		posY = mcRef._y
		set_posicionRel()
	}
	private function get_objLimites():Object {
		var objLimites:Object = new Object()
		objLimites.limIzq = logicaVentanas.margenMarco
		objLimites.limDer = Stage.width - logicaVentanas.margenMarco - ancho
		objLimites.limSup = logicaVentanas.margenMarco
		objLimites.limInf = Stage.height - logicaVentanas.margenMarco - alto
		//--
		return objLimites
	
	}
	// CERRAR:
	public function cerrar() {
		logicaVentanas.cerrarVentana(ventanaId)
	}
	
	//--------------------
	// METODOS PRIVADOS:
	private function actualizarPosicionView(animar:Boolean):Void {
		var obj:Object = new Object()
		obj.type = "onActualizarPosicion"
		obj.posX = posX
		obj.posY = posY
		obj.animar = animar
		obj.enfocada = enfocada
		emisor.emitir_objeto(obj)
	}
	private function filtrarPosiciones() {
		posX = get_safeX(posX)
		posY = get_safeY(posY)
	}
	private function set_posicionRel():Void {
		posXRel = posX / Stage.width
		posYRel = posY / Stage.height
	}
	public function get_safeX(nuevaPosX:Number):Number {
		var safeX:Number
		if (logicaVentanas.enmarcar) {
			var limMax:Number = Stage.width - logicaVentanas.margenMarco-ancho
			var limMin:Number = logicaVentanas.margenMarco
			if (nuevaPosX >= limMin && nuevaPosX <= limMax) {
				safeX=nuevaPosX
			}else if (nuevaPosX < limMin) {
				safeX=limMin
			}else if (nuevaPosX > limMax) {
				safeX=limMax
			}
			if (safeX < limMin) {
				safeX=limMin
			}
		}
		return safeX
	}
	public function get_safeY(nuevaPosY:Number):Number {
		var safeY:Number
		if (logicaVentanas.enmarcar) {
			var limMax:Number = Stage.height - logicaVentanas.margenMarco-alto
			var limMin:Number = logicaVentanas.margenMarco
			if (nuevaPosY >= limMin && nuevaPosY <= limMax) {
				safeY=nuevaPosY
			}else if (nuevaPosY < limMin) {
				safeY=limMin
			}else if (nuevaPosY > limMax) {
				safeY=limMax
			}
			if (safeY < limMin) {
				safeY=limMin
			}
		}
		return safeY
	}
	//--------
	// STAGE:
	private function init_stageListener():Void {
		var donde:Ventana=this
		stageListener = new Object()
		stageListener.onResize = function() {
			donde.eval_reposicionarPorResize()
		}
		Stage.addListener(stageListener)
	}
	private function eval_reposicionarPorResize():Void {
		trace("(Ventana.eval_reposicionarPorResize)!")
		if(logicaVentanas.reposicionarAlRedimensionar){
			var nuevaPosX:Number 
			var nuevaPosY:Number
			if (logicaVentanas.posicionarRelativamente) {
				nuevaPosX = Math.round(Stage.width * posXRel)
				nuevaPosY = Math.round(Stage.height * posYRel)
			}else {
				nuevaPosX = get_safeX(posX)
				nuevaPosY = get_safeY(posY)
			}
			posX = nuevaPosX
			posY = nuevaPosY
			filtrarPosiciones()
			actualizarPosicionView(false)
		}
	}
	//--------
	// KILL:
	private function initKill(cerrandoConjunto:Boolean):Void {
		trace("(Ventana.initKill) autoKill: " + autoKill)
		//--
		var obj:Object = new Object()
		obj.type = "onInitKillVentana"
		obj.cerrandoConjunto=cerrandoConjunto
		emisor.emitir_objeto(obj)
		//--
		logicaVentanas.removeListener(this)
		if(autoKill){
			kill()
		}
	}
	public function kill():Void {
		trace("(Ventana.kill)!")
		//logicaVentanas.removeListener(this)
		mcRef.removeMovieClip()
	}
	//------------------
	// EVENTOS:
	public function onNuevaVentana(obj:Object) {
		
	}
	public function onPosicionarVentana(obj:Object) {
		if (ventanaId == obj.ventanaId) {
			posX = obj.posX
			posY = obj.posY
			filtrarPosiciones()
			set_posicionRel()
			actualizarPosicionView(obj.animar)
		}
	}
	public function onEnfocarVentana(obj:Object) {
		if (ventanaId == obj.ventanaId) {
			if (!enfocada) {
				trace("(Ventana.onEnfocarVentana) Enfocamos: "+ventanaId)
				enfocada=true
				emisor.emitir("onEnfocarVentana")
			}
		}else {
			if (enfocada) {
				trace("(Ventana.onEnfocarVentana) Desenfocamos: "+ventanaId)
				enfocada=false
				emisor.emitir("onDesenfocarVentana")
			}
		}
	}
	public function onCerrarTodasVentanas(obj:Object) {
			initKill(true)
	}
	public function onCerrarVentana(obj:Object) {
		if (ventanaId == obj.ventanaId) {
			initKill(false)
		}
	}
	public function onCerrarFamilia(obj:Object) {
		if (familiaId == obj.familiaId) {
			initKill(true)
		}
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onVentanaInicializada", ref);
		emisor.addEventListener("onEnfocarVentana", ref);
		emisor.addEventListener("onDesenfocarVentana", ref);
		emisor.addEventListener("onActualizarPosicion", ref);
		emisor.addEventListener("onInitKillVentana", ref);
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