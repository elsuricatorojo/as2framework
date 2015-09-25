/*
DOCUMENTACION:
* Roberto Ferrero - hola@robertoferrero.es
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 04/11/2014 18:41
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.data.Datos;
import com.ionewmedia.utils.estaticas.XML2;
import com.ionewmedia.utils.omniture.OmnitureConfig
import com.ionewmedia.utils.omniture.OmnitureEvent;
//--
class com.ionewmedia.utils.omniture.XMLParser_OmnitureTracking{
	// import com.ionewmedia.utils.omniture.XMLParser_OmnitureTracking
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var config:OmnitureConfig
	var eventos:Datos
	// private var emisor:EmisorExtendido;
	//--------------------
	// CONSTRUCTORA:
	public function XMLParser_OmnitureTracking() {
		trace("(XMLParser_OmnitureTracking.CONSTRUCTORA)!")
		// emisor = new EmisorExtendido()
		config = new OmnitureConfig()
		eventos = new Datos("eventos_omniture")
		
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters:
	// Setters:
	public function set_data(objXML:XML):Void {
		trace("(XMLParser_contenidos.set_data)!")
		inter_objXML(objXML)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function inter_objXML(objXML:XML) {
		trace("(XMLParser_contenidos.inter_objXML)!");
		var nodo:XMLNode = objXML.firstChild;
		var arraySubnodos:Array = nodo.childNodes;
		//--
		var pos_config:Number = XML2.posicionSubnodo(nodo, "config")
		inter_config (arraySubnodos[pos_config])
		//--
		var pos_tracking:Number = XML2.posicionSubnodo(nodo, "tracking")
		inter_tracking (arraySubnodos[pos_tracking])
	}
	private function inter_config(nodo:XMLNode) {
		config.set_account(XML2.extraerValorNodo(nodo,"account"))
		config.set_siteID(XML2.extraerValorNodo(nodo,"siteID"))
		config.set_pageName(XML2.extraerValorNodo(nodo,"pageName"))
		config.set_server(XML2.extraerValorNodo(nodo,"server"))
		config.set_pageURL(XML2.extraerValorNodo(nodo,"pageURL"))
		config.set_channel(XML2.extraerValorNodo(nodo,"channel"))
		config.set_prop15(XML2.extraerValorNodo(nodo,"prop15"))
		config.set_prop17(XML2.extraerValorNodo(nodo,"prop17"))
		config.set_prop14(XML2.extraerValorNodo(nodo,"prop14"))
		config.set_prop13(XML2.extraerValorNodo(nodo,"prop13"))
		config.set_charset(XML2.extraerValorNodo(nodo,"charset"))
		config.set_currencyCode(XML2.extraerValorNodo(nodo,"currencyCode"))
		config.set_cookieDomainPeriods(Number(XML2.extraerValorNodo(nodo,"cookieDomainPeriods")))
		config.set_trackClickMap(parseBoolean(XML2.extraerValorNodo(nodo,"trackClickMap")))
		config.set_movieID(XML2.extraerValorNodo(nodo,"movieID"))
		config.set_debugTracking(parseBoolean(XML2.extraerValorNodo(nodo,"debugTracking")))
		config.set_trackLocal(parseBoolean(XML2.extraerValorNodo(nodo,"trackLocal")))
		config.set_trackingServer(XML2.extraerValorNodo(nodo,"trackingServer"))
		config.set_visitorNamespace(XML2.extraerValorNodo(nodo,"visitorNamespace"))
		config.set_dc(XML2.extraerValorNodo(nodo, "dc"))
		config.set_linkTrackVars(XML2.extraerValorNodo(nodo, "linkTrackVars"))
		config.set_linkTrackEvents(XML2.extraerValorNodo(nodo, "linkTrackEvents"))
		//--
		config.traceObject()
	}
	private function inter_tracking(nodo:XMLNode) {
		var arraySubnodos:Array = nodo.childNodes;
		var contador:Number = 0
		for (var nombreSubnodo:String in arraySubnodos) {
			var subnodo:XMLNode = arraySubnodos[nombreSubnodo]
			var evento:OmnitureEvent = new OmnitureEvent()
			evento.id = subnodo.attributes.id
			evento.pageName = XML2.extraerValorNodo(subnodo, "pageName")
			evento.prop32 = XML2.extraerValorNodo(subnodo, "pageName")
			evento.channel = XML2.extraerValorNodo(subnodo, "channel")
			evento.prop15 = XML2.extraerValorNodo(subnodo, "prop15")
			evento.prop5 = XML2.extraerValorNodo(subnodo, "prop5")
			evento.trackLinkCustom = XML2.extraerValorNodo(subnodo, "trackLinkCustom")
			evento.trackLinkCustom_descr = XML2.extraerAtributoNodo(subnodo, "trackLinkCustom", "descr")
			//--
			evento.traceObject()
			eventos.nuevoItem(evento.id, evento)
		}
	}
	function parseBoolean(v:String):Boolean{
	   if(v=="1" || v.toLowerCase()=="true"){
		   return true;
	   }
	   return false;
	}
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