/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
MODIFICADO: 20061017
   - Añadidos los eventos onCampoCambiado, onCampoEnfocado, onCampoDesenfocado declarando como oyente a form_mc
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.Form2;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.gestoreventos.GestorEventos;
class com.ionewmedia.utils.forms.DataForm {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var emisor:GestorEventos;
	var form_mc:MovieClip;
	var array_campos:Array;
	var array_tipos:Array;
	var array_obligatorios:Array;
	private var objValidar:Object;
	// arrayGestionAutom: indica que tipo de valores se validan directamente con las clases estaticas de Form2
	private var arrayGestionExterna:Array;
	private var autonumerico:Number = 0;
	//--------------------
	// CONSTRUCTORA:
	function DataForm() {
		trace("(DataForm.CONSTRUCTORA)!");
		init_emisor();
	}
	public function init(fmc:MovieClip, aC:Array, aT:Array, aO:Array, tab:Number) {
		trace("(DataForm.init)!");
		form_mc = fmc;
		emisor.registrar("onFormOK", form_mc);
		emisor.registrar("onFormKO", form_mc);
		// NUEVO 20061017
		emisor.registrar("onCampoCambiado", form_mc);
		emisor.registrar("onCampoEnfocado", form_mc);
		emisor.registrar("onCampoDesenfocado", form_mc);
		array_campos = aC;
		array_tipos = aT;
		array_obligatorios = aO;
		if (tab == undefined || tab == null) {
			autonumerico = 100;
		} else {
			autonumerico = tab;
		}
		//--
		arrayGestionExterna = ["texto", "texto6", "texto3", "email", "textoSeguro", "numero", "dia", "mesNumerico", "mesCadena", "dni", "nif", "letranif"];
		//--
		registrar_textFields();
		registrar_fondos();
		//--
		validar();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function validar() {
		// MODIFICADO EL 20060904 (Se ha externalizado en una clase privada 'update_objValidar()' la actualización de objValidar)
		trace("(DataForm.validar)!");
		update_objValidar();
		if (objValidar.valido) {
			var objEvento = new Object();
			objEvento.type = "onFormOK";
			objEvento.objValidar = objValidar;
			emisor.emitir_objeto(objEvento);
		} else {
			var objEvento = new Object();
			objEvento.type = "onFormKO";
			objEvento.objValidar = objValidar;
			emisor.emitir_objeto(objEvento);
		}
	}
	public function eval_valido():Boolean {
		// AÑADIDO EL 20060904
		// Actualiza el objValidar y devuelve un booleano indicando si es valido el form o no.
		update_objValidar();
		return objValidar.valido;
	}
	public function get_data():Object {
		//trace("(DataForm.get_data)!");
		var obj = new Object();
		var valor:String
		for (var i = 0; i<array_campos.length; i++) {
			var campo:String = array_campos[i];
			var tipo:String = array_tipos[i];
			//trace("   campo: "+campo);
			//trace("   tipo: "+tipo);
			if (tipo == "radiomenu" || tipo == "checkboton" || tipo == "combo") {
				//trace("  tipo especial ");
				 valor = form_mc[campo].get_valor();
			} else {
				//trace("  tipo normal ");
				 valor = form_mc[campo+"_txt"].text;
			}
			obj[campo] = valor;
		}
		return obj;
	}
	public function resetear() {
		for (var i = 0; i<array_campos.length; i++) {
			var campo:String = array_campos[i];
			var tipo:String = array_tipos[i];
			if (tipo != "radiomenu") {
				form_mc[campo+"_txt"].text = "";
			}
		}
		validar();
	}
	//--------------------
	// METODOS PRIVADOS:
	private function update_objValidar():Void {
		// AÑADIDO EL 20060904
		var valido:Boolean
		objValidar = new Object();
		objValidar.valido = true;
		objValidar.arrayNoValidos = new Array();
		for (var i = 0; i<array_campos.length; i++) {
			var campo:String = array_campos[i];
			var tipo:String = array_tipos[i];
			var obligatorio:Boolean = array_obligatorios[i];
			if (obligatorio == undefined) {
				obligatorio = true;
			}
			var valor:String = form_mc[campo+"_txt"].text;
			var gestionExterna:Boolean = Array2.estaEnElArray(arrayGestionExterna, tipo);
			if (gestionExterna) {
				 valido = validar_externamente(campo, tipo, valor);
			} else {
				 valido = validar_internamente(campo, tipo, valor);
			}
			//-- 
			objValidar[campo] = new Object();
			objValidar[campo].valor = valor;
			objValidar[campo].valido = valido;
			if (!valido && obligatorio) {
				objValidar.valido = false;
				objValidar.arrayNoValidos.push(campo);
				//--
				var objEvento = new Object();
				objEvento.type = "onCampoKO";
				objEvento.campo = campo;
				emisor.emitir_objeto(objEvento);
			} else if (valido) {
				var objEvento = new Object();
				objEvento.type = "onCampoOK";
				objEvento.campo = campo;
				emisor.emitir_objeto(objEvento);
			}
		}
	}
	private function validar_externamente(campo:String, tipo:String, valor:String):Boolean {
		return Form2["validar_"+tipo](valor);
	}
	private function validar_internamente(campo:String, tipo:String, valor:String):Boolean {
		//trace("(DataForm.validar_internamente): "+tipo);
		if (tipo == "repitepass") {
			return validar_repitepass(campo, valor);
		} else if (tipo == "radiomenu") {
			return validar_radiomenu(campo, valor);
		} else if (tipo == "checkboton") {
			return validar_checkboton(campo, valor);
		} else if (tipo == "combo") {
			return validar_combo(campo, valor);
		} else {
			return true;
		}
	}
	//------------------
	private function validar_repitepass(campo:String, valor:String):Boolean {
		//trace("(DataForm.validar_repitepass): "+campo);
		if (form_mc.pass_txt.text == form_mc.repitepass_txt.text && objValidar.pass.valido) {
			return true;
		} else {
			return false;
		}
	}
	private function validar_radiomenu(campo:String, valor:String):Boolean {
		//trace("(DataForm.validar_radiomenu): "+campo);
		valor = form_mc[campo].get_valor();
		//trace("   valor: "+valor);
		var posCampo:Number = Array2.devolverId(array_campos, campo);
		var obligatorio = array_obligatorios[posCampo];
		if (valor == null && obligatorio) {
			return false;
		} else {
			return true;
		}
	}
	private function validar_checkboton(campo:String, valor:String):Boolean {
		// Si se marca como obligatorio un checkboton se entiende que el usuario debe activarlo para 
		// validar el campo.
		//trace("(DataForm.validar_checkboton): "+campo);
		valor = form_mc[campo].get_valor();
		//trace("   valor: "+valor);
		var posCampo:Number = Array2.devolverId(array_campos, campo);
		var obligatorio = array_obligatorios[posCampo];
		if (valor != true && obligatorio) {
			return false;
		} else {
			return true;
		}
	}
	private function validar_combo(campo:String, valor:String):Boolean {
		valor = form_mc[campo].get_valor();
		var posCampo:Number = Array2.devolverId(array_campos, campo);
		var obligatorio = array_obligatorios[posCampo];
		if (valor == null && obligatorio) {
			return false;
		} else {
			return true;
		}
	}
	//------------------
	private function registrar_textFields() {
		//trace("(DataForm.registrar_textFields)!");
		for (var i = 0; i<array_campos.length; i++) {
			var campo:String = array_campos[i];
			var dondeTF:TextField = form_mc[campo+"_txt"];
			dondeTF.tabIndex = get_autonumerico();
			var donde = this;
			if (dondeTF != undefined) {
				//trace("(DataForm) Nos sucribimos al evento onChanged de: "+campo);
				dondeTF.onChanged = function() {
					donde.onCampoCambiado(this);
				};
				// NUEVO 20061017
				dondeTF.onSetFocus = function() {
					donde.onCampoEnfocado(this);
				};
				// NUEVO 20061017
				dondeTF.onKillFocus = function() {
					donde.onCampoDesenfocado(this);
				};
			} else {
				trace("(DataForm) No existe el textField para el campo: "+campo);
				//Trace.trc("(DataForm) No existe el textField para el campo: "+campo, "fatal");
			}
		}
	}
	private function registrar_fondos():Void {
		for (var i = 0; i<array_campos.length; i++) {
			var campo:String = array_campos[i];
			var donde:MovieClip = form_mc[campo+"_fondo"];
			if (donde != undefined) {
				notify_fondo(donde);
			} else {
				trace("(DataForm) No existe el fondo para el campo: "+campo);
			}
		}
	}
	private function notify_fondo(donde:MovieClip):Void {
		emisor.registrar("onCampoOK", donde);
		emisor.registrar("onCampoKO", donde);
	}
	//--------------------
	// EMISOR:
	private function init_emisor() {
		emisor = new GestorEventos();
	}
	function onCampoCambiado(campo_txt:TextField) {
		//trace("(DataForm.onCampoCambiado)!");
		var arrayName:Array = (campo_txt._name).split("_");
		var campo:String = arrayName[0];
		validar();
		//--
		// NUEVO 20061017
		var objEvento:Object = new Object();
		objEvento.type = "onCampoCambiado";
		objEvento.campo_txt = campo_txt;
		objEvento.campo = campo;
		emisor.emitir_objeto(objEvento);
	}
	function onCampoEnfocado(campo_txt:TextField) {
		// NUEVO 20061017
		var arrayName:Array = (campo_txt._name).split("_");
		var campo:String = arrayName[0];
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onCampoEnfocado";
		objEvento.campo_txt = campo_txt;
		objEvento.campo = campo;
		emisor.emitir_objeto(objEvento);
	}
	function onCampoDesenfocado(campo_txt:TextField) {
		// NUEVO 20061017
		var arrayName:Array = (campo_txt._name).split("_");
		var campo:String = arrayName[0];
		//--
		var objEvento:Object = new Object();
		objEvento.type = "onCampoDesenfocado";
		objEvento.campo_txt = campo_txt;
		objEvento.campo = campo;
		emisor.emitir_objeto(objEvento);
	}
	//--------------------
	// SNIPPETS:
	private function get_autonumerico():Number {
		autonumerico++;
		return autonumerico;
	}
}
