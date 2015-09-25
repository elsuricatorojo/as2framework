//import com.ionewmedia.utils.eventos.gestoreventos.*;
class com.ionewmedia.utils.eventos.gestoreventos.Listener {
	//---------------------------------------------------------
	// DOCUMENTACION:
	//---------------------------------------------------------
	// PARAMETROS:
	public var donde:Object;
	public var listenerId:String;
	public var array_eventos:Array;
	//---------------------------------------------------------
	// CONSTRUCTORA:
	function Listener(aE:Array, d:Object, lId:String) {
		//trace("(Listener.CONSTRUCTORA)!");
		listenerId = lId;
		donde = d;
		//array_eventos = new Array();
		array_eventos = aE;
	}
	//---------------------------------------------------------
	// METODOS:
	public function anadir_evento(evento:String):Void {
		// Añade 1 solo evento
		//trace("(Listener.anadir_evento)!"+evento);
		//trace("eventos antes añadir: "+array_eventos);
		array_eventos.push(evento);
		array_eventos = array_copiaArraySinRepeticiones(array_eventos);
		//trace("   lista de eventos: "+array_eventos);
	}
	public function anadir_eventos(aE:Array):Void {
		// Añade 1 array de eventos
		var array_aux:Array = array_eventos.concat(aE);
		array_aux = array_copiaArraySinRepeticiones(array_aux);
		array_eventos = array_aux;
	}
	public function quitar_evento(evento:String):Void {
		// Quita 1 solo evento
		var array_aux:Array = array_quitarElem(array_eventos, evento);
		array_eventos = array_aux;
	}
	public function quitar_eventos(aE:Array):Void {
		// Quita 1 array de eventos
		var array_aux:Array = array_quitarElemArray(array_eventos, aE);
		array_eventos = array_aux;
	}
	public function eval_evento_registrado(evento:String):Boolean {
		var existe:Boolean = array_estaEnElArray(evento, array_eventos);
		return existe;
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
	private function array_quitarElem(arrayBase:Array, elem):Array {
		// Dado un array base y un elem, se devuelve un 3º copia del base sin el elemento
		var arrayResultado:Array = new Array();
		for (var i = 0; i<arrayBase.length; i++) {
			var valorBase = arrayBase[i];
			if (valorBase != elem) {
				arrayResultado.push(valorBase);
			}
		}
		return arrayResultado;
	}
	private function array_copiaArraySinRepeticiones(esteArray):Array {
		// SNIPPET que devuelve una copia de un array sin repeticiones
		var sumar:Boolean;
		var elem;
		var nuevoArray = new Array();
		for (var i = 0; i<esteArray.length; i++) {
			sumar = true;
			elem = esteArray[i];
			for (var j = 0; j<nuevoArray.length; j++) {
				if (elem == nuevoArray[j]) {
					sumar = false;
				}
			}
			if (sumar) {
				nuevoArray.push(elem);
			}
		}
		return nuevoArray;
	}
	private function array_quitarElemArray(arrayBase:Array, arrayQuitar:Array):Array {
		// SNIPPET
		// Dado un array base y otro de resta, se devuelve un 3ero con:
		// Aquellos elementos que están en el base y no el resta
		var arrayResultado:Array = new Array();
		for (var i = 0; i<arrayBase.length; i++) {
			var sumarEste = true;
			var valorBase = arrayBase[i];
			for (var j = 0; j<arrayQuitar.length; j++) {
				var valorResta = arrayQuitar[j];
				if (valorBase == valorResta) {
					sumarEste = false;
				}
			}
			if (sumarEste) {
				arrayResultado.push(valorBase);
			}
		}
		return arrayResultado;
	}
}
