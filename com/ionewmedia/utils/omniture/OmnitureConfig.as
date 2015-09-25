import tv.zarate.Utils.Trace;
/*
DOCUMENTACION:
* Roberto Ferrero - hola@robertoferrero.es
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 04/11/2014 18:50
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.omniture.OmnitureConfig {
	// import com.ionewmedia.utils.omniture.OmnitureConfig
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var account:String = null
	public var siteID:String = null
	public var pageName:String = null // NUEVO: 09/04/2015 10:15
	public var server:String = null
	public var pageURL:String = null
	public var channel:String = null
	public var prop15:String = null
	public var prop17:String = null // NUEVO: 09/04/2015 10:15
	public var prop14:String = null // NUEVO: 09/04/2015 10:15
	public var prop13:String = null // NUEVO: 09/04/2015 10:15
	public var charset:String = null
	public var currencyCode:String = null
	public var cookieDomainPeriods:Number = null
	public var trackClickMap:Boolean = null
	public var movieID:String = null
	public var debugTracking:Boolean = null
	public var trackLocal:Boolean = null
	public var trackingServer:String = null
	public var visitorNamespace:String = null
	public var dc:String = null
	public var linkTrackVars:String  = null // NUEVO: 09/04/2015 10:15
	public var linkTrackEvents:String  = null // NUEVO: 09/04/2015 10:15
	// private var emisor:EmisorExtendido;
	//--------------------
	// CONSTRUCTORA:
	public function OmnitureConfig() {
		trace("(OmnitureConfig.CONSTRUCTORA)!")
		// emisor = new EmisorExtendido()
		
	}
	public function traceObject() {
		//var foo:Trace
		Trace.trc("(OmnitureConfig.traceObject)!")
		Trace.trc("   account: " + account)
		Trace.trc("   siteID: " + siteID)
		Trace.trc("   pageName: " + pageName)
		Trace.trc("   server: " + server)
		Trace.trc("   pageURL: " + pageURL)
		Trace.trc("   channel: " + channel)
		Trace.trc("   prop15: " + prop15)
		Trace.trc("   prop17: " + prop17)
		Trace.trc("   prop14: " + prop14)
		Trace.trc("   prop13: " + prop13)
		Trace.trc("   charset: "+charset)
		Trace.trc("   currencyCode: "+currencyCode)
		Trace.trc("   cookieDomainPeriods: "+cookieDomainPeriods)
		Trace.trc("   trackClickMap: "+trackClickMap)
		Trace.trc("   movieID: "+movieID)
		Trace.trc("   debugTracking: "+debugTracking)
		Trace.trc("   trackLocal: "+trackLocal)
		Trace.trc("   trackingServer: "+trackingServer)
		Trace.trc("   visitorNamespace: "+visitorNamespace)
		Trace.trc("   dc: "+dc)
		Trace.trc("   linkTrackVars: "+linkTrackVars)
		Trace.trc("   linkTrackEvents: "+linkTrackEvents)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_account(valor:String) {
		if(valor != undefined){
			account = valor
		}
	}
	public function set_siteID(valor:String) {
		if(valor != undefined){
			siteID = valor
		}
	}
	public function set_pageName(valor:String) {
		if(valor != undefined){
			pageName = valor
		}
	}
	public function set_server(valor:String) {
		if(valor != undefined){
			server = valor
		}
	}
	public function set_pageURL(valor:String) {
		if(valor != undefined){
			pageURL = valor
		}
	}
	public function set_channel(valor:String) {
		if(valor != undefined){
			channel = valor
		}
	}
	public function set_prop15(valor:String) {
		if(valor != undefined){
			prop15 = valor
		}
	}
	public function set_prop17(valor:String) {
		if(valor != undefined){
			prop17 = valor
		}
	}
	public function set_prop14(valor:String) {
		if(valor != undefined){
			prop14 = valor
		}
	}
	public function set_prop13(valor:String) {
		if(valor != undefined){
			prop13 = valor
		}
	}
	/*
	Trace.trc("   charset: "+charset)
	Trace.trc("   currencyCode: "+currencyCode)
	Trace.trc("   cookieDomainPeriods: "+cookieDomainPeriods)
	Trace.trc("   trackClickMap: "+trackClickMap)
	 * */
	public function set_charset(valor:String) {
		if(valor != undefined){
			charset = valor
		}
	}
	public function set_currencyCode(valor:String) {
		if(valor != undefined){
			currencyCode = valor
		}
	}
	public function set_cookieDomainPeriods(valor:Number) {
		if(valor != undefined){
			cookieDomainPeriods = valor
		}
	}
	public function set_trackClickMap(valor:Boolean) {
		if(valor != undefined){
			trackClickMap = valor
		}
	}
	/*
	Trace.trc("   movieID: "+movieID)
	Trace.trc("   debugTracking: "+debugTracking)
	Trace.trc("   trackLocal: "+trackLocal)
	Trace.trc("   trackingServer: "+trackingServer)
	 * */
	public function set_movieID(valor:String) {
		if(valor != undefined){
			movieID = valor
		}
	}
	public function set_debugTracking(valor:Boolean) {
		if(valor != undefined){
			debugTracking = valor
		}
	}
	public function set_trackLocal(valor:Boolean) {
		if(valor != undefined){
			trackLocal = valor
		}
	}
	public function set_trackingServer(valor:String) {
		if(valor != undefined){
			trackingServer = valor
		}
	}
	/*
	Trace.trc("   visitorNamespace: "+visitorNamespace)
	Trace.trc("   dc: "+dc)
	Trace.trc("   linkTrackVars: "+linkTrackVars)
	Trace.trc("   linkTrackEvents: "+linkTrackEvents)
	 * */
	public function set_visitorNamespace(valor:String) {
		if(valor != undefined){
			visitorNamespace = valor
		}
	}
	public function set_dc(valor:String) {
		if(valor != undefined){
			dc = valor
		}
	}
	public function set_linkTrackVars(valor:String) {
		if(valor != undefined){
			linkTrackVars = valor
		}
	}
	public function set_linkTrackEvents(valor:String) {
		if(valor != undefined){
			linkTrackEvents = valor
		}
	}
	 
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