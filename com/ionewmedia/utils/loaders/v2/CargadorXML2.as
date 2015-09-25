/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20060906
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.Emisor;
import com.ionewmedia.utils.loaders.buffers.BufferLoader;
import com.ionewmedia.utils.estaticas.String2
class com.ionewmedia.utils.loaders.v2.CargadorXML2 {
	//--------------------
	// DOCUMENTACION:
	private var path:String;
	private var cargaId:String;
	private var emisor:Emisor;
	private var buffer;
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	function CargadorXML2(_path:String, _cargaId:String, _buffer) {
		// (path, xmlId)
		//trace("(CargadorXML2.CONSTRUCTORA)!");
		emisor = new Emisor();
		path = _path;
		cargaId = _cargaId;
		if (_buffer != undefined) {
			buffer = _buffer;
			this.addListener(buffer);
		}
	}
	public function addRandomSufix(nombreVariable:String) {
		if (nombreVariable == undefined || nombreVariable == null) {
			nombreVariable="&rnd"
		}
		path=path+nombreVariable+"="+String2.get_randomString(10)
	}
	public function init() {
		cargar();
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	private function cargar() {
		Trace.trc("(CargadorXML2.init) cargaId: " + cargaId+"  CARGAMOS EL XML: "+path);
		var donde = this;
		var objXML:XML;
		objXML = new XML();
		objXML.ignoreWhite = true;
		objXML.onLoad = function(exito) {
			//Trace.trc("(CargadorXML2.onLoad) exito: "+exito+" al cargar: "+donde.path);
			//trace("(CargadorXML2.onLoad): "+exito);
			if (exito) {
				donde.exito(this);
			} else {
				donde.error();
			}
		};
		objXML.onData = function(src) {
			// Añadido el 20070504 ya que aveces no lanzaba el onLoad
			//trace("(CargadorXML2.onData)!");
			if (src == undefined) {
				//Trace.trc("(CargadorXML2.onData) src == undefined");
				this.onLoad(false);
			} else {
				//Trace.trc("(CargadorXML2.onData) src != undefined ");
				this.parseXML(src);
				this.loaded = true;
				this.onLoad(true);
			}
		};
		var obj:Object = new Object();
		obj.type = "onCargaIniciada";
		obj.cargaId = cargaId;
		emisor.emitir_objeto(obj);
		//--
		objXML.load(path);
	}
	private function exito(objXML:XML) {
		trace("(CargadorXML2.exito):  "+cargaId);
		var obj:Object = new Object();
		obj.type = "onExitoCarga";
		obj.cargaId = cargaId;
		obj.objXML = objXML;
		emisor.emitir_objeto(obj);
	}
	private function error() {
		//trace("(CargadorXML2.error)!");
		var obj:Object = new Object();
		obj.type = "onErrorCarga";
		obj.cargaId = cargaId;
		emisor.emitir_objeto(obj);
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onCargaIniciada", ref);
		emisor.addEventListener("onExitoCarga", ref);
		emisor.addEventListener("onErrorCarga", ref);
	}
	// NUEVO: 17/03/2009 19:31
	public function removeListener(ref:Object) {
		emisor.deregistrar("onCargaIniciada", ref);
		emisor.deregistrar("onExitoCarga", ref);
		emisor.deregistrar("onErrorCarga", ref);
	}
	//--------------------
	// SNIPPETS:
}
