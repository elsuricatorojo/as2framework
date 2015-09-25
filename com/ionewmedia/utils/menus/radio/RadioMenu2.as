/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.menus.radio.RadioMenu2 {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var emisor:EmisorExtendido
	var menu_mc:MovieClip;
	var array_opciones:Array;
	var array_valores:Array;
	var nombreMenu:String;
	//--
	public var _opcionSel:String;
	//--------------------
	// CONSTRUCTORA:
	function RadioMenu2() {
		trace("(RadioMenu2.CONSTRUCTORA)!");
		emisor=new EmisorExtendido()
	}
	public function init(donde_mc:MovieClip, aO:Array, aV:Array, oS:String,_nombreMenu:String) {
		// donde, array_opciones, array_valores, _opcionSel
		trace("(RadioMenu2.init)!");
		menu_mc = donde_mc;
		array_opciones = aO;
		array_valores = aV;
		_opcionSel = oS;
		nombreMenu=_nombreMenu
		//trace("  menu_mc: "+menu_mc);
		//trace("  array_opciones: "+array_opciones);
		//trace("  array_valores: "+array_valores);
		//trace("  _opcionSel: "+_opcionSel);
		//--
		registrar_botones();
		//--
		seleccionar_opcion(oS);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function seleccionar_opcion(opcionId:String) {
		//trace("(RadioMenu2.seleccionar_opcion): "+opcionId);
		_opcionSel = opcionId;
		var obj:Object = new Object()
		obj.type = "onRadioSeleccionado"
		obj.nombreMenu=nombreMenu
		obj.opcionId = opcionId
		emisor.emitir_objeto(obj)

	}
	public function get_valor() {
		//trace("(RadioMenu2.get_valor)!");
		var pos:Number = Array2.devolverId(array_opciones, _opcionSel);
		if (pos == null) {
			return null;
		} else {
			return array_valores[pos];
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	private function registrar_botones() {
		for (var i = 0; i<array_opciones.length; i++) {
			var opcionId = array_opciones[i];
			var donde:MovieClip = menu_mc[opcionId];
			if (donde != undefined) {
				notify_boton(donde);
			} else {
				//trace("(RadioMenu2) No existe el boton para la opcion: "+opcionId);
				Trace.trc("(RadioMenu2) No existe el boton para la opcion: "+opcionId, "fatal");
			}
		}
	}
	private function notify_boton(donde:MovieClip) 
	{
		donde.notify_menu(this);
		emisor.registrar("onRadioSeleccionado", donde);
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onRadioSeleccionado", ref);
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
	//--------------------
	// SNIPPETS:
}
