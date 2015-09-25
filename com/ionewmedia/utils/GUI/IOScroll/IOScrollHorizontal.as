/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070109
*/
import com.ionewmedia.utils.eventos.Emisor;
class com.ionewmedia.utils.GUI.IOScroll.IOScrollHorizontal {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:Emisor;
	//--
	public var dondeCont:MovieClip;
	public var anchoScroll:Number;
	public var anchoVisor:Number;
	public var anchoContenidos:Number;
	public var inercia:Number;
	//--
	public var xIniCont:Number;
	public var rangoCont:Number;
	private var xFinalCont:Number;
	private var gui:Object;
	private var motor_mc:MovieClip;
	//--
	//--------------------
	// CONSTRUCTORA:
	function IOScrollHorizontal(_dondeCont:MovieClip, _anchoScroll:Number, _anchoVisor:Number, _anchoContenidos:Number, _inercia:Number) {
		//(dondeCont, anchoScroll, anchoVisor, anchoContenidos, inercia)
		trace("(IOScrollHorizontal.CONSTRUCTORA)!");
		dondeCont = _dondeCont;
		anchoScroll = _anchoScroll;
		anchoVisor = _anchoVisor;
		anchoContenidos = _anchoContenidos;
		inercia = _inercia;
		//--
		emisor = new Emisor();
	}
	public function init() {
		trace("(IOScrollHorizontal.init)!");
		// En este punto los componentes (bts y sliders) ya se han añadido/notificado.
		rangoCont = anchoContenidos-anchoVisor;
		xIniCont = dondeCont._x;
		eval_visible();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function get_saltoContenidos(modificador:Number):Number {
		// El modificador es un valor entre 0 y 1
		if (modificador<0) {
			modificador = 0;
		} else if (modificador>1) {
			modificador = 1;
		} else if (modificador == undefined || modificador == null) {
			modificador = 0.8;
		}
		return (anchoVisor*modificador);
	}
	//--------------------
	//public function addListener(donde:Object) {
	//trace("(IOScrollHorizontal.addListener)!");
	//}
	public function add_gui(donde:Object) {
		trace("(IOScrollHorizontal.add_gui)!");
		gui = donde;
		//--
		emisor.registrar("onOcultarGUI", donde);
		emisor.registrar("onMostrarGUI", donde);
		emisor.registrar("onActualizarGUI", donde);
	}
	//--------------------
	// METODOS PRIVADOS:
	private function eval_visible() {
		if (anchoContenidos<=anchoVisor) {
			trace("(IOScrollHorizontal.eval_visible): onOcultar");
			emisor.emitir("onOcultarGUI");
		} else {
			trace("(IOScrollHorizontal.eval_visible): onConstruir");
			emisor.emitir("onMostrarGUI");
		}
	}
	private function actualizarCont(factor:Number) {
		xFinalCont = Math.round(xIniCont-(rangoCont*factor));
		if (inercia == 0) {
			dondeCont._x = xFinalCont;
		} else if (dondeCont._x != xFinalCont) {
			aplicarInercia();
		}
	}
	private function aplicarInercia() {
		//trace("(IOScrollHorizontal.aplicarInercia)!");
		var dondeMotor:MovieClip = get_motor();
		var donde = this;
		if (dondeMotor.onEnterFrame == undefined) {
			trace("***");
			dondeMotor.onEnterFrame = function() {
				donde.posicionarConInercia();
			};
		}
	}
	private function posicionarConInercia() {
		var resta:Number = Math.abs(xFinalCont-dondeCont._x);
		if (resta<1) {
			dondeCont._x = xFinalCont;
			var dondeMotor:MovieClip = get_motor();
			delete dondeMotor.onEnterFrame;
		} else {
			dondeCont._x = scrollEase(dondeCont._x, xFinalCont, inercia);
		}
	}
	private function scrollEase(posCont:Number, posFinal:Number, vel:Number):Number {
		var pos:Number = null;
		pos = (posFinal+(vel*posCont))/(vel+1);
		//trace(pos);
		return (pos);
	}
	private function get_motor():MovieClip {
		var donde_mc:MovieClip;
		if (motor_mc == undefined) {
			trace("!!");
			var gui_mc = gui.view_mc;
			gui_mc.createEmptyMovieClip("___motor_mc", gui_mc.getNextHighestDepth());
			motor_mc = gui_mc.___motor_mc;
			donde_mc = motor_mc;
		} else {
			donde_mc = motor_mc;
		}
		return (donde_mc);
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	function onGUIActualizado(obj:Object) {
		// Lo llama el GUI
		//trace("(IOScrollHorizontal.onGUIActualizado): "+obj.factor);
		var factor:Number = obj.factor;
		actualizarCont(factor);
	}
	//--------------------
	// SNIPPETS:
}
