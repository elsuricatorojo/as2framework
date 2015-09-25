/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070506
*/
import com.ionewmedia.utils.eventos.Emisor;
import com.ionewmedia.utils.menus.menuopciones.MenuOpciones;
import com.ionewmedia.utils.GUI.IOCombo.DataCombo;
class com.ionewmedia.utils.GUI.IOCombo.IOCombo {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:Emisor;
	private var dataCombo:DataCombo;
	public var opcionesVisibles:Number;
	//--
	public var logicaMenu:MenuOpciones;
	//--------------------
	// CONSTRUCTORA:
	function IOCombo() {
		trace("(IOCombo.CONSTRUCTORA)!");
		emisor = new Emisor();
	}
	public function init(_dataCombo:DataCombo, _seleccionInicial:String, _opcionesVisibles:Number) {
		trace("(IOCombo.init)!");
		dataCombo = _dataCombo;
		opcionesVisibles = _opcionesVisibles;
		if (_seleccionInicial != null && _seleccionInicial != undefined) {
			logicaMenu = new MenuOpciones(_seleccionInicial);
		} else {
			logicaMenu = new MenuOpciones();
		}
		logicaMenu.addListener(this);
		emisor.emitir("onConstruir");
	}
	//--------------------
	// METODOS PUBLICOS:
	public function seleccionarOpcion(opcionId:String) {
		trace("(IOCombo.seleccionarOpcion): "+opcionId);
		logicaMenu.seleccionar_item(opcionId, true);
	}
	public function get_valorSeleccionado():String {
		var opcionSel:String = logicaMenu.itemIdSel;
		return (opcionSel);
	}
	public function get_nombreSeleccionado():String {
		var opcionSel:String = logicaMenu.itemIdSel;
		return dataCombo.get_nombre(opcionSel);
	}
	public function abrirCombo() {
		trace("(IOCombo.abrirCombo)!");
		emisor.emitir("onAbrirCombo");
	}
	public function cerrarCombo() {
		trace("(IOCombo.cerrarCombo)!");
		emisor.emitir("onCerrarCombo");
	}
	public function get_dataCombo():Object {
		//trace("(IOCombo.get_dataCombo)!");
		//dataCombo.trace_data()
		return dataCombo.get_data();
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(donde:Object):Void {
		emisor.registrar("onConstruir", donde);
		emisor.registrar("onAbrirCombo", donde);
		emisor.registrar("onCerrarCombo", donde);
		emisor.registrar("onOpcionSeleccionada", donde);
	}
	public function addEventListener(evento:String, donde:Object):Void {
		emisor.registrar(evento, donde);
	}
	//--------------------
	// EVENTOS:
	// MenuOpciones:
	public function onSeleccionarItem(obj:Object) {
		var obj2:Object = new Object();
		obj2.type = "onOpcionSeleccionada";
		obj2.opcionId = obj.itemSel;
		obj2.nombre = dataCombo.get_nombre(obj.itemSel);
		emisor.emitir_objeto(obj2);
		//--
		cerrarCombo();
	}
	//--------------------
	// SNIPPETS:
}
