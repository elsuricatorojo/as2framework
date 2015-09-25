/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070109
*/
import com.ionewmedia.utils.eventos.Emisor;
class com.ionewmedia.utils.GUI.IOScroll.IOScroll {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:Emisor;
	//--
	public var dondeCont:MovieClip;
	public var altoScroll:Number;
	public var altoVisor:Number;
	public var altoContenidos:Number;
	public var inercia:Number;
	//--
	public var yIniCont:Number;
	public var rangoCont:Number;
	private var yFinalCont:Number;
	private var gui:Object;
	private var motor_mc:MovieClip;
	// NUEVO 17/09/2010 13:16
	public var forzarYIni0:Boolean =false
	//--
	//--------------------
	// CONSTRUCTORA:
	function IOScroll(_dondeCont:MovieClip, _altoScroll:Number, _altoVisor:Number, _altoContenidos:Number, _inercia:Number) {
		//(dondeCont, altoScroll, altoVisor, altoContenidos, inercia)
		trace("(IOScroll.CONSTRUCTORA)!");
		dondeCont = _dondeCont;
		altoScroll = _altoScroll;
		altoVisor = _altoVisor;
		altoContenidos = _altoContenidos;
		inercia = _inercia;
		//--
		emisor = new Emisor();
	}
	public function init() {
		trace("(IOScroll.init)!");
		// En este punto los componentes (bts y sliders) ya se han añadido/notificado.
		rangoCont = altoContenidos - altoVisor;
		if (forzarYIni0) {
			yIniCont = 0
		}else {
			yIniCont = dondeCont._y;
		}
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
		return (altoVisor*modificador);
	}
	//--------------------
	//public function addListener(donde:Object) {
	//trace("(IOScroll.addListener)!");
	//}
	public function add_gui(donde:Object) {
		trace("(IOScroll.add_gui)!");
		gui = donde;
		//--
		emisor.registrar("onOcultarGUI", donde);
		emisor.registrar("onMostrarGUI", donde);
		emisor.registrar("onActualizarGUI", donde);
	}
	//--------------------
	// METODOS PRIVADOS:
	private function eval_visible() {
		if (altoContenidos<=altoVisor) {
			trace("(IOScroll.eval_visible): onOcultar");
			emisor.emitir("onOcultarGUI");
		} else {
			trace("(IOScroll.eval_visible): onConstruir");
			emisor.emitir("onMostrarGUI");
		}
	}
	private function actualizarCont(factor:Number) {
		//trace("(IOScroll.actualizarCont) factor: "+factor);
		yFinalCont = Math.round(yIniCont - (rangoCont * factor));
		//trace("   yFinalCont: "+yFinalCont)
		if (inercia == 0) {
			dondeCont._y = yFinalCont;
		} else if (dondeCont._y != yFinalCont) {
			aplicarInercia();
		}
	}
	private function aplicarInercia() {
		//trace("(IOScroll.aplicarInercia)!");
		var dondeMotor:MovieClip = get_motor();
		var donde = this;
		if (dondeMotor.onEnterFrame == undefined) {
			//trace("***");
			dondeMotor.onEnterFrame = function() {
				donde.posicionarConInercia();
			};
		}
	}
	private function posicionarConInercia() {
		var resta:Number = Math.abs(yFinalCont-dondeCont._y);
		if (resta<1) {
			dondeCont._y = yFinalCont;
			var dondeMotor:MovieClip = get_motor();
			delete dondeMotor.onEnterFrame;
		} else {
			dondeCont._y = scrollEase(dondeCont._y, yFinalCont, inercia);
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
		//trace("(IOScroll.onGUIActualizado): "+obj.factor);
		var factor:Number = obj.factor;
		actualizarCont(factor);
	}
	//--------------------
	// SNIPPETS:
}
