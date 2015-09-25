/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070531
*/
import com.ionewmedia.utils.eventos.Emisor;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.numeros.Autonumerico;
class com.ionewmedia.utils.eventos.EmisorExtendido {
	//--------------------
	// DOCUMENTACION:
	/*
	Esta Clase está diseñada para añadir algunas funcionalidades a la Clase Emisor
	Para ello crea una instancia de Emisor pero filtra previamente las llamadas a:
	   - addEventListener(evento, ref) -> No permite registrar un listener a un evento al que ya se ha suscrito.
	   - removeEventListener(evento, ref) -> Informa en la ventana de salida si
	      a) el listener existe como tal
	      b) si el listener no estaba suscrito a ese evento.
	  
	Por otro lado añade las siguientes funcionalidades:
	   - removeListener(ref) -> Desuscribe al listener de todos sus eventos
	   - getListenersEvents(ref) -> Devuelve un array con los eventos para los que está suscrito el listener.
	      (En caso de no estar registrado como listener se notifica)
	Mantiene retrocompatibilidad con:
	   GestorEventos: registrar(evento:String, ref:Object) y deregistrar(evento:String, ref:Object)
	   Emisor: registrar(evento:String, ref:Object) y deregistrar(evento:String, ref:Object)
	*/
	//--------------------
	// PARAMETROS:
	//--------------------
	private var emisor:Emisor;
	private var autonumerico:Autonumerico;
	private var data:Object;
	//--------------------
	// CONSTRUCTORA:
	function EmisorExtendido() {
		//trace("(EmisorExtendido.CONSTRUCTORA)!");
		init_data();
		autonumerico = new Autonumerico();
		emisor = new Emisor();
	}
	public function testScope(txt:String):Boolean {
		trace("(EmisorExtendido.testScope) -------------- "+txt);
		return true
	}
	//--------------------
	// METODOS PUBLICOS:
	public function emitir(evento:String):Void {
		//trace("(EmisorExtendido.emitir): "+evento);
		emisor.emitir(evento);
	}
	public function emitir_objeto(objEvento:Object):Void {
		//trace("(EmisorExtendido.emitir_objeto): "+objEvento.type);
		emisor.emitir_objeto(objEvento);
	}
	public function addEventListener(evento:String, ref:Object) {
		var existe:Boolean = eval_existeRef(ref);
		if (existe) {
			sumarEvento(evento, ref);
		} else {
			crearRef(ref);
			sumarEvento(evento, ref);
		}
	}
	public function removeEventListener(evento:String, ref:Object) {
		//trace("(EmisorExtendido.removeEventListener): "+evento);
		quitarEvento(evento, ref);
	}
	//--
	public function removeListener(ref:Object) {
		//trace("(EmisorExtendido.removeListener)!");
		//trace("   ref: "+ref);
		//trace("   data.array_refs: "+data.array_refs);
		var existe:Boolean = Array2.estaEnElArray(data.array_refs, ref);
		if (existe) {
			var itemId:String = get_itemId(ref);
			var array_eventos:Array = data[itemId].array_eventos;
			for (var i = 0; i<array_eventos.length; i++) {
				var evento:String = array_eventos[i];
				quitarEvento(evento, ref);
			}
			data.array_refs = Array2.quitarElem(data.array_refs, ref);
			data.array_items = Array2.quitarElem(data.array_items, itemId);
			data[itemId] = new Object();
			delete data[itemId];
		} else {
			trace("(EmisorExtendido.removeListener) SE ESTA INTENTANDO ELIMINAR UN LISTENER QUE NO EXISTE");
			trace("   listener: "+ref);
		}
	}
	// NUEVO 20080319
	public function removeAllListeners() {
		for (var i = 0; i < data.array_refs.length; i++ ) {
			var ref:Object = data.array_refs[i]
			var itemId:String=get_itemId(ref)
			var arrayEventos:Array = data[itemId].array_eventos
			for (var j = 0; j < arrayEventos.length; j++ ) {
				var evento:String = arrayEventos[j]
				deregistrar(evento, ref)
			}
		}
		init_data()
	}
	// NUEVO 24/04/2009 11:59
	public function esListener(ref:Object):Boolean {
		// Devuelve true o false dependiendo de si la refe esta registrada como listener o no.
		var existe:Boolean = Array2.estaEnElArray(data.array_refs, ref);
		return existe
	}
	public function getListenersEvents(ref:Object):Array {
		var existe:Boolean = Array2.estaEnElArray(data.array_refs, ref);
		var array_eventos:Array = new Array();
		if (existe) {
			var itemId:String = get_itemId(ref);
			array_eventos = data[itemId].array_eventos;
			trace("(EmisorExtendido.getListenersEvents)!");
			trace("   array_eventos: "+array_eventos);
		} else {
			trace("(EmisorExtendido.getListenersEvents) LA REFERENCIA PASADA NO CONSTA COMO LISTENER");
			trace("   listener: "+ref);
		}
		return (array_eventos);
	}
	public function getEventListeners(evento:String):Array {
		var array_listeners:Array = new Array();
		for (var i = 0; i<data.array_items.length; i++) {
			var itemId:String=data.array_items[i]
			var esta:Boolean = Array2.estaEnElArray(data[itemId].array_eventos, evento);
			if (esta) {
				array_listeners.push(data[itemId].ref);
			}
		}
		return (array_listeners);
	}
	//--------------------
	// ANTIGUOS A EVITAR:
	public function registrar(evento:String, ref:Object):Void {
		// Los conservamos para mantener la retrocompatibilidad con la clase Emisor
		// Utilizar mejor addEventListener()
		this.addEventListener(evento, ref);
	}
	public function deregistrar(evento:String, ref:Object):Void {
		// Los conservamos para mantener la retrocompatibilidad con la clase Emisor
		// Utilizar mejor removeEventListener()
		this.removeEventListener(evento, ref);
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_data() {
		data = new Object();
		data.array_refs = new Array();
		data.array_items = new Array();
	}
	private function crearRef(ref:Object) {
		var itemId:String = "listener_"+autonumerico.get();
		data.array_items.push(itemId);
		data.array_refs.push(ref);
		data[itemId] = new Object();
		data[itemId].ref = ref;
		data[itemId].array_eventos = new Array();
	}
	private function sumarEvento(evento:String, ref:Object):Void {
		var itemId:String = get_itemId(ref);
		var yaSuscrito:Boolean = Array2.estaEnElArray(data[itemId].array_eventos, evento);
		if (yaSuscrito) {
			trace("(EmisorExtendido) SE ESTA INTENTANDO REGISTRAR UN LISTENER A UN EVENTO AL QUE YA ESTÁ REGISTRADO");
			trace("   evento: "+evento);
			trace("   listener: "+ref);
		} else {
			data[itemId].array_eventos.push(evento);
			emisor.registrar(evento, ref);
		}
	}
	private function quitarEvento(evento:String, ref:Object):Void {
		var itemId:String = get_itemId(ref);
		var existeRef:Boolean = eval_existeRef(ref);
		if (eval_existeRef) {
			var existeEvento:Boolean = Array2.estaEnElArray(data[itemId].array_eventos, evento);
			if (existeEvento) {
				data[itemId].array_eventos = Array2.quitarElem(data[itemId].array_eventos, evento);
				emisor.removeEventListener(evento, ref);
			} else {
				trace("(EmisorExtendido) SE ESTA INTENTANDO DEREGISTRAR UN LISTENER DE UN EVENTO AL QUE NO! ESTÁ REGISTRADO");
				trace("   evento: "+evento);
				trace("   listener: "+ref);
			}
		} else {
			trace("(EmisorExtendido) SE ESTA INTENTANDO DEREGISTRAR UN LISTENER NO REGISTRADO DE UN EVENTO");
			trace("   evento: "+evento);
			trace("   listener: "+ref);
		}
	}
	private function eval_existeRef(ref:Object):Boolean {
		var existe:Boolean = Array2.estaEnElArray(data.array_refs, ref);
		return (existe);
	}
	private function get_itemId(ref:Object):String {
		// Dado una referencia de un listener devuelve el itemId asociado interno.
		var itemPos:Number = Array2.devolverId(data.array_refs, ref);
		var itemId:String = data.array_items[itemPos];
		return (itemId);
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
