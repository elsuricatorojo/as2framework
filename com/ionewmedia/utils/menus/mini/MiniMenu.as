/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 03/12/2009 23:01
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
class com.ionewmedia.utils.menus.mini.MiniMenu {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	//--
	public var itemSel:String
	public var menuId:String = null
	//--------------------
	// CONSTRUCTORA:
	public function MiniMenu(_itemSel:String, _menuId:String) {
		itemSel = _itemSel
		menuId = _menuId
		emisor = new EmisorExtendido()
	}
	//--------------------
	// METODOS PUBLICOS:
	public function initKill() {
		removeAllListeners()
	}
	public function seleccionarItem(itemId:String):Void {
		itemSel = itemId
		//--
		var obj:Object = new Object()
		obj.type = "onItemSeleccionado"
		obj.itemId = itemSel
		obj.menuId = menuId
		emisor.emitir_objeto(obj)
	}
	public function rollOverItem(itemId:String):Void {
		var obj:Object = new Object()
		obj.type = "onItemRollOver"
		obj.itemId = itemId
		obj.menuId = menuId
		emisor.emitir_objeto(obj)
	}
	public function rollOutItem(itemId:String):Void {
		var obj:Object = new Object()
		obj.type = "onItemRollOut"
		obj.itemId = itemId
		obj.menuId = menuId
		emisor.emitir_objeto(obj)
	}
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		addEventListener("onItemSeleccionado", ref)
		addEventListener("onItemRollOver", ref)
		addEventListener("onItemRollOut", ref)
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
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
	/*
	function eval_estado() {
		if (seleccionado) {
			pintar_sel();
		} else {
			if (enRoll) {
				pintar_roll();
			} else {
				pintar_norm();
			}
		}
	}
	function pintar_sel() {
		bt._visible = false;
		//
	}
	function pintar_norm() {
		bt._visible = true;
		//
	}
	function pintar_roll() {
		bt._visible = true;
		//
	}		
	
	
	// Botones:
	function bt_press() {
		menu.seleccionarItem(itemId);
	}
	function bt_rollOver() {
		menu.rollOverItem(itemId);
	}
	function bt_rollOut() {
		menu.rollOutItem(itemId);
	}
	
	
	on(press){
		bt_press()
	}
	on(rollOver){
		bt_rollOver()
	}
	on(rollOut){
		bt_rollOut()
	}
	on(releaseOutside){
		bt_rollOut()
	}
	
	
	// MiniMenu:
	 function onItemSeleccionado(obj:Object) {
	if (obj.itemId == itemId) {
		trace("(XXX.onItemSeleccionado): "+obj.itemId);
		seleccionado = true;
		eval_estado();
	} else {
		seleccionado = false;
		eval_estado();
	}
	}
	function onItemRollOver(obj:Object) {
		if (obj.itemId == itemId) {
			trace("(XXX.onItemRollOver): "+obj.itemId)
			enRoll = true;
			eval_estado();
		}
	}
	function onItemRollOut(obj:Object) {
		if (obj.itemId == itemId) {
			trace("(XXX.onItemRollOut): "+obj.itemId)
			enRoll = false;
			eval_estado();
		}
	}
	 * */
}