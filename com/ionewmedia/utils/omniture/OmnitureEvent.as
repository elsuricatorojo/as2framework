/*
DOCUMENTACION:
* Roberto Ferrero - hola@robertoferrero.es
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 04/11/2014 19:13
*/
import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.omniture.OmnitureEvent {
	// import com.ionewmedia.utils.omniture.OmnitureEvent
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var id:String
	public var pageName:String
	public var trackLinkCustom:String
	public var trackLinkCustom_descr:String
	public var channel:String
	public var prop32:String
	public var prop15:String
	public var prop5:String
	// private var emisor:EmisorExtendido;
	//--------------------
	// CONSTRUCTORA:
	public function OmnitureEvent() {
		trace("(OmnitureEvent.CONSTRUCTORA)!")
		// emisor = new EmisorExtendido()
		
	}
	public function traceObject() {
		Trace.trc("(OmnitureEvent.traceObject)!")
		Trace.trc("   id: " + id)
		Trace.trc("   pageName: " + pageName)
		Trace.trc("   trackLinkCustom: " + trackLinkCustom)
		Trace.trc("   trackLinkCustom_descr: " + trackLinkCustom_descr)
		Trace.trc("   channel: " + channel)
		Trace.trc("   prop32: " + prop32)
		Trace.trc("   prop15: " + prop15)
		Trace.trc("   prop5: "+prop5)
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	/*
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
	*/
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}