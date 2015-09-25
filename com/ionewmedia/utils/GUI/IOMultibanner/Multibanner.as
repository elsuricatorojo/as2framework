/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20080305
*/
import mx.data.types.Str;
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Array2
import com.ionewmedia.utils.GUI.IOMultibanner.XMLParser_Multibanner
import com.ionewmedia.utils.loaders.buffers.Buffer
import com.ionewmedia.utils.timers.Pulsar2
class com.ionewmedia.utils.GUI.IOMultibanner.Multibanner extends MovieClip{
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	// {ancho, alto, forzarDimensiones, enmascarar, pausaDefecto, colorFondo, refPrecarga}
	public var id:String = null
	public var ancho:Number = 100
	public var alto:Number = 100
	public var forzarDimensiones:Boolean = false
	public var enmascarar:Boolean = true
	public var pausaDefecto:Number = 2
	public var colorFondo:String = "000000"
	public var alphaFondo:Number=100
	public var refPrecarga:Object = null // Instancia a la que suscribirá el evento onProgressCarga
	public var limiteVelocidadCarga:Number = 10 // Limitador de velocidad de carga que luego se pasa DataPrecarga2
	public var saltarseNoCargadas:Boolean = false // Indica si mientras se cargan todas las imagenes se hace ciclos con ya cargadas
	public var tiempoTransicionAlpha:Number = 1 // Indica el tiempo que llevará la transición de una imagen a otra.
	public var pausarEnRollover:Boolean = false
	public var pausarTrasCarga:Boolean = false // Indica si el buffer debe pausarse tras cargar un elemento con éxito.
	// NUEVO 20080322
	public var autoArranque:Boolean=true // Indica si tras hacer init() se comienza a cargar la primera imagen
	//--
	public var msk:MovieClip
	public var contenedor:MovieClip
	public var fondo:MovieClip
	//--
	private var buffer:Buffer
	private var imagenActual:String=null
	private var arrayImagenes:Array
	private var arrayImagenesCargadas:Array
	private var arrayImagenesInicializadas:Array
	private var reloj:Pulsar2 // Para el setInterval()
	private var pausaTerminada:Boolean=true
	private var pausado:Boolean = false
	private var pausadoPorCarga:Boolean = false
	private var pausadoPorDelegado:Boolean = false
	private var enTransicion:Boolean=false
	private var cambiarAlDespausar:Boolean = false
	private var todoCargado:Boolean = false
	private var cargaPausada:Boolean=false
	//--
	private var emisor:EmisorExtendido
	private var data:XMLParser_Multibanner
	//--------------------
	// CONSTRUCTORA:
	function Multibanner(){
		trace("(Multibanner.CONSTRUCTORA)!")
		this._visible=false
		data = new XMLParser_Multibanner()
		emisor = new EmisorExtendido()
		buffer = new Buffer()
		buffer.addListener(this)
		reloj = new Pulsar2(0)
		reloj.addListener(this)
	}
	public function init() {
		trace("(Multibanner.init): "+id)
		this._visible = true
		init_fondo()
		init_msk()
		init_precarga()
		//--
		arrayImagenes = data.get_data().array_items
		arrayImagenesCargadas = new Array()
		arrayImagenesInicializadas=new Array()
		//--
		crearImagenes()
	}
	public function testScope(txt:String) {
		trace("(Multibanner.testScope) <-------------------  "+txt)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_data(objXML:XML):Void {
		data.set_data(objXML)	
	}
	public function set_replaceData(obj:Object):Void {
		// Recibe un obj ya formateado según XMLParser_Multibanner y lo asigna al data
		data.replace_data(obj)	
	}
	public function saltarA(imagenId:String):Void {
		trace("(Multibanner.saltarA): "+imagenId)
		var existe:Boolean = Array2.estaEnElArray(arrayImagenes, imagenId)
		var cargada:Boolean = Array2.estaEnElArray(arrayImagenesCargadas, imagenId)
		trace ("   existe: " + existe)
		trace ("   cargada: "+cargada)
		if (existe) {
			if (cargada) {
				if (imagenId==imagenActual) {
					trace("(Multibanner): ERROR: Se intenta saltar a la imagen que ya se está mostrando")
				}else if (enTransicion) {
					trace("(Multibanner): ERROR: Se intenta saltar a una imagen mientras se está en la transición de aparicion de otra")
				}else {
					//finPausa()
					reloj.parar()
					pausaTerminada=true
					mostrarImagen(imagenId)
				}
			}else {
				trace("(Multibanner): ERROR: Se intenta saltar a una imagen que no está cargada")
			}
		}else {
			trace("(Multibanner): ERROR: Se intenta saltar a una imagen que no existe")
		}
	}
	public function kill() {
		trace("(Multibanner.kill)!")
		emisor.removeAllListeners()
		buffer.removeAllListeners()
		reloj.parar()
	}
	public function imagenInicializada(imagenId:String):Void {
		//trace("(Multibanner.imagenInicializada): "+imagenId)
		var existe:Boolean = Array2.estaEnElArray(arrayImagenes, imagenId)
		if (existe) {
			arrayImagenesInicializadas.push(imagenId)
		}else {
			Trace.trc("(Multibanner): ERROR: SE ESTÁ INICIALIZANDO ("+imagenId+") UNA IMAGEN DEL MULTIBANNER NO PRESENTE EN EL MODELO DE DATOS")
		}
		if (arrayImagenesInicializadas.length == arrayImagenes.length) {
			// NUEVO 20080322
			if (autoArranque) {
				Trace.trc("(Multibanner): Todas la imagenas inicializadas. Comienza la carga (autoArranque=true)!")
				comenzarCarga()
			}else {
				Trace.trc("(Multibanner): Todas la imagenas inicializadas. Se pausa la carga (autoArranque=false)!")
				cargaPausada=true
			}
		}
	}
	public function imagenMostrada(imagenId:String):Void {
		Trace.trc("(Multibanner.imagenMostrada): "+imagenId)
		enTransicion=false
		//--
		var obj:Object = new Object()
		obj.type = "onImagenMostrada"
		obj.imagenId = imagenId
		obj.multibannerId = id
		emisor.emitir_objeto(obj)
		//--
		var dataImagen:Object = data.get_dataItem(imagenId)
		var pausa:Number = dataImagen.pausa
		if (pausa == null) {
		 pausa=pausaDefecto
		}
		var pausaDelegada:Number = dataImagen.pausaDelegada
		if (!pausaDelegada) {
			pausadoPorDelegado=false
			iniciarPausa(pausa, imagenId)
		}else {
			pausadoPorDelegado=true
		}
	}
	// PAUSA:
	public function pausar() {
		if(!pausado){
			pausado = true
		}
	}
	public function despausar() {
		Trace.trc("(Multibanner.despausar)!")
		Trace.trc("   pausado: " + pausado)
		Trace.trc("   pausaTerminada: " + pausaTerminada)
		Trace.trc("   cambiarAlDespausar: " + cambiarAlDespausar)
		if (pausado) {
			Trace.trc("   ...despausamos")
			pausado = false
			if (pausaTerminada && cambiarAlDespausar) {
				cambiarAlDespausar = false
				mostrarSiguienteImagen()
			}
		}
	}
	public function finPausaDelegada(imagenId:String) {
		//trace("(Multibanner.finPausaDelegada): "+imagenId)
		if(imagenId==imagenActual){
			pausadoPorDelegado=false
			finPausa(imagenId)
		}
	}
	public function reanudarCarga():Void {
		//trace("(Multibanner.reanudarCarga)! ")
		if (!todoCargado && cargaPausada) {
			trace("(Multibanner.reanudarCarga): Se reanuda la secuencia de carga!")
			cargaPausada=false
			buffer.resumir()
		}else {
			trace("(Multibanner.reanudarCarga): Se ha intentado reanudar una secuencia de carga que ya estaba en progreso!")
		}
	}
	
	//nuevo 19 febrero 2009
	public function ocultaBtClickTag( )
	{
		var obj:Object = new Object()
		obj.type = "onOcultaBtClickTag"
		emisor.emitir_objeto(obj)
		
	}
	public function muestraBtClickTag( )
	{
		var obj:Object = new Object()
		obj.type = "onMuestraBtClickTag"
		emisor.emitir_objeto(obj)
		
	}
	//nuevo 19 febrero 2009
	
	// GETTERS:
	public function get_imagenActual():String {
		return imagenActual
	}
	public function get_arrayCarga():Array {
		//trace("(Multibanner.get_arrayCarga)! ")
		trace("   arrayImagenes: "+data.get_data().array_items)
		return (data.get_data().array_items)
	}
	public function get_arrayImagenesCargadas():Array {
		return (arrayImagenesCargadas)
	}
	public function get_data():Object {
		//trace("(Multibanner.get_data)! ")
		return (data.get_data())
	}
	public function get_enTransicion() {
		return enTransicion
	}
	//--------------------
	// METODOS PRIVADOS:
	private function crearImagenes():Void {
		for (var i = 0; i < arrayImagenes.length; i++) {
			var imagenId:String = arrayImagenes[i]
			contenedor.attachMovie("ID_MultibannerImagen", imagenId, 10 + i)
			contenedor[imagenId].imagenId = imagenId
			contenedor[imagenId].multibanner = this
			contenedor[imagenId].buffer = buffer
			contenedor[imagenId].data = data.get_dataItem(imagenId)
			//--
			buffer.nuevaCarga(imagenId)
		}	
	}
	private function comenzarCarga() {
		//trace("(Multibanner.comenzarCarga)!")
		buffer.comenzar()
	}
	private function mostrarImagen(imagenId:String):Void {
		Trace.trc("(Multibanner.mostrarImagen): "+imagenId)
		enTransicion=true
		//--
		imagenActual = imagenId
		//--
		var obj:Object = new Object()
		obj.type = "onMostrarImagen"
		obj.imagenId = imagenId
		obj.multibannerId = id
		emisor.emitir_objeto(obj)
	}
	private function mostrarSiguienteImagen() {
		Trace.trc("(Multibanner.mostrarSiguienteImagen)!")
		if (arrayImagenes.length > 1) {
			if (saltarseNoCargadas) {
				if(arrayImagenesCargadas.length>1){
					var posActual:Number = Array2.devolverId(arrayImagenesCargadas, imagenActual)
					var siguientePos:Number = posActual + 1
					if (siguientePos >= arrayImagenesCargadas.length) {
						siguientePos=0
					}
					var siguienteImagen:String = arrayImagenesCargadas[siguientePos]
					pausadoPorCarga=false
					mostrarImagen(siguienteImagen)
				}else {
					pausadoPorCarga=true
				}
			}else {
				var posActual:Number = Array2.devolverId(arrayImagenes, imagenActual)
				var siguientePos:Number = posActual + 1
				if (siguientePos >= arrayImagenes.length) {
						siguientePos=0
				}
				var siguienteImagen:String = arrayImagenes[siguientePos]
				var imagenCargada:Boolean = Array2.estaEnElArray(arrayImagenesCargadas, siguienteImagen)
				if (imagenCargada) {
					pausadoPorCarga=false
					mostrarImagen(siguienteImagen)
				}else {
					pausadoPorCarga=true
				}
			}
		}
	}
	// PAUSA:
	private function iniciarPausa(pausa:Number, imagenId:String):Void {
		//trace("(Multibanner.iniciarPausa): "+imagenId+" : "+pausa)
		pausaTerminada = false
		cambiarAlDespausar=false
		reloj.set_secs(pausa)
		reloj.init()
	}
	private function finPausa():Void {
		Trace.trc("(Multibanner.finPausa)! ")
		Trace.trc("  pausado: "+pausado)
		reloj.parar()
		pausaTerminada=true
		if (pausado) {
			cambiarAlDespausar=true
		}else {
			mostrarSiguienteImagen()
		}
	}
	//--
	// INITS:
	private function init_fondo() {
		fondo._width = ancho
		fondo._height = alto
		fondo._alpha=alphaFondo
		var colorFondoHex:Number=parseInt(colorFondo, 16)
		var fondoColor:Color = new Color(fondo)
		fondoColor.setRGB(colorFondoHex)
	}
	private function init_msk() {
		if (enmascarar) {
			msk._width = ancho
			msk._height=alto
		}else {
			msk.swapDepths(this.getNextHighestDepth())
			msk.removeMovieClip()
		}
	}
	private function init_precarga() {
		refPrecarga.testScope("(Multibanner)")
		if(refPrecarga!=null){
			buffer.addListener(refPrecarga)
		}
	}
	//--------------------
	// BUFFER:
	public function onComenzarCarga(obj:Object) {
		var cargaId:String = obj.cargaId
		var objEvento:Object = new Object()
		objEvento.type = "onComenzarCargaImagen"
		objEvento.imagenId = cargaId
		obj.multibannerId = id
		emisor.emitir_objeto(objEvento)
	}
	public function onExitoCarga(obj:Object) {
		//trace("(Multibanner.onExitoCarga): "+obj.cargaId)
		var cargaId:String = obj.cargaId
		var existe:Boolean = Array2.estaEnElArray(arrayImagenesCargadas, cargaId)
		if (!existe) {
			arrayImagenesCargadas.push(cargaId)
		}else {
			Trace.trc("(Multibanner): ERROR: SE HA CARGADO UNA IMAGEN ("+cargaId+") QUE YA ESTABA CARGADA.")
		}
		//--
		if (imagenActual == null) {
			var primeraImagen:String = arrayImagenesCargadas[0]
			mostrarImagen(primeraImagen)
		}else if (pausadoPorCarga) {
			mostrarSiguienteImagen()
		}
		//--
		if (!pausarTrasCarga) {
			Trace.trc("(Multibanner): LA SECUENCIA DE CARGA SE REANUDA POR LA PREFERENCIA 'pausarTrasCarga=true'")
			buffer.resumir()
		}else {
			Trace.trc("(Multibanner): LA SECUENCIA DE CARGA SE DETIENE POR LA PREFERENCIA 'pausarTrasCarga=false'")
			cargaPausada=true
		}
		//--
		var objEvento:Object = new Object()
		objEvento.type = "onImagenCargada"
		objEvento.imagenId = cargaId
		obj.multibannerId = id
		emisor.emitir_objeto(objEvento)
	}
	public function onErrorCarga(obj:Object) {
		//trace("(Multibanner.onErrorCarga): "+obj.cargaId)
		var cargaId:String = obj.cargaId
		Trace.trc("(Multibanner): ERROR: SE HA PRODUCIDO UN ERROR AL CARGAR UNA IMAGEN ("+cargaId+")")
	}
	public function onTodoCargado():Void {
		todoCargado = true
		var objEvento:Object = new Object()
		objEvento.type = "onTodoMultibannerCargado"
		objEvento.multibannerId = id
		emisor.emitir_objeto(objEvento)
	}
	//--------------------
	// PULSAR2:
	public function onPulso() {
		//trace("(Multibanner.onPulso)")
		finPausa()
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onComenzarCargaImagen", ref);
		emisor.addEventListener("onMostrarImagen", ref);
		emisor.addEventListener("onImagenMostrada", ref);
		emisor.addEventListener("onImagenCargada", ref);
		emisor.addEventListener("onTodoMultibannerCargado", ref);
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
