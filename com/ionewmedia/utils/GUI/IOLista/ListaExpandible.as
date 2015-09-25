/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 200801
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.estaticas.Object2;
class com.ionewmedia.utils.GUI.IOLista.ListaExpandible {
	//--------------------
	// DOCUMENTACION:
	// La clase gestiona elementosIitems de una lista vertical.
	// Dichos elementos se pueden expandir y colapsar.
	// 1) Contructora.
	// 2) Fijar preferencias:
	//     expandirMultiples:Boolean  ->  Determina si pueden haber mas de 1 elemento expandido.
	//     yInicialLista:Number  ->  Determina el valor _y de referencia inicial de la lista (opcional, util en scrolls).
	//     altoMask:Number  ->  Determina el valor de la mascara que contiene la lista (opcional, util en scrolls).
	//     contLista:MovieClip ->  Referencia a la instancia de la lista (opcional, util en scrolls).
	//     desfaseYInicial:Number -> Indica el desfase de la primera opcion respecto al inicio.
	// 3) Modificar la configuración de segundos y tipo de animacióndel tween (opcional).
	// 4a) crearItem(itemId:String):
	//     Reserva la posición a ese item en el array_items que fija la posición de los elemntos en la lista.
	//     Si no se conoce la altura de los items en su creación y esta se realiza mendiante for, para evitar
	//     que los items se notifiquen alrevés con un definirItem(), los notificamos primero con crearItem() y luego los definimos con definirItem()
	// 4b) definirItem(itemId:String, altoNormal:Number, altoExpandido:Number, expandido:Boolean)
	//     Si si se conoce la altura de los items en su creación se puede obiar la creación mediante crearItem()
	//     y definirlo directamente (lo cual incluye su creación).
	// 5) addListener() o addEventListener(): Registramos oyentes.
	// 6) init()
	//-------------------------
	// Datos de objPosiciones enviados con el evento 'onListaActualizada':
	// objPosiciones[itemId].alto:Number;
	// objPosiciones[itemId].y:Number;
	// objPosiciones[itemId].expandido:Boolean
	// objPosiciones.altoTotal:Number;
	// objPosiciones.posLista:Number;
	// objPosiciones.array_items:Array;
	//
	// NUEVO:01/10/2008 12:17
	// Se ha añadido la capacidad de tener una id.
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	private var data:Object;
	private var id:String
	// Tween:
	private var configTween:Object;
	// Prefs:
	public var expandirMultiples:Boolean = false;
	public var yInicialLista:Number = 0;
	public var altoMask:Number = null;
	public var contLista:MovieClip = null;
	public var desfaseYInicial:Number=0
	//--
	private var actualizacionInicial:Boolean = true;
	//--------------------
	// CONSTRUCTORA:
	function ListaExpandible(_id:String) {
		trace("(ListaExpandible.CONSTRUCTORA)!");
		id=_id
		emisor = new EmisorExtendido();
		data = new Object();
		data.array_items = new Array();
		configTween = new Object();
		configTween.secs = 0.5;
		configTween.tipo = "easeInOutQuad";
	}
	public function init() {
		trace("(ListaExpandible.init)!");
		emitirActualizacion();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function actualizar(){
		// NUEVO: 01/10/2008 12:15
		emitirActualizacion();
	}
	public function crearItem(itemId:String) {
		// Utilizar crearItem para ordenar el array_items. 
		// Luego utilizar definirItem para nutrir de datos.
		trace("(ListaExpandible.crearItem): " + itemId);
		var presente:Boolean = Array2.estaEnElArray(data.array_items, itemId);
		if (!presente) {
			data[itemId] = new Object();
			data.array_items.push(itemId);
		} else {
			trace("ITEM YA PRESENTE EN EL ACORDEON!!!  " + itemId);
		}
	}
	public function definirItem(itemId:String, altoNormal:Number, altoExpandido:Number, expandido:Boolean) {
		trace("(ListaExpandible.definirItem): " + itemId);
		var presente:Boolean = Array2.estaEnElArray(data.array_items, itemId);
		if (!presente) {
			if (expandido == undefined) {
				expandido = false;
			}
			data[itemId] = new Object();
			data[itemId].itemId = itemId;
			data[itemId].altoNormal = altoNormal;
			data[itemId].altoExpandido = altoExpandido;
			data[itemId].expandido = expandido;
			data.array_items.push(itemId);
		} else {
			trace("ITEM YA PRESENTE EN EL ACORDEON!!!  " + itemId + " (Guardamos datos)");
			if (expandido == undefined) {
				expandido = false;
			}
			data[itemId].itemId = itemId;
			data[itemId].altoNormal = altoNormal;
			data[itemId].altoExpandido = altoExpandido;
			data[itemId].expandido = expandido;
		}
	}
	public function expandirItem(itemId:String):Void {
		trace("(ListaExpandible.expandirItem): " + itemId);
		if (expandirMultiples) {
			data[itemId].expandido = true;
			emitirActualizacion();
		} else {
			colapsarTodosDatos();
			data[itemId].expandido = true;
			emitirActualizacion();
		}
	}
	public function expandirTodos() {
		expandirTodosDatos();
		emitirActualizacion();

	}
	public function colapsarItem(itemId:String):Void {
		trace("(ListaExpandible.colapsarItem): " + itemId);
		data[itemId].expandido = false;
		emitirActualizacion();
	}
	public function colapsarTodos():Void {
		colapsarTodosDatos();
		emitirActualizacion();
	}
	public function encabezarItem(itemId:String, expandir:Boolean) {
		trace("(ListaExpandible.encabezarItem): " + itemId);
		if (contLista != null) {
			if (expandir) {
				if (!expandirMultiples) {
					colapsarTodosDatos();
				}
				data[itemId].expandido = true;
			}
			//--      
			var objPosiciones:Object = get_objPosiciones();
			var nuevaPosLista:Number = yInicialLista - objPosiciones[itemId].y;
			var posRelMin:Number = yInicialLista - (objPosiciones.altoTotal - altoMask);
			trace("   objPosiciones[itemId].y: " +  objPosiciones[itemId].y)
			trace("   yInicialLista: " + yInicialLista)
			trace("   altoTotal: " + objPosiciones.altoTotal)
			trace("   altoMask: "+altoMask)
			trace("   nuevaPosLista (deseada): " + nuevaPosLista);
			trace("   posRelMin: " + posRelMin);
			if (objPosiciones.altoTotal <= altoMask) {
				trace ("La lista es mas pequeña que la mascara y se alinea arriba con la mascara")
				nuevaPosLista=yInicialLista
			}else if (nuevaPosLista < posRelMin) {
				trace ("La mask no es suficientemente alta para encabezar, la lista se alinea abajo con la msk")
				nuevaPosLista = posRelMin;
			}
			objPosiciones.posLista = nuevaPosLista;
			//--
			trace("   nuevaPosLista': " + nuevaPosLista);
			trace("   objPosiciones.posLista: " + objPosiciones.posLista);
			emitir_objPosiciones(objPosiciones);
		} else {
			trace("NO SE HA DEFINIDO UNA REFERENCIA DE LISTA");
		}
	}
	public function initKill() {
		emisor.removeAllListeners()
	}
	//---------
	// Setters:
	public function set_secsAnim(valor:Number) {
		configTween.secs = valor;
	}
	public function set_tipoAnim(valor:String) {
		configTween.tipo = valor;
	}
	//---------
	// Getters:
	public function get_objPosiciones():Object {
		var objPosiciones:Object = new Object();
		objPosiciones.array_items = new Array();
		var altoAcumulado:Number = desfaseYInicial;
		for (var i = 0; i < data.array_items.length; i++) {
			var itemId:String = data.array_items[i];
			objPosiciones[itemId] = new Object();
			//--
			var incremento:Number
			objPosiciones[itemId].y = altoAcumulado;
			if (data[itemId].expandido) {
				objPosiciones[itemId].expandido = true;
				incremento = data[itemId].altoExpandido;
				altoAcumulado = altoAcumulado + incremento;
			} else {
				objPosiciones[itemId].expandido = false;
				incremento = data[itemId].altoNormal;
				altoAcumulado = altoAcumulado + incremento;
			}
			//--
			var posLista:Number
			if (contLista != null && altoAcumulado > altoMask) {
				var posRelMin:Number = yInicialLista - (altoAcumulado - altoMask);
				var posRelActual:Number = yInicialLista + contLista._y;
				posLista = contLista._y;
				if (posRelActual < posRelMin) {
					posLista = posRelMin + yInicialLista;
				}
			} else {
				posLista = yInicialLista;
			}
			//--                   
			objPosiciones[itemId].alto = incremento;
			objPosiciones.altoTotal = altoAcumulado;
			objPosiciones.posLista = posLista;
			objPosiciones.array_items.push(itemId);
		}
		return objPosiciones;
	}
	public function get_configTween():Object {
		return (configTween);
	}
	//--------------------
	// METODOS PRIVADOS:
	private function colapsarTodosDatos() {
		// Pasa dotos los "data[itemId].expandido" a false sin emitir eventos
		for (var i = 0; i < data.array_items.length; i++) {
			var itemId:String = data.array_items[i];
			data[itemId].expandido = false;
		}
	}
	private function expandirTodosDatos() {
		// Pasa dotos los "data[itemId].expandido" a true sin emitir eventos
		for (var i = 0; i < data.array_items.length; i++) {
			var itemId:String = data.array_items[i];
			data[itemId].expandido = true;
		}
	}
	private function emitirActualizacion() {
		trace("(ListaExpandible.emitirActualizacion)!");
		var objPosiciones:Object = get_objPosiciones();
		Object2.traceObject(objPosiciones, "objPosiciones")
		//--
		var obj:Object = new Object();
		obj.type = "onListaActualizada";
		obj.id = id;
		obj.objPosiciones = objPosiciones;
		obj.configTween = configTween;
		obj.actualizacionInicial = actualizacionInicial;
		emisor.emitir_objeto(obj);
		//--
		actualizacionInicial = false;
	}
	private function emitir_objPosiciones(objPosiciones:Object) {
		trace("(ListaExpandible.emitir_objPosiciones): " + objPosiciones.posLista);
		// Igual que emitirActualizacion() solo que se le pasa objPosiciones y lo calcula automaticamente.
		var obj:Object = new Object();
		obj.type = "onListaActualizada";
		obj.id = id;
		obj.objPosiciones = objPosiciones;
		obj.configTween = configTween;
		obj.actualizacionInicial = actualizacionInicial;
		emisor.emitir_objeto(obj);
		//--
		actualizacionInicial = false;
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onListaActualizada",ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento,ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento,ref);
	}
	//--------------------
	// SNIPPETS:
}