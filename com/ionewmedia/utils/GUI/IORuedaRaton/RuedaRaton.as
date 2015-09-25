/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 2008
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.Object2;
class com.ionewmedia.utils.GUI.IORuedaRaton.RuedaRaton {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	private var mouseListener:Object;
	private var mcRef:MovieClip;
	private var id:String = null;
	//--------------------
	// CONSTRUCTORA:
	function RuedaRaton(_mcRef:MovieClip, _id:String) {
		trace("(RuedaRaton.CONSTRUCTORA)!");
		//--
		mcRef = _mcRef;
		id = _id;
		//--
		emisor = new EmisorExtendido();
		mouseListener = new Object();
	}
	function init() {
		trace("(RuedaRaton.init)!");
		var donde:RuedaRaton = this;
		mouseListener.onMouseWheel = function(delta) {
			//trace("x")
			donde.ruedaActivada(delta);
		};
		Mouse.addListener(mouseListener);
	}
	//--------------------
	// METODOS PUBLICOS:
	function kill() {
		mouseListener = new Object();
	}

	//--------------------
	// METODOS PRIVADOS:
	function ruedaActivada(delta) {
		//trace("(RuedaRaton.ruedaActivada): "+delta);
		var ambito:MovieClip = mcRef._parent;
		//trace("   ambito: "+ambito)
		trace("   mcRef: " + mcRef);
		//var dentroReferencia:Boolean = mcRef.hitTest(_xmouse, _ymouse, true);
		var limSup:Number = mcRef._y;
		var limIzq:Number = mcRef._x;
		var limInf:Number = mcRef._y + mcRef._height;
		var limDer:Number = mcRef._x + mcRef._width;
		var mousePosX:Number = ambito._xmouse;
		var mousePosy:Number = ambito._ymouse;
		//--
		/*
		trace("---")
		trace("   limSup: "+limSup)
		trace("   limInf: "+limInf)
		trace("   limIzq: "+limIzq)
		trace("   limDer: "+limDer)
		trace("   _xmouse: "+_xmouse)
		trace("   _ymouse: "+_ymouse)
		trace("   mousePosX: "+mousePosX)
		trace("   mousePosy: "+mousePosy)
		trace("---")
		*/
		//--
		var dentroReferencia:Boolean = false;
		if (mousePosX >= limIzq && mousePosX <= limDer && mousePosy >= limSup && mousePosy <= limInf) {
			dentroReferencia = true;
		}
		if (dentroReferencia) {
			//trace("x")
			var obj:Object = new Object();
			obj.type = "onRuedaActivada";
			obj.id = id;
			obj.delta = delta;
			emisor.emitir_objeto(obj);
		}
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		//emisor.addEventListener("onCoreCargado",ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento,ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento,ref);
	}
	//--------------------
	// SNIPPETS:
}