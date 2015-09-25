/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070109
*/
import com.ionewmedia.utils.eventos.Emisor;
import com.ionewmedia.utils.GUI.IOScroll.IOScrollHorizontal;
class com.ionewmedia.utils.GUI.IOScroll.GUIClasicoHorizontal
{
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:Emisor;
	var anchoScroll:Number;
	var anchoVisor:Number;
	var anchoContenidos:Number;
	public var view_mc:MovieClip;
	var btSup_mc:MovieClip;
	var slider_mc:MovieClip;
	var btInf_mc:MovieClip;
	public var rangoScroll:Number;
	public var saltoScrollDeseado:Number;
	//--------------------
	// CONSTRUCTORA:
	function GUIClasicoHorizontal(_anchoScroll:Number, _anchoVisor:Number, _anchoContenidos:Number)
	{
		trace("(GUIClasicoHorizontal.CONSTRUCTORA)!");
		anchoScroll = _anchoScroll;
		anchoVisor = _anchoVisor;
		anchoContenidos = _anchoContenidos;
		emisor = new Emisor();
	}
	public function init()
	{
		rangoScroll = anchoScroll - (btSup_mc.view._width + slider_mc.view._width + btInf_mc.view._width);
		var saltoContDeseado = anchoVisor * 0.8;
		var rangoCont:Number = anchoContenidos - anchoVisor;
		var numSaltos:Number = rangoCont / saltoContDeseado;
		saltoScrollDeseado = rangoScroll / numSaltos;
		trace("rangoScroll: " + rangoScroll);
		trace("rangoCont: " + rangoCont);
		trace("saltoContDeseado: " + saltoContDeseado);
		trace("numSaltos: " + numSaltos);
		trace("saltoScrollDeseado: " + saltoScrollDeseado);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function actualizarDatos(factor:Number)
	{
		var obj:Object = new Object();
		obj.type = "onGUIActualizado";
		obj.factor = factor;
		emisor.emitir_objeto(obj);
	}
	//--------------------
	// ADDs:
	function add_logica(donde:IOScrollHorizontal)
	{
		emisor.registrar("onGUIActualizado", donde);
	}
	function add_view(donde:MovieClip)
	{
		view_mc = donde;
		emisor.registrar("onMostrar", donde);
		emisor.registrar("onOcultar", donde);
	}
	//--
	function add_btSup(donde:MovieClip)
	{
		btSup_mc = donde;
	}
	function add_slider(donde:MovieClip)
	{
		slider_mc = donde;
		emisor.registrar("onPressInf", donde);
		emisor.registrar("onPressSup", donde);
	}
	function add_btInf(donde:MovieClip)
	{
		btInf_mc = donde;
	}
	//--------------------
	// BOTONES:
	public function btSup_presionado()
	{
		emisor.emitir("onPressSup");
	}
	public function slider_presionado()
	{
	}
	public function btInf_presionado()
	{
		emisor.emitir("onPressInf");
	}
	//--------------------
	// METODOS PRIVADOS:
	private function get_saltoScroll()
	{
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	public function onMostrarGUI()
	{
		// Lo emite IOScrollHorizontal
		emisor.emitir("onMostrar");
	}
	public function onOcultarGUI()
	{
		// Lo emite IOScrollHorizontal
		emisor.emitir("onOcultar");
	}
	public function onActualizarGUI(obj:Object)
	{
		// Lo emite IOScrollHorizontal
	}
	//--------------------
	// SNIPPETS:
}
