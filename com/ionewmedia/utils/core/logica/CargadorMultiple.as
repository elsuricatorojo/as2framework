/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 07/04/2009 11:43
*/
import com.ionewmedia.utils.loaders.v2.CargadorComm2;
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.data.Datos;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.loaders.buffers.Buffer;
import com.ionewmedia.utils.loaders.v2.CargadorXML2;
//--
import com.ionewmedia.utils.core.logica.Paths
//--
class com.ionewmedia.utils.core.logica.CargadorMultiple {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var id:String = null
	private var inicializado:Boolean = false
	//--
	private var array_cargaIds:Array
	private var array_pesoRelativos:Array
	private var array_pesoCarga:Array
	private var array_opcionesCargadas:Array
	//--
	private var buffer:Buffer
	private var emisor:EmisorExtendido;
	private var paths:Paths
	private var items:Datos
	//--
	//private var _configURL:String = "data/config.xml"
	//--------------------
	// CONSTRUCTORA:
	public function CargadorMultiple(_id:String) {
		trace("(CargadorMultiple.COSNTRUCTORA): "+this)
		if (_id!=undefined) {
			id = _id
		}
		emisor = new EmisorExtendido()
		buffer = new Buffer(id)
		buffer.set_resumeOnExito(false)
		buffer.addListener(this)
		//--
		paths = Paths.getInstance()
		//--
		array_cargaIds = new Array()
		array_pesoRelativos = new Array()
		array_opcionesCargadas = new Array()
		//--
		items = new Datos("asociaciones_cargas")
		set_path("config_xml", "data/config.xml") // valor por defecto
	}
	public function init() {
		trace("(CargadorMultiple.init)!")
		if (!inicializado) {
			inicializado = true
			set_array_pesoCarga()
			for (var i = 0; i < array_cargaIds.length; i++) {
				var cargaId:String = array_cargaIds[i]
				buffer.nuevaCarga(cargaId)
			}
		}else {
			trace("ATENCION: Se está intentando llamar a init() cuando la clase ya está inicializada. No se hace nada.")
		}
	}
	// NUEVO: 24/03/2011 19:55
	public function set_resumeOnExito(valor:Boolean) {
		if (!inicializado) {
			buffer.set_resumeOnExito(valor)
		}else {
			trace("ATENCION: Se está intentando acceder a un metodo diseñado para ser accedido antes del init")
		}
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevaCarga(cargaId:String, pesoRelativo:Number) {
		if(!inicializado){
			trace("(CargadorMultiple.nuevaCarga) cargaId:"+cargaId+"  pesoRelativo: "+pesoRelativo)
			array_cargaIds.push(cargaId)
			array_pesoRelativos.push(pesoRelativo)
		}else {
			trace("ATENCION: Se está intentando llamar a nuevaCarga() cuando la clase ya está inicializada. No se hace nada.")
		}
	}
	public function comenzar():Void {
		trace("(CargadorMultiple.comenzar)!")
		buffer.comenzar()
	}
	public function resumir():Void {
		trace("(CargadorMultiple.resumir)!")
		buffer.resumir()
	}
	public function cargar_xml(cargaId:String) {
		trace("(CargadorMultiple.cargar_xml): "+cargaId)
		var path:String
		var existe:Boolean = items.evalExiste(cargaId)
		if (existe) {
			var item:Object = items.getItem(cargaId)
			path = item.path
		}else {
			path = Paths.getPath(cargaId)
		}
		var cargador:CargadorXML2 = new CargadorXML2 (path, cargaId, buffer);
		cargador.init();
	}
	// NUEVO: 03/07/2009 9:51
	public function cargar_comm(cargaId:String, metodo:String, objSend:Object, get_simulado:Boolean) {
		trace("(CargadorMultiple.cargar_comm): "+cargaId)
		if (metodo==undefined || metodo==null) {
			metodo="POST"
		}
		if (objSend==undefined || objSend==null) {
			objSend=null
		}
		if (get_simulado==undefined || get_simulado==null) {
			get_simulado=false
		}
		//--
		var path:String
		var existe:Boolean = items.evalExiste(cargaId)
		if (existe) {
			var item:Object = items.getItem(cargaId)
			path = item.path
		}else {
			path = Paths.getPath(cargaId)
		}
		path = get_pathFiltrado(path, metodo, objSend, get_simulado)
		trace("   path: "+path)
		var cargador:CargadorComm2 = new CargadorComm2 (path, cargaId, buffer);
		if (metodo=="POST" && objSend!=null) {
			cargador.set_objSend(objSend)
		}
		cargador.init();
	}
	public function set_path(cargaId:String, path:String) {
		trace("(CargadorMultiple.set_path): "+cargaId+" : "+path)
		var existe:Boolean = items.evalExiste(cargaId)
		if (!existe) {
			var obj:Object = new Object()
			obj.cargaId = cargaId
			obj.path = path
			items.nuevoItem(cargaId, obj)
		}else {
			var item:Object = items.getItem(cargaId)
			item.path = path
		}
	}
	// NUEVO 31/10/2014 9:50
	public function forzarTodoCargado() {
		trace("(CargadorMultiple.forzarTodoCargado)!")
		buffer.forzarTodoCargado()
	}
	// Getters:
	// Setters:
	public function set configURL(value:String):Void {
		set_path("config_xml", value)
		//_configURL = value;
	}
	//--------------------
	// METODOS PRIVADOS:
	private function get_pathFiltrado(path:String, metodo:String, objSend:Object, get_simulado:Boolean):String {
		var pathFiltrado:String = path
		if (metodo=="GET") {
			if (!get_simulado && objSend!=null) {
				pathFiltrado+="?"
				for (var param in objSend) {
					var valor:String = objSend[param]
					pathFiltrado +=param+"="+valor+"&"
				}
			}
		}
		return pathFiltrado
	}
	//--
	private function set_array_pesoCarga () {
		// En base a los pesos relativos de los elementos de carga calcula los pesos de carga...
		// ... de tal forma que todos sumen 1.
		array_pesoCarga=new Array()
		var sumaTotal:Number = 0
		for (var i = 0; i < array_pesoRelativos.length; i++) {
			sumaTotal=sumaTotal+array_pesoRelativos[i]
		}
		for (var i = 0; i < array_pesoRelativos.length; i++) {
			var peso:Number = array_pesoRelativos[i] / sumaTotal
			array_pesoCarga.push(peso)
		}
	}
	private function itemCargado(cargaId:String) {
		//Trace.trc("(CargadorMultiple.itemCargado) cargaId: " + cargaId);
		var posItem:Number = Array2.devolverId(array_cargaIds, cargaId);
		var ratioAcumulado:Number = 0;
		for (var i = 0; i <= posItem; i++) {
			ratioAcumulado = ratioAcumulado + array_pesoCarga[i];
		}
		var porcentaje:Number = Math.round(100 * ratioAcumulado);
		//--
		//trace("   porcentaje: " + porcentaje);
		pintar_porcentaje(porcentaje);
	}
	private function itemProgress(cargaId:String, porcentajeItem:Number) {
		//Trace.trc("(CargadorMultiple.itemProgress) cargaId: " + cargaId + "  porcentajeItem: " + porcentajeItem);
		var posItem:Number = Array2.devolverId(array_cargaIds, cargaId);
		var ratioAcumulado:Number = 0;
		if (posItem > 0) {
			for (var i = 0; i <= (posItem - 1); i++) {
				ratioAcumulado = ratioAcumulado + array_pesoCarga[i];
			}
		}
		var porcentaje:Number = Math.round(100 * ratioAcumulado);
		var ratioItem:Number = array_pesoCarga[posItem];
		var parteItem:Number = Math.round(porcentajeItem * ratioItem);
		porcentaje = porcentaje + parteItem;
		//--
		if(!isNaN(porcentaje)){
			pintar_porcentaje(porcentaje);
		}
	}
	private function pintar_porcentaje(porcentaje:Number) {
		Trace.trc("(CargadorMultiple.pintar_porcentaje)id: "+id+"  porcentaje: " + porcentaje);
		var obj:Object = new Object();
		obj.type = "onNuevoPorcentaje";
		obj.porcentaje = porcentaje;
		emisor.emitir_objeto(obj);
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
	// BUFFER:
	public function get_buffer():Buffer {
		return buffer
	}
	public function addBufferListener(ref:Object):Void {
		buffer.addListener(ref)
		// NUEVO: 29/06/2009 12:58
		this.addEventListener("onNuevoPorcentaje", ref)
	}
	//--------------------
	// EVENTOS:
	private function onExitoCarga(obj:Object) {
		trace("(CargadorMultiple.onExitoCarga): " + obj.cargaId)
		// NUEVO: 29/06/2009
		if (obj.bufferId == id) {
			trace("EVENTO PERTENECIENTE A ESTE BUFFER!")
			itemCargado(obj.cargaId);
		}
	}
	private function onProgressCarga(obj:Object) {
		itemProgress(obj.cargaId,obj.porcentaje);
	}
	//--------------------
	// SNIPPETS:
}