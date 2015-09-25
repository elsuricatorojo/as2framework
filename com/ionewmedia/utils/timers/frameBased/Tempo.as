/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 30/06/2008 11:15
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
class com.ionewmedia.utils.timers.frameBased.Tempo {
	//--------------------
	// DOCUMENTACION:
	// La clase utilia un onEnterFlame de un mc y emite el evento "onTempo" en cada frame
	// Es un singelton.
	//--------------------
	// PARAMETROS:
	// Singelton:
	private static var inst:Tempo;
	private static var count:Number = 0;
	//--
	private var mcRef:MovieClip=null
	private var emisor:EmisorExtendido
	private var contador:Number = 0
	private var frameLap:Number = 1 // Cada cuantos frames emite el evento onTempo
	private var ciclos:Number = 0
	public var inicializado:Boolean = false
	// NUEVO 21/07/2013 13:10
	public var enPausa:Boolean = false
	//--------------------
	// CONSTRUCTORA:
	function Tempo(){
		trace("(Tempo.CONSTRUCTORA)!")
		emisor=new EmisorExtendido()
	}
	public static function getInstance ():Tempo {
		//trace("(Tempo.getInstance)!")
			if (inst == null)	{
				inst = new Tempo ();
			}
			++count;
			return inst;
	}
	public function init(_frameLap:Number) {
		trace("(Tempo.init)!")
		inicializado = true
		if (_frameLap != undefined || _frameLap != null) {
			frameLap=_frameLap
		}
		//--
		if (mcRef == undefined || mcRef == null) {
			trace("ATENCION: No se ha definido el mc de referencia necesario!")
		}else{
			var donde=this
			mcRef.onEnterFrame = function() {
				donde.tick()
			}
		}
	}
	function testScope(txt:String){
		trace("(Tempo.testScope) ----------------------- "+txt)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_mcRef(ref:MovieClip):Void {
		mcRef=ref
	}
	// NUEVO 21/07/2013 13:10
	public function pausar() {
		trace("(Tempo.pausar)!")
		enPausa = true
		emisor.emitir("onTempoPausado")
	}
	public function despausar() {
		trace("(Tempo.despausar)!")
		enPausa = false
		emisor.emitir("onTempoDespausado")
	}
	//--------------------
	// METODOS PRIVADOS:
	private function tick() {
		//trace("(Tempo.tick): " + contador + "/" + frameLap)
		//trace(" enPausa: "+ enPausa)
		if (!enPausa) {
			if (contador == frameLap) {
				contador = 0
				ciclos++
				tack()
			}else {
				contador++
			}
		}
	}
	private function tack() {
		//trace("(Tempo.tack) ------------")
		
		var obj:Object = new Object()
		obj.type = "onTempo"
		obj.frames = contador
		obj.contador = ciclos
		emisor.emitir_objeto(obj)
		contador++
	}
	
	//-------------------
	// EVENTOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onTempo", ref);
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