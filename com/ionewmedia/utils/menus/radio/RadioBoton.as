/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
import com.ionewmedia.utils.menus.radio.RadioMenu;
class com.ionewmedia.utils.menus.radio.RadioBoton extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var opcionId:String;
	var menu:RadioMenu;
	// Mcs anidados:
	var bt:Button;
	//--------------------
	// CONSTRUCTORA:
	function RadioBoton() {
		//trace("(RadioBoton.CONSTRUCTORA)!");
		opcionId = this._name;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function notify_menu(donde:RadioMenu) {
		//trace("(RadioBoton.notify_menu)!");
		menu = donde;
		init_boton();
	}
	//--------------------
	// METODOS PRIVADOS:
	private function eval_estado() {
		if (menu._opcionSel == opcionId) {
			view_ON();
		} else {
			view_OFF();
		}
	}
	private function view_ON() {
		//trace("(RadioBoton.view_ON)!");
		this.gotoAndStop("ON");
	}
	private function view_OFF() {
		//trace("(RadioBoton.view_OFF)!");
		this.gotoAndStop("OFF");
	}
	private function init_boton() {
		var donde = this;
		bt.onPress = function() {
			trace("(RadioBoton.bt.onPress)!");
			donde.menu.seleccionar_opcion(donde.opcionId);
		};
	}
	//--------------------
	// EVENTOS:
	public function onOpcionSeleccionada() {
		//trace("(RadioBoton.onOpcionSeleccionada)!");
		eval_estado();
	}
	//--------------------
	// SNIPPETS:
}
