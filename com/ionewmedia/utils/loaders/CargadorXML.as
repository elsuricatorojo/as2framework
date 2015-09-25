/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20060906
*/
import tv.zarate.Utils.Trace;
class com.ionewmedia.utils.loaders.CargadorXML {
	//--------------------
	// DOCUMENTACION:
	private var path:String;
	private var dondeCallback:Object;
	private var ok_func:String;
	private var ko_func:String;
	private var objXML:XML;
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	function CargadorXML(p:String, d:Object, ok:String, ko:String) {
		// (path, dondeCallBack, eventoOK, eventoKO)
		trace("(CargadorXML.CONSTRUCTORA)!");
		path = p;
		dondeCallback = d;
		ok_func = ok;
		ko_func = ko;
		//--
		trace("  path: "+path);
		trace("  dondeCallback: "+dondeCallback);
		trace("  ok_func: "+ok_func);
		trace("  ko_func: "+ko_func);
		var donde = this;
		objXML = new XML();
		objXML.ignoreWhite = true;
		objXML.onLoad = function(exito) {
			Trace.trc("(CargadorXML.onLoad) exito: "+exito);
			trace("(CargadorXML.onLoad): "+exito);
			if (exito) {
				donde.onExito(this);
			} else {
				donde.onError();
			}
		};
		objXML.onData = function(src) {
			// Añadido el 20070504 ya que aveces no lanzaba el onLoad
			trace("(CargadorXML.onData)!");
			if (src == undefined) {
				Trace.trc("(CargadorXML.onData) src: "+src);
				this.onLoad(false);
			} else {
				Trace.trc("(CargadorXML.onData) src!=undefined ");
				this.parseXML(src);
				this.loaded = true;
				this.onLoad(true);
			}
		};
		//objXML.onHTTPStatus = function(httpStatus:Number) {
		//	trace("(CargadorXML.onHTTPStatus): "+httpStatus);
		//};
		//--
		cargar_xml();
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	private function cargar_xml() {
		objXML.load(path);
	}
	private function onExito(objXML:XML) {
		trace("(CargadorXML.onExito)!");
		dondeCallback[ok_func](objXML);
	}
	private function onError() {
		trace("(CargadorXML.onError)!");
		dondeCallback[ko_func](path);
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
