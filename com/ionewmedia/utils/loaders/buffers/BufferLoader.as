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
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.loaders.buffers.BufferItem;
class com.ionewmedia.utils.loaders.buffers.BufferLoader {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var data:Object;
	var emisor:EmisorExtendido;
	var retryOnError:Boolean = false;
	var resumeOnError:Boolean = true;
	var resumeOnExito:Boolean = false;
	var pausado:Boolean = true;
	var cargando:Boolean = false;
	//--------------------
	// CONSTRUCTORA:
	function BufferLoader() {
		trace("(BufferLoader.CONSTRUCTORA)!");
		emisor = new EmisorExtendido();
		init_data();
	}
	public function test_scope(txt:String) {
		trace("(BufferLoader.test_scope) <---------- "+txt);
	}
	public function set_retryOnError(valor:Boolean) {
		// Determina si tras deterctar un error en la carga de algo...
		// ... vuelve a intentar la misma carga.
		retryOnError = valor;
	}
	public function set_resumeOnError(valor:Boolean) {
		// Determina si tras deterctar un error en la carga de algo...
		// ...lanza el evento para cargar lo siguiente
		resumeOnError = valor;
	}
	public function set_resumeOnExito(valor:Boolean) {
		// Determina si tar cargar algo lanza el evento para cargar lo siguiente
		resumeOnExito = valor;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevaCarga(cargaId:String) {
		var existe:Boolean = Array2.estaEnElArray(data.array_items, cargaId);
		if (existe) {
			trace("(BufferLoader.nuevaCarga) SE ESTÁ DANDO DE ALTA UNA CARGA CON UN ID QUE YA EXISTE");
			trace("   cargaId: "+cargaId);
		} else {
			data[cargaId] = new BufferItem(cargaId);
			data.array_items.push(cargaId);
		}
		if (!cargando && !pausado) {
			siguienteCarga();
		}
	}
	public function comenzar() {
		Trace.trc("(BufferLoader.comenzar)!");
		Trace.trc("   retryOnError: "+retryOnError);
		Trace.trc("   resumeOnError: "+resumeOnError);
		Trace.trc("   resumeOnExito: "+resumeOnExito);
		Trace.trc("   array_items: "+data.array_items);
		pausado = false;
		if (data.array_items.length>0) {
			comenzarCarga();
		} else {
			todoCargado();
		}
	}
	public function pausar() {
		pausado = true;
	}
	public function resumir() {
		pausado = false;
		if (!cargando) {
			siguienteCarga();
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_data() {
		data = new Object();
		data.array_items = new Array();
		data.__posCarga = 0;
	}
	private function siguienteCarga() {
		data.__posCarga++;
		if (data.__posCarga<data.array_items.length && !pausado) {
			comenzarCarga();
		} else {
			todoCargado();
		}
	}
	private function comenzarCarga() {
		cargando = false;
		var cargaId:String = data.array_items[data.__posCarga];
		var objEvento:Object = new Object();
		objEvento.type = "onComenzarCarga";
		objEvento.cargaId = cargaId;
		objEvento.cargaNumero = data.__posCarga+1;
		objEvento.cargasTotales = data.array_items.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	private function todoCargado() {
		Trace.trc("(BufferLoader.todoCargado)!");
		cargando = false;
		var objEvento:Object = new Object();
		objEvento.type = "onTodoCargado";
		objEvento.cargaNumero = data.array_items.length;
		objEvento.cargasTotales = data.array_items.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	//--------------------
	// EVENTOS:
	public function onCargaIniciada(obj:Object) {
		// Lo emite un CargadorXML2, un CargadorMovieClip2 o un Comm al iniciar la conexion
		//Trace.trc("(BufferLoader.onCargaIniciada) cargaId: "+obj.cargaId);
		var cargaId:String = obj.cargaId;
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onCargaIniciada";
		objEvento.cargaId = cargaId;
		objEvento.cargaNumero = data.__posCarga+1;
		objEvento.cargasTotales = data.array_items.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	public function onProgressCarga(obj:Object) {
		//Trace.trc("(BufferLoader.onProgressCarga) cargaId: "+obj.cargaId)
		var cargaId:String = obj.cargaId;
		var porcentaje:Number = obj.porcentaje;
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onProgressCarga";
		objEvento.cargaId = cargaId;
		objEvento.porcentaje = porcentaje;
		objEvento.cargaNumero = data.__posCarga+1;
		objEvento.cargasTotales = data.array_items.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	public function onExitoCarga(obj:Object) {
		//Trace.trc("(BufferLoader.onExitoCarga) cargaId: "+obj.cargaId);
		var cargaId:String = obj.cargaId;
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onExitoCarga";
		objEvento.cargaId = cargaId;
		objEvento.cargaNumero = data.__posCarga+1;
		objEvento.cargasTotales = data.array_items.length;
		objEvento.objXML = obj.objXML;
		objEvento.data = obj.data;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
		//--
		if (resumeOnExito) {
			siguienteCarga();
		} else {
			pausar();
		}
	}
	public function onErrorCarga(obj:Object) {
		Trace.trc("(BufferLoader.onErrorCarga) cargaId: "+obj.cargaId);
		var cargaId:String = obj.cargaId;
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onErrorCarga";
		objEvento.cargaId = cargaId;
		objEvento.cargaNumero = data.__posCarga+1;
		objEvento.cargasTotales = data.array_items.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
		//--
		if (retryOnError) {
			comenzarCarga();
		} else {
			if (resumeOnError) {
				siguienteCarga();
			}
		}
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onComenzarCarga", ref);
		emisor.addEventListener("onCargaIniciada", ref);
		emisor.addEventListener("onProgressCarga", ref);
		emisor.addEventListener("onExitoCarga", ref);
		emisor.addEventListener("onErrorCarga", ref);
		emisor.addEventListener("onTodoCargado", ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento, ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento, ref);
	}
	//--------------------
	// SNIPPETS:
}
