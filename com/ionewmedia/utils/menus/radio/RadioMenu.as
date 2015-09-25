/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.eventos.gestoreventos.GestorEventos;
class com.ionewmedia.utils.menus.radio.RadioMenu {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var emisor:GestorEventos;
	var menu_mc:MovieClip;
	var array_opciones:Array;
	var array_valores:Array;
	//--
	public var _opcionSel:String;
	//--------------------
	// CONSTRUCTORA:
	function RadioMenu() {
		trace("(RadioMenu.CONSTRUCTORA)!");
		init_emisor();
	}
	public function init(donde_mc:MovieClip, aO:Array, aV:Array, oS:String) {
		// donde, array_opciones, array_valores, _opcionSel
		//trace("(RadioMenu.init)!");
		menu_mc = donde_mc;
		array_opciones = aO;
		array_valores = aV;
		_opcionSel = oS;
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
		//trace("(RadioMenu.seleccionar_opcion): "+opcionId);
		_opcionSel = opcionId;
		emisor.emitir("onOpcionSeleccionada");
	}
	public function get_valor() {
		//trace("(RadioMenu.get_valor)!");
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
			//trace("(RadioMenu.registrar_botones)!");
		for (var i = 0; i<array_opciones.length; i++) {
			var opcionId = array_opciones[i];
			var donde:MovieClip = menu_mc[opcionId];
			trace("   opcionId: "+opcionId+"   "+donde)
			if (donde != undefined) {
				notify_boton(donde);
			} else {
				//trace("(RadioMenu) No existe el boton para la opcion: "+opcionId);
				Trace.trc("(RadioMenu) No existe el boton para la opcion: "+opcionId, "fatal");
			}
		}
	}
	private function notify_boton(donde:MovieClip) {
		//trace("(RadioMenu.notify_boton)!");
		donde.notify_menu(this);
		emisor.registrar("onOpcionSeleccionada", donde);
	}
	//--------------------
	// EMISOR:
	private function init_emisor() {
		emisor = new GestorEventos();
	}
	//--------------------
	// SNIPPETS:
}
