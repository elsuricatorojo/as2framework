/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* 
* 
* NUEVO 06/06/2008 11:19
* Se le ha añadido la capacidad de emitir el evento onCheckCambiado al hacerse un switch a su estado
*/
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.forms.DataForm;
class com.ionewmedia.utils.menus.checkbox.CheckBoton extends MovieClip {
	//--------------------
	// PARAMETROS:
	var emisor:EmisorExtendido
	var campoId:String;
	var form:DataForm;
	var valor:Boolean;
	var bt:Button;
	// NUEVO 10/12/2008 11:52
	var id:String = null
	//--------------------
	// CONSTRUCTORA:
	function CheckBoton() {
		trace("(CheckBoton.CONSTRUCTORA)!");
		emisor=new EmisorExtendido()
		campoId = this._name;
		valor = false;
		init_boton();
		eval_estado()
	}
	// NUEVO 10/12/2008 11:52
	// Se añade el parametro id (opcional para conservar retrocompatibilidad)
	public function init(dDF:DataForm, vIni:Boolean, _id:String) {
		trace("(CheckBoton.init)!");
		form = dDF;
		valor = vIni;
		if (_id != undefined) {
			id=_id
		}
		eval_estado();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function get_valor():Boolean {
		return valor;
	}
	// NUEVO 10/12/2008 11:52
	// Permite fozar un cambio desde fuera:
	public function set_valor(_valor:Boolean):Void {
		valor = _valor;
		eval_estado();
	}
	//--------------------
	// METODOS PRIVADOS:
	private function eval_estado() {
		trace("(CheckBoton.eval_estado) form: "+form);
		if (valor) {
			this.gotoAndStop("ON");
		} else {
			this.gotoAndStop("OFF");
		}
		if (form != undefined) {
			form.validar();
		}
	}
	private function switch_valor() {
		if (valor) {
			valor = false;
		} else {
			valor = true;
		}
		eval_estado();
		//--
		var obj:Object = new Object()
		obj.type = "onCheckCambiado"
		obj.campoId = campoId
		obj.valor = valor
		obj.id = id
		emisor.emitir_objeto(obj)
	}
	private function init_boton() {
		var donde = this;
		bt.onPress = function() {
			//trace("(RadioBoton.bt.onPress)!");
			donde.switch_valor();
		};
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onCheckCambiado", ref);
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
	// SNIPPETS:
}
