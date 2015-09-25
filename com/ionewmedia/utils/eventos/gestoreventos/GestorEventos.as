import mx.events.EventDispatcher;
import com.ionewmedia.utils.eventos.gestoreventos.Listener;
class com.ionewmedia.utils.eventos.gestoreventos.GestorEventos {
	//---------------------------------------------------------
	// DOCUMENTACION:
	// (Terminada v1.0: 26-10-2005).- Roberto Ferrero 
	// El objeto de esta clase es de actuar como capa intermedia entre la aplicación y las clase EventDispatcher
	// de tal forma que guarde un registro de oyentes y los eventos a los que esté suscrito cada oyente.
	//---------------------------------------------------------
	// PARAMETROS:
	var addEventListener:Function;
	var removeEventListener:Function;
	var dispatchEvent:Function;
	var dispatchQueue:Function;
	//--
	private var data_listeners:Object;
	private var _autonumerico:Number;
	//---------------------------------------------------------
	// CONSTRUCTORA:
	function GestorEventos() {
		trace("(GestorEventos.CONSTRUCTORA)!");
		_autonumerico = 0;
		init_emisor();
	}
	private function init_emisor() {
		data_listeners = new Object();
		data_listeners.array_listeners = new Array();
		EventDispatcher.initialize(this);
	}
	//---------------------------------------------------------
	// REGISTRO:
	public function registrar(evento:String, donde:Object) {
		//trace("(GestorEventos.registrar): "+evento);
		var objExiste:Object = eval_existe_listener(donde);
		if (objExiste.existe) {
			//trace("   EL LISTENER YA ESTA REGISTRADO.");
			var objListener:Listener = data_listeners[objExiste.listenerId];
			var evento_registrado:Boolean = objListener.eval_evento_registrado(evento);
			if (evento_registrado) {
				trace("   (SE HA INTENTADO REGISTRAR EL EVENTO: "+evento+" AL LISTENER: "+donde+" Y YA ESTABA REG.)");
			} else {
				objListener.anadir_evento(evento);
				registrar_listener(evento, donde);
			}
		} else {
			//trace("   EL LISTENER NO ESTABA REGISTRADO.");
			var listenerId = "LISTENER_"+get_autonumerico();
			var array_eventos:Array = new Array();
			array_eventos.push(evento);
			data_listeners[listenerId] = new Listener(array_eventos, donde, listenerId);
			data_listeners.array_listeners.push(listenerId);
			registrar_listener(evento, donde);
		}
	}
	public function get_eventos(donde:Object):Array {
		// Dada una instancia devuele la lista de eventos a la que está suscrita como oyente
		trace("(GestorEventos.get_eventos)!");
		var listenerId:String = null;
		var array_listeners:Array = data_listeners.array_listeners;
		for (var i = 0; i<array_listeners.length; i++) {
			var esteId = array_listeners[i];
			var este_donde = data_listeners[esteId].donde;
			if (este_donde == donde) {
				listenerId = esteId;
			}
		}
		var array_eventos:Array = data_listeners[listenerId].array_eventos;
		//trace("   eventos: "+array_eventos);
		return array_eventos;
	}
	//---------------------------------------------------------
	// EMISION:
	public function emitir_evento(evento:String) {
		//trace("(GestorEventos.emitir_evento): "+evento);
		var array_registrados:Array = new Array();
		var array_listeners:Array = data_listeners.array_listeners;
		for (var i = 0; i<array_listeners.length; i++) {
			var listenerId = array_listeners[i];
			//trace("   listenerId: "+listenerId);
			var registrado:Boolean = data_listeners[listenerId].eval_evento_registrado(evento);
			//trace("   registrado: "+registrado);
			if (registrado) {
				array_registrados.push(listenerId);
			}
		}
		//trace("LISTENERS REGISTRADOS Al EVENTO: "+evento+": "+array_registrados);
		//var objEvento = new Object();
		//objEvento.type = evento;
		dispatchEvent({type:evento});
		//dispatchEvent(objEvento);
	}
	public function emitir(evento:String) {
		emitir_evento(evento);
	}
	public function emitir_objeto(objEvento:Object) {
		//trace("(GestorEventos.emitir_objeto): "+objEvento.type);
		dispatchEvent(objEvento);
	}
	//---------------------------------------------------------
	// PRIVADAS:
	private function registrar_listener(evento, donde) {
		//trace("(GestorEventos.registrar_listener)!");
		//trace("   evento: "+evento);
		//trace("   donde: "+donde);
		addEventListener(evento, donde);
	}
	//---------------------------------------------------------
	// AUXILIARES:
	private function eval_existe_listener(donde:Object):Object {
		// Evalua si el listener está registrado devolviendo true o false
		//trace("(GestorEventos.eval_existe_listener)!");
		var obj:Object = new Object();
		obj.existe = false;
		obj.listenerId = null;
		var array_listeners = data_listeners.array_listeners;
		for (var i = 0; i<array_listeners.length; i++) {
			var objListener:Listener = data_listeners[array_listeners[i]];
			if (objListener.donde == donde) {
				obj.existe = true;
				obj.listenerId = objListener.listenerId;
			}
		}
		return obj;
	}
	private function get_autonumerico():Number {
		var num = _autonumerico;
		_autonumerico++;
		return num;
	}
	//---------------------------------------------------------
	// SNIPPETS:
	private function array_estaEnElArray(elem, esteArray):Boolean {
		// SNIPPET que devuelve true/false dependiendo de si un elemento está en el array
		var control = false;
		for (var i = 0; i<esteArray.length; i++) {
			if (esteArray[i] == elem) {
				control = true;
			}
		}
		return control;
	}
}
