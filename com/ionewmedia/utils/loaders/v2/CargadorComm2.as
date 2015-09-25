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
import com.ionewmedia.utils.estaticas.Object2;
import com.ionewmedia.utils.loaders.buffers.BufferLoader;
import com.ionewmedia.utils.estaticas.String2
class com.ionewmedia.utils.loaders.v2.CargadorComm2 {
	//--------------------
	// DOCUMENTACION:
	private var path:String;
	private var cargaId:String;
	private var emisor:Emisor;
	private var buffer:Object;
	private var objSend:Object;
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	function CargadorComm2(_path:String, _cargaId:String, _buffer:Object) {
		// (path, cargaId, buffer)
		Trace.trc("(CargadorComm2.CONSTRUCTORA)!");
		Trace.trc("   _path: "+_path)
		Trace.trc("   _cargaId: "+_cargaId)
		Trace.trc("   _buffer: "+_buffer)
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
		//trace("(CargadorComm2.init)!");
		cargar();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_objSend(obj:Object) {
		objSend = obj;
	}
	//--------------------
	// METODOS PRIVADOS:
	private function cargar() {
		Trace.trc("(CargadorComm2.cargar)!");
		var donde = this;
		var send_lv:LoadVars = new LoadVars();
		var load_lv:LoadVars = new LoadVars();
		//--
		for (var param in objSend) {
			send_lv[param] = objSend[param];
		}
		Object2.zlogTrace(send_lv, "DATOS QUE ENVIAMOS A: "+path)
		//--
		load_lv.onLoad = function(exito) {
			if (exito) {
				donde.exito(this)
			} else {
				donde.error(this)
			}
		};
		load_lv.onHTTPStatus = function (httpStatus:Number){
			this.httpStatus = httpStatus;
			if (httpStatus < 100)
			{
				this.httpStatusType = "flashError";
			}
			else if (httpStatus < 200)
			{
				this.httpStatusType = "informational";
			}
			else if (httpStatus < 300)
			{
				this.httpStatusType = "successful";
			}
			else if (httpStatus < 400)
			{
				this.httpStatusType = "redirection";
			}
			else if (httpStatus < 500)
			{
				this.httpStatusType = "clientError";
			}
			else if (httpStatus < 600)
			{
				this.httpStatusType = "serverError";
			}
			Trace.trc ("onHTTPStatus: " + httpStatus + "  (" + this.httpStatusType + ")");
		};
		//--
		var obj:Object = new Object();
		obj.type = "onCargaIniciada";
		obj.cargaId = cargaId;
		emisor.emitir_objeto(obj);
		//--
		send_lv.sendAndLoad(path, load_lv, "POST")

	}
	private function exito(load_lv:LoadVars) {
		Trace.trc("(CargadorComm2.exito): "+cargaId);
		Object2.zlogTrace(load_lv, "DATOS QUE RECIBIMOS DE: "+path)
		var data:Object=new Object()
		for (var param in load_lv) {
			data[param]=load_lv[param]
		}
		//--
		var obj:Object = new Object();
		obj.type = "onExitoCarga";
		obj.cargaId = cargaId;
		obj.data = data;
		emisor.emitir_objeto(obj);
	}
	private function error() {
		Trace.trc("(CargadorComm2.error)!");
		var obj:Object = new Object();
		obj.type = "onErrorCarga";
		obj.cargaId = cargaId;
		emisor.emitir_objeto(obj);
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onCargaIniciada",ref);
		emisor.addEventListener("onExitoCarga",ref);
		emisor.addEventListener("onErrorCarga",ref);
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