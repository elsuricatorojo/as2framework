/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 200711
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.Object2;
import com.ionewmedia.utils.estaticas.Array2;
class com.ionewmedia.utils.loaders.buffers.Buffer {
	//--------------------
	// DOCUMENTACION:
	/*
	Versión mejorada de BufferLoader manteniendo retrocompatibilidad con ésta
	*/
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	public var retryOnError:Boolean = false; // Solo READ
	public var resumeOnError:Boolean = true; // Solo READ
	public var resumeOnExito:Boolean = false; // Solo READ
	public var pausado:Boolean = true; // Solo READ
	public var cargando:Boolean = false; // Solo READ
	//--
	/*
	buffer.retryOnError = true
	buffer.resumeOnExito = true
	*/
	//--
	var array_solicitadas:Array;
	var array_completadas:Array;
	var array_pendientes:Array;
	var cargaActual:String = null;
	//09/04/2008 13:59 Asocia la instancia del buffer a una Id.
	public var bufferId:String
	// NUEVO 19/09/2013 14:43
	private var bufferPadre:Buffer = null // Para los casos en el que el buffer es uan carga mas de otro buffer
	private var  bufferAnidado:Boolean = false // Para los casos en el que el buffer es uan carga mas de otro buffer
	private var todoCargadoEmitido:Boolean = false
	//--------------------
	// CONSTRUCTORA:
	function Buffer(id:String, _bufferPadre:Buffer) {
		trace("(Buffer.CONSTRUCTORA): "+id);
		emisor = new EmisorExtendido();
		array_solicitadas=new Array()
		array_completadas=new Array()
		array_pendientes = new Array()
		if (id != undefined) {
			bufferId=id
		}
		if (_bufferPadre != undefined && _bufferPadre != null) {
			bufferPadre = _bufferPadre;
			bufferAnidado = true
			resumeOnExito = true
			this.addListener(bufferPadre);
		}
	}
	public function test_scope(txt:String) {
		trace("(Buffer.test_scope) --------- " + txt);
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
		// Se añade al FINAL de la cola de carga (array_pendientes)
		var existe:Boolean = Array2.estaEnElArray(array_solicitadas, cargaId);
		if (existe) {
			trace("(Buffer.nuevaCarga) SE ESTÁ DANDO DE ALTA UNA CARGA CON UN ID QUE YA EXISTE");
			trace("   cargaId: " + cargaId);
		} else {
			array_solicitadas.push(cargaId);
			array_pendientes.push(cargaId);
			//Trace.trc("   array_solicitadas: " + array_solicitadas);
			//Trace.trc("   array_completadas: " + array_completadas);
			//Trace.trc("   array_pendientes: " + array_pendientes);
		}
	}
	public function nuevoArrayCarga(arrayCarga:Array):Void {
		for (var i = 0; i < arrayCarga.length; i++) {
			var cargaId:String = arrayCarga[i];
			nuevaCarga(cargaId);
		}

	}
	public function insertCarga(cargaId:String) {
		// Se añade al PRINCIPIO de la cola de carga (array_pendientes)
		var pendiente:Boolean = Array2.estaEnElArray(array_pendientes, cargaId);
		if (pendiente) {
			trace("(Buffer.insertCarga) SE ESTÁ DANDO DE ALTA UNA CARGA CON UN ID QUE ESTA PENDIENTE. LA PASAMOS AL PRINCIPIO");
			trace("   cargaId: " + cargaId);
			// NUEVO 09/05/2008 12:06
			// ANTES si existía la carga en array_solicitadas no se haci nada.
			// AHORA pasa la carga al inicio de pendientes
			array_solicitadas = Array2.quitarElem(array_solicitadas, cargaId)
			array_pendientes=Array2.quitarElem(array_pendientes, cargaId)
		}
		var primeroPendientes:String = array_pendientes[0];
		var posPrimeroEnSolicitadas:Number = Array2.devolverId(array_solicitadas, primeroPendientes);
		array_solicitadas.splice(posPrimeroEnSolicitadas,0,cargaId);
		array_pendientes.unshift(cargaId);
		//Trace.trc("   array_solicitadas: " + array_solicitadas);
		//Trace.trc("   array_completadas: " + array_completadas);
		//Trace.trc("   array_pendientes: " + array_pendientes);
	}
	public function insertArrayCarga(arrayCarga:Array):Void {
		arrayCarga.reverse();
		for (var i = 0; i < arrayCarga.length; i++) {
			var cargaId:String = arrayCarga[i];
			insertCarga(cargaId);
		}
	}
	public function limpiarPendientes() {
		// Elimina las carga pendientes
		array_solicitadas = Array2.quitarArray(array_solicitadas, array_pendientes);
		array_pendientes = new Array();
	}
	public function comenzar() {
		//*
		Trace.trc("(Buffer.comenzar)!");
		Trace.trc("   retryOnError: " + retryOnError);
		Trace.trc("   resumeOnError: " + resumeOnError);
		Trace.trc("   resumeOnExito: " + resumeOnExito);
		Trace.trc("   array_solicitadas: " + array_solicitadas);
		Trace.trc("   array_completadas: " + array_completadas);
		Trace.trc("   array_pendientes: " + array_pendientes);
		//--
		// Lo despausa por defecto
		pausado = false;
		//--
		// NUEVO 19/09/2013 14:52
		// Se inicia la carga del buffer y en el caso de estar anidado a un buffer padre se emite un CargaIniciada
		if (bufferAnidado) {
			var objEvento:Object = new Object();
			objEvento.type = "onCargaIniciada";
			objEvento.bufferId = bufferPadre.bufferId
			objEvento.cargaId = bufferId
			emisor.emitir_objeto(objEvento);
		}
		//--
		siguienteCarga()
	}
	public function pausar() {
		pausado = true;
	}
	public function resumir() {
		Trace.trc("(Buffer.resumir) cargando: "+cargando);
		pausado = false;
		if (!cargando) {
			siguienteCarga();
		}
	}
	// NUEVO: 20/05/2010 10:59
	public function listarListeners():Array {
		return emisor.getEventListeners("onExitoCarga")
	}
	// NUEVO 31/10/2014 9:49
	public function forzarTodoCargado() {
		Trace.trc("(Buffer.forzarTodoCargado) cargando: "+cargando);
		todoCargado()
	}
	//--------------------
	// METODOS PRIVADOS:
	private function comenzarCarga() {
		cargando = true;
		cargaActual = array_pendientes[0];
		Trace.trc("(Buffer.comenzarCarga): "+cargaActual);
		array_pendientes = Array2.quitarElem(array_pendientes, cargaActual);
		var cargaId:String = cargaActual;
		var posCarga:Number = Array2.devolverId(array_solicitadas, cargaActual);
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onComenzarCarga";
		objEvento.cargaId = cargaId;
		objEvento.bufferId = bufferId
		objEvento.cargaNumero = posCarga + 1;
		objEvento.cargasTotales = array_solicitadas.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	private function siguienteCarga() {
		trace("(Buffer.siguienteCarga) bufferId: "+bufferId);
		//Trace.trc("   array_solicitadas: " + array_solicitadas);
		//Trace.trc("   array_completadas: " + array_completadas);
		//Trace.trc("   array_pendientes: " + array_pendientes);
		if (array_pendientes.length > 0) {
			comenzarCarga();
		} else {
			if (!todoCargadoEmitido) {
				todoCargadoEmitido = true 
				todoCargado();
			}
		}
	}
	private function todoCargado() {
		//*
		Trace.trc("(Buffer.todoCargado)! "+bufferId);
		cargando = false;
		var objEvento:Object = new Object();
		objEvento.type = "onTodoCargado";
		objEvento.bufferId = bufferId
		objEvento.cargaNumero = array_solicitadas.length;
		objEvento.cargasTotales = array_solicitadas.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
		//
		// NUEVO 19/09/2013 14:51
		// El Buffer termina de carga todo y al estar anidado a un bufferPadre supone un exitoCarga
		if (bufferAnidado) {
			//trace("SSSSSSSSSSSSSSSSSSSSSSSSSSS")
			var objEvento2:Object = new Object();
			objEvento2.type = "onExitoCarga";
			objEvento2.bufferId = bufferPadre.bufferId
			objEvento2.cargaId = bufferId
			emisor.emitir_objeto(objEvento2);
		}
	}
	
	//--------------------
	// EVENTOS:
	public function onCargaIniciada(obj:Object) {
		//*
		// Lo emite un CargadorXML2, un CargadorMovieClip2 o un Comm al iniciar la conexion
		Trace.trc("(Buffer.onCargaIniciada) cargaId: "+obj.cargaId+"  bufferId: "+bufferId);
		var cargaId:String = obj.cargaId;
		var posCarga:Number = Array2.devolverId(array_solicitadas, cargaId);
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onCargaIniciada";
		objEvento.cargaId = cargaId;
		objEvento.bufferId = bufferId
		objEvento.cargaNumero = posCarga + 1;
		objEvento.cargasTotales = array_solicitadas.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	public function onProgressCarga(obj:Object) {
		//*
		//Trace.trc("(Buffer.onProgressCarga) cargaId: "+obj.cargaId)
		var cargaId:String = obj.cargaId;
		var posCarga:Number = Array2.devolverId(array_solicitadas, cargaId);
		var porcentaje:Number = obj.porcentaje;
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onProgressCarga";
		objEvento.cargaId = cargaId;
		objEvento.bufferId = bufferId
		objEvento.porcentaje = porcentaje;
		objEvento.cargaNumero = posCarga + 1;
		objEvento.cargasTotales = array_solicitadas.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
	}
	public function onExitoCarga(obj:Object) {
		//*
		Trace.trc("(Buffer.onExitoCarga) cargaId: "+obj.cargaId+"  bufferId: "+bufferId);
		// Modificado el 20080116:
		cargando = false;
		//--
		var cargaId:String = obj.cargaId;
		// NUEVO:22/05/2008 17:17
		// Antes de emitir el evento onExitoCarga mira si la cargaId es igual a la carga actual.
		if (cargaId==cargaActual) {
			var posCarga:Number = Array2.devolverId(array_solicitadas, cargaId);
			array_completadas.push(cargaId);
			cargaActual = null;
			//--
			var objEvento:Object = new Object();
			objEvento.type = "onExitoCarga";
			objEvento.cargaId = cargaId;
			objEvento.bufferId = bufferId
			objEvento.cargaNumero = posCarga + 1;
			objEvento.cargasTotales = array_solicitadas.length;
			objEvento.objXML = obj.objXML;
			objEvento.data = obj.data;
			objEvento.tipoCarga = obj.tipoCarga;
			objEvento.emisorBuffer = true;
			emisor.emitir_objeto(objEvento);
			//--
			trace("   resumeOnExito': "+resumeOnExito+" (cargaId:"+cargaId+")")
			if (resumeOnExito) {
				if (!pausado) {
					siguienteCarga();
				}
			} else {
				pausar();
			}
		}else {
			Trace.trc("ATENCION!! Se ha recibido el evento onExitoCarga para una carga ("+cargaId+") que no es la actual ("+cargaActual+")")
		}
		//--
		// NUEVO  19/09/2013 14:55
		// Si es un buffer anidado a un buffer padre cada exito carga cuenta como un progreso. 2 de 10 cargas del buffer anidado sería un 20% que se pasa al buffer padre
		if (bufferAnidado) {
			var porcentajeAnidado:Number = (array_completadas.length / array_solicitadas.length) * 100
			//trace("ooooooooooooooo")
			//trace("   array_completadas: "+array_completadas)
			//trace("   array_solicitadas: "+array_solicitadas)
			//trace("   porcentajeAnidado: " + porcentajeAnidado)
			//trace("ooooooooooooooo")
			var objEvento:Object = new Object();
			objEvento.type = "onProgressCarga";
			objEvento.bufferId = bufferPadre.bufferId
			objEvento.cargaId = bufferId
			objEvento.porcentaje = porcentajeAnidado;
			emisor.emitir_objeto(objEvento);
		}
		//--
	}
	public function onErrorCarga(obj:Object) {
		//*
		Trace.trc("(Buffer.onErrorCarga) cargaId: " + obj.cargaId+"  bufferId: "+bufferId);
		var cargaId:String = obj.cargaId;
		var posCarga:Number = Array2.devolverId(array_solicitadas, cargaId);
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onErrorCarga";
		objEvento.bufferId = bufferId
		objEvento.cargaId = cargaId;
		objEvento.cargaNumero = posCarga + 1;
		objEvento.cargasTotales = array_solicitadas.length;
		objEvento.emisorBuffer = true;
		emisor.emitir_objeto(objEvento);
		//--
		if (retryOnError) {
			// Mandamos la carga que ha fallado a pendientes
			array_pendientes.unshift(cargaId);
			if (!pausado) {
				siguienteCarga();
			}
		} else if (resumeOnError) {
			// Mandamos la carga que ha fallado a completadas
			array_completadas.push(cargaId);
			if (!pausado) {
				siguienteCarga();
			}
		} else {
			cargando = false;
			pausar();
		}
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		//trace("(Buffer.addListener): "+ref)
		emisor.addEventListener("onComenzarCarga",ref);
		emisor.addEventListener("onCargaIniciada",ref);
		emisor.addEventListener("onProgressCarga",ref);
		emisor.addEventListener("onExitoCarga",ref);
		emisor.addEventListener("onErrorCarga",ref);
		emisor.addEventListener("onTodoCargado",ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento,ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento,ref);
	}
	// NUEVO 20080319
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// OTROS:
	public function insertArraCarga(arrayCarga:Array):Void {
		// NUEVO 09/05/2008 12:06
		// La calse de inicio tenia un error "ortografico" insertArraCarga en vez de insertArrayCarga
		// Se mantiene el método para garantizar retrocompatibilidad...
		// ...apuntando a un nuevo método ortograficamente correcto (insertArrayCarga).
		insertArrayCarga(arrayCarga)
	}
}