/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061122
* Modificada: 01/10/2008 15:23
*/
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.menus.menuopciones.Opcion;
class com.ionewmedia.utils.menus.menuopciones.MenuOpciones {
	//--------------------
	// DOCUMENTACION:
	// NUEVO 01/10/2008 15:23:
	// Se ha añadido la posibilidad de que tenga un id cada instancia de la clase:
	// Se ha añadido la preferencia de si se emite onEvalEstado con cada notificacion de una opcion.
	//--------------------
	// PARAMETROS:
	private var id:String
	private var emisor:EmisorExtendido;
	public var array_items:Array;
	public var array_itemsId:Array;
	public var itemIdSel:String;
	public var emitirSiYaSeleccionado:Boolean = false
	public var emitirEvalEstadoAlRegistrar:Boolean=true
	//--------------------
	// CONSTRUCTORA:
	function MenuOpciones(sel:String, _id:String) {
		//trace("(MenuOpciones.CONSTRUCTORA)!");
		id=_id
		array_items = new Array();
		array_itemsId = new Array();
		if (sel == undefined) {
			itemIdSel = null;
		} else {
			itemIdSel = sel;
		}
		init_emisor();
	}
	public function testScope(txt:String):Void {
		trace("(MenuOpciones.testScope) ----------------- "+txt);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function seleccionar_item(itemId:String, emitir:Boolean) {
		// Emitir hace referencia asi queremos que se emita el evento "onSeleccionarItem"
		trace("(MenuOpciones.seleccionar_item): " + itemId);
		//trace("   itemIdSel: " + itemIdSel)
		//trace("   itemId: "+itemId)
		if (itemIdSel != itemId) {
			itemIdSel = itemId;
			emisor.emitir("onEvalEstado");
			//--
			if (emitir == undefined) {
				// Valor por defecto
				emitir = true;
			}
			if (emitir) {
				var objEvento:Object = new Object();
				objEvento.type = "onSeleccionarItem";
				objEvento.id = id;
				objEvento.itemSel = itemIdSel;
				emisor.emitir_objeto(objEvento);
			}
		}else if(emitirSiYaSeleccionado){
			itemIdSel = itemId;
			emisor.emitir("onEvalEstado");
			//--
			if (emitir == undefined) {
				// Valor por defecto
				emitir = true;
			}
			if (emitir) {
				var objEvento:Object = new Object();
				objEvento.type = "onSeleccionarItem";
				objEvento.id = id;
				objEvento.itemSel = itemIdSel;
				emisor.emitir_objeto(objEvento);
			}
		}
	}
	public function deleteItem(item:Object) {
		var posItem:Number = Array2.devolverId(array_items, item);
		var itemId:String = array_itemsId[posItem];
		if (posItem != undefined && posItem != null) {
			array_items = Array2.quitarElem(array_items, item);
			array_itemsId = Array2.quitarElem(array_itemsId, itemId);
		}
		if (itemId == itemIdSel) {
			itemIdSel = null;
			emisor.emitir("onEvalEstado");
		}
	}
	public function deleteItemId(itemId:Object) {
		var posItemId:Number = Array2.devolverId(array_itemsId, itemId);
		var item:String = array_items[posItemId];
		if (posItemId != undefined && posItemId != null) {
			array_items = Array2.quitarElem(array_items, item);
			array_itemsId = Array2.quitarElem(array_itemsId, item);
		}
		if (itemId == itemIdSel) {
			itemIdSel = null;
			emisor.emitir("onEvalEstado");
		}
	}
	public function initKill() {
		emisor.emitir("onInitKill");
		removeAllListeners()
	}
	public function actualizar() {
		// NUEVO 01/10/2008 16:09:
		emisor.emitir("onEvalEstado");
	}
	//--------------------
	// EVENTOS:
	//--------------------
	// NOTIFYs:
	public function notify_item(donde:Object) {
		//trace("(MenuOpciones.notify_item): "+donde.itemId);
		array_items.push(donde);
		array_itemsId.push(donde.itemId);
		emisor.registrar("onInitKill", donde);
		emisor.registrar("onEvalEstado", donde);
		// NUEVO 01/10/2008 16:09:
		if(emitirEvalEstadoAlRegistrar){
			emisor.emitir("onEvalEstado");
		}
	}
	public function notify_listener(donde:Object) {
		emisor.registrar("onSeleccionarItem",donde);
	}
	public function addListener(donde:Object) {
		emisor.registrar("onSeleccionarItem",donde);
	}
	public function removeListener(donde:Object) {
		emisor.registrar("onSeleccionarItem",donde);
	}
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_emisor() {
		emisor = new EmisorExtendido();
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}