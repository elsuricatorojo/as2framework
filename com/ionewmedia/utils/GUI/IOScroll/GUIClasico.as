/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070109
*/
import com.ionewmedia.utils.eventos.Emisor;
import com.ionewmedia.utils.GUI.IOScroll.IOScroll;
class com.ionewmedia.utils.GUI.IOScroll.GUIClasico {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:Emisor;
	var altoScroll:Number;
	var altoVisor:Number;
	var altoContenidos:Number;
	public var view_mc:MovieClip;
	var btSup_mc:MovieClip;
	var slider_mc:MovieClip;
	var btInf_mc:MovieClip;
	public var rangoScroll:Number;
	public var saltoScrollDeseado:Number;
	// NUEVO:10/03/2011 10:50
	public var ultimoFactor:Number = 0
	//--------------------
	// CONSTRUCTORA:
	function GUIClasico(_altoScroll:Number, _altoVisor:Number, _altoContenidos:Number) {
		trace("(GUIClasico.CONSTRUCTORA)!");
		altoScroll = _altoScroll;
		altoVisor = _altoVisor;
		altoContenidos = _altoContenidos;
		emisor = new Emisor();
	}
	public function init() {
		trace("(GUIClasico.init)!");
		rangoScroll = altoScroll-(btSup_mc.view._height+slider_mc.view._height+btInf_mc.view._height);
		var saltoContDeseado = altoVisor*0.8;
		var rangoCont:Number = altoContenidos-altoVisor;
		var numSaltos:Number = rangoCont/saltoContDeseado;
		saltoScrollDeseado = rangoScroll / numSaltos;
		trace("   altoScroll: " + altoScroll);
		trace("   altoVisor: " + altoVisor);
		trace("   altoContenidos: " + altoContenidos);
		trace("   btSup_mc.view._height: " + btSup_mc.view._height);
		trace("   slider_mc.view._height: " + slider_mc.view._height);
		trace("   btInf_mc.view._height: "+btInf_mc.view._height);
		trace("   rangoScroll: "+rangoScroll);
		trace("   rangoCont: "+rangoCont);
		trace("   saltoContDeseado: "+saltoContDeseado);
		trace("   numSaltos: "+numSaltos);
		trace("   saltoScrollDeseado: "+saltoScrollDeseado);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function actualizarDatos(factor:Number) {
		ultimoFactor = factor
		var obj:Object = new Object();
		obj.type = "onGUIActualizado";
		obj.factor = factor;
		emisor.emitir_objeto(obj);
	}
	public function posicionarSlider(factor:Number) {
		// NUEVO 17/04/2008 10:59
		slider_mc._y = (factor * rangoScroll)+slider_mc.yMin
		actualizarDatos(factor)
	}
	public function get_factor():Number {
		trace("(GUIClasico.get_factor)!");
		// NUEVO: 10/03/2011 10:49
		return ultimoFactor
	}
	//--------------------
	// ADDs:
	function add_logica(donde:IOScroll) {
		emisor.registrar("onGUIActualizado", donde);
	}
	function add_view(donde:MovieClip) {
		view_mc = donde;
		emisor.registrar("onMostrar", donde);
		emisor.registrar("onOcultar", donde);
	}
	//--
	function add_btSup(donde:MovieClip) {
		btSup_mc = donde;
	}
	function add_slider(donde:MovieClip) {
		slider_mc = donde;
		emisor.registrar("onPressInf", donde);
		emisor.registrar("onPressSup", donde);
	}
	function add_btInf(donde:MovieClip) {
		btInf_mc = donde;
	}
	//--------------------
	// BOTONES:
	public function btSup_presionado() {
		emisor.emitir("onPressSup");
	}
	public function slider_presionado() {
	}
	public function btInf_presionado() {
		emisor.emitir("onPressInf");
	}
	//--------------------
	// METODOS PRIVADOS:
	private function get_saltoScroll() {
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	public function onMostrarGUI() {
		// Lo emite IOScroll
		emisor.emitir("onMostrar");
	}
	public function onOcultarGUI() {
		// Lo emite IOScroll
		emisor.emitir("onOcultar");
	}
	public function onActualizarGUI(obj:Object) {
		// Lo emite IOScroll
	}
	//--------------------
	// SNIPPETS:
}
