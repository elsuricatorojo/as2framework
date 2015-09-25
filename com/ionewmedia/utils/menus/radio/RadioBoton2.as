/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
import com.ionewmedia.utils.menus.radio.RadioMenu2;
class com.ionewmedia.utils.menus.radio.RadioBoton2 extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var opcionId:String;
	var menu:RadioMenu2;
	// Mcs anidados:
	var bt:Button;
	//--------------------
	// CONSTRUCTORA:
	function RadioBoton2() {
		trace("(RadioBoton2.CONSTRUCTORA)!");
		opcionId = this._name;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function notify_menu(donde:RadioMenu2) {
		trace("(RadioBoton2.notify_menu)!");
		menu = donde;
		init_boton();
	}
	//--------------------
	// METODOS PRIVADOS:
	private function eval_estado() 
	{
		if (menu._opcionSel == opcionId) {
			view_ON();
		} else {
			view_OFF();
		}
	}
	private function view_ON() {
		//trace("(RadioBoton2.view_ON)!");
		this.gotoAndStop("ON");
	}
	private function view_OFF() {
		//trace("(RadioBoton2.view_OFF)!");
		this.gotoAndStop("OFF");
	}
	private function init_boton() {
		var donde = this;
		bt.onPress = function() {
			//trace("(RadioBoton2.bt.onPress)!");
			donde.menu.seleccionar_opcion(donde.opcionId);
		};
	}
	//--------------------
	// EVENTOS:
	public function onRadioSeleccionado() {
		trace("(RadioBoton2.onRadioSeleccionado)!");
		eval_estado();
	}
	//--------------------
	// SNIPPETS:
}
