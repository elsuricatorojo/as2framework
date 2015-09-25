/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070601
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.Object2;
//import com.ionewmedia.utils.loaders.buffers.BufferLoader;
class com.ionewmedia.utils.loaders.v2.DataPrecarga2 extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var clipDestino:MovieClip;
	private var limitador:Number;
	private var cargaId:String;
	private var emisor:EmisorExtendido;
	private var contador:Number = 0;
	private var buffer:Object;
	//--------------------
	// CONSTRUCTORA:
	function DataPrecarga2() {
		//trace("(DataPrecarga2.CONSTRUCTORA)!");
		emisor = new EmisorExtendido();
	}
	public function init(_clipDestino:MovieClip, _limitador:Number, _cargaId:String, _buffer:Object) {
		trace("(DataPrecarga2.init): " + _clipDestino);
		clipDestino = _clipDestino;
		limitador = _limitador;
		cargaId = _cargaId;
		if (_buffer != undefined && _buffer != null) {
			buffer = _buffer;
			buffer.test_scope("(DataPrecarga2)");
			addListener(buffer);
		}
		monitorizar();
	}
	// NUEVO 29/07/2012 16:56
	public function testScope(cadena:String):Void {
		trace("(DataPrecarga2.testScope) ------------------- "+cadena)
	}
	// NUEVO 09/03/2009 10:58
	public function initKill() {
		clipDestino =null
		if(buffer!=null){
			emisor.removeListener(buffer);
			buffer = null
		}
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	private function monitorizar() {
		var objEvento = new Object();
		objEvento.type = "onInicioCarga";
		objEvento.cargaId = cargaId;
		emisor.emitir_objeto(objEvento);
		var donde:MovieClip =this
		//--
		this.onEnterFrame = function() {
			donde.update();
			donde.contador++;
		};
	}
	private function update() {
		//trace("(DataPrecarga2.update)!");
		var totales = clipDestino.getBytesTotal();
		var cargados = clipDestino.getBytesLoaded();
		var porcentaje = Math.floor((cargados / totales) * 100);
		// Limitador
		if (porcentaje > (contador * limitador)) {
			porcentaje = contador * limitador;
		}
		var objEvento = new Object();
		objEvento.type = "onProgressCarga";
		objEvento.cargaId = cargaId;
		objEvento.porcentaje = porcentaje;
		emisor.emitir_objeto(objEvento);
		//trace("   porcentaje: "+porcentaje);
		if (porcentaje == 100) {
			exitoCaraga();
		}
	}
	private function exitoCaraga() {
		var objEvento2:Object = new Object();
		objEvento2.type = "onExitoCarga";
		objEvento2.cargaId = cargaId;
		emisor.emitir_objeto(objEvento2);
		kill();
	}
	private function kill() {
		delete this.onEnterFrame;
		this.removeMovieClip();
	}
	//--------------------
	// EVENTOS:
	// Lo emite la clase MovieClipLoader:
	public function onLoadError(target_mc:MovieClip, errorCode:String) {
		trace("(DataPrecarga2.onLoadError)!");
		trace("   target_mc: " + target_mc);
		trace("   errorCode: " + errorCode);
		var objEvento = new Object();
		objEvento.type = "onErrorCarga";
		objEvento.cargaId = cargaId;
		objEvento.errorCode = errorCode;
		objEvento.target_mc = target_mc;
		emisor.emitir_objeto(objEvento);
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onCargaIniciada",ref);
		emisor.addEventListener("onProgressCarga",ref);
		emisor.addEventListener("onExitoCarga",ref);
		emisor.addEventListener("onErrorCarga",ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		// NUEVO 20080311
		emisor.addEventListener(evento,ref);
	}
	public function removeListener(ref:Object) {
		// NUEVO 15/04/2009 12:53
		emisor.removeListener(ref)
	}
	//--------------------
	// SNIPPETS:
}