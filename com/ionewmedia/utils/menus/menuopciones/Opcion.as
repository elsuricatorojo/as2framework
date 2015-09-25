/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20060906
*/
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.menus.menuopciones.*;
class com.ionewmedia.utils.menus.menuopciones.Opcion {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	// logicaMenu es una instancia de MenuItem
	private var logicaMenu:Object;
	public var itemId:String;
	private var bt_mc:Object;
	//--------------------
	// CONSTRUCTORA:
	function Opcion(id:String, m:Object, bt:Object) {
		//trace("(Opcion.CONSTRUCTORA): " + id);
		init_emisor();
		itemId = id;
		logicaMenu = m;
		this.addListener(logicaMenu)
		bt_mc = bt;
		//bt_mc._x = 20;
		//trace(typeof (bt));
		//--
		//trace("   itemId: "+itemId);
		//trace("   logicaMenu: "+logicaMenu);
		//trace("   bt_mc: "+bt_mc);
		//--
	}
	function init() {
		logicaMenu.notify_item(this);
		init_bt();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function seleccionar() {
		logicaMenu.seleccionar_item(itemId);
	}
	public function rollover() {
		var obj:Object = new Object();
		obj.type = "onRolloverBt";
		obj.itemId = itemId;
		emisor.emitir_objeto(obj);
	}
	public function rollout() {
		var obj:Object = new Object();
		obj.type = "onDeseleccionado";
		obj.itemId = itemId;
		emisor.emitir_objeto(obj);
	}
	public function kill() {
		// Elimina la parte logica del item
		logicaMenu.deleteItem(this);
		delete this;
	}
	public function notify_listener(donde:Object) {
		//trace("(Opcion.notify_listener): "+itemId+"   donde: "+donde);
		//onSeleccionado, onDeseleccionado, onRolloverBt
		emisor.registrar("onSeleccionado",donde);
		emisor.registrar("onDeseleccionado",donde);
		emisor.registrar("onRolloverBt",donde);
	}
	public function addListener(donde:Object) {
		notify_listener(donde);
	}
	public function removeListener(donde:Object) {
		emisor.removeListener(donde);
	}
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// METODOS PRIVADOS:
	// MODIFICADO 02/03/2010 19:23 (hecho publico)
	public  function eval_estado() {
		//trace("(Opcion.eval_estado)  itemSel: "+logicaMenu.itemIdSel+"   itemId: "+itemId);
		if (logicaMenu.itemIdSel == itemId) {
			var obj:Object = new Object();
			obj.type = "onSeleccionado";
			obj.itemId = itemId;
			emisor.emitir_objeto(obj);
		} else {
			var obj:Object = new Object();
			obj.type = "onDeseleccionado";
			obj.itemId = itemId;
			emisor.emitir_objeto(obj);
		}
	}
	private function init_bt() {
		var donde = this;
		bt_mc.onPress = function() {
			trace("(Opcion.bt_mc.onPress)!");
			if (donde.logicaMenu.itemIdSel != donde.itemId) {
				donde.seleccionar();
			}else if(donde.logicaMenu.emitirSiYaSeleccionado){
				donde.seleccionar();
			}
		};
		bt_mc.onRollOver = function() {
			//trace("(Opcion.bt_mc.onRollOver)!");
			if (donde.logicaMenu.itemIdSel != donde.itemId) {
				donde.rollover();
			}
		};
		bt_mc.onRollOut = bt_mc.onReleaseOutside = function () {
			//trace("(Opcion.bt_mc.onRollOut)!");
			if (donde.logicaMenu.itemIdSel != donde.itemId) {
				donde.rollout();
			}
		};
	}
	//--------------------
	// EVENTOS:
	public function onEvalEstado() {
		//trace("(Opcion.onEvalEstado)!");
		eval_estado();
	}
	public function onInitKill() {
		removeAllListeners()
	}
	//--------------------
	// EMISOR:
	private function init_emisor() {
		emisor = new EmisorExtendido();
	}
	//--------------------
	// SNIPPETS:
}