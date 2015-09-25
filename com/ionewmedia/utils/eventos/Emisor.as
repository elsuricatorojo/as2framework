/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061122
*/
import mx.events.EventDispatcher;
class com.ionewmedia.utils.eventos.Emisor {
	//--------------------
	// DOCUMENTACION:
	// Esta clase intenta ser una versión mas sencilla y eficiente de:
	// com.ionewmedia.utils.eventos.gestoreventos.GestorEventos
	// Omitiendo las funcionalidades como listar oyentes de un determinado evento o el
	// detector para no suscribir 2 veces el mismo oyente al mismo evento, ya en base a
	// la experiencia casi nunca no se utilizaban...
	// y al mismo tiempo mantener la compatibilidad con GestorEventos en el sentido de
	// utilizar los mismo metodos publicos.
	//--------------------
	// PARAMETROS:
	//--------------------
	// DEL PAQUETE: mx.events.EventDispatcher:
	// dispatchEvent(objEvento:Object)
	// addEventListener(evento:String, oyente:Object)
	// removeEventListener(evento:String, oyente:Object)
	var addEventListener:Function;
	var removeEventListener:Function;
	var dispatchEvent:Function;
	//--------------------
	// CONSTRUCTORA:
	function Emisor() {
		//trace("(Emisor.CONSTRUCTORA)!");
		EventDispatcher.initialize(this);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function emitir(evento:String):Void {
		//trace("(Emisor.emitir): "+evento);
		var objEvento = new Object();
		objEvento.type = evento;
		emitir_objeto(objEvento);
	}
	public function emitir_objeto(objEvento:Object):Void {
		//trace("(Emisor.emitir_objeto): "+objEvento.type);
		objEvento.target = this;
		dispatchEvent(objEvento);
	}
	public function registrar(evento:String, donde:Object):Void {
		//trace("(Emisor.registrar): "+evento+"  en: "+donde);
		addEventListener(evento, donde);
	}
	public function deregistrar(evento:String, donde:Object):Void {
		removeEventListener(evento, donde);
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
