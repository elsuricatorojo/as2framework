/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061005
*/
import com.ionewmedia.utils.eventos.gestoreventos.GestorEventos;
class com.ionewmedia.utils.media.video.ControladorVideo extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	// REQUIERE un componente_io '99 ControladorVideo'
	//--------------------
	// PARAMETROS:
	// MovieClips anidados:
	var btPlay;
	var progressBar;
	var btVolumen;
	var clip;
	//--
	var path:String;
	var duracion:Number;
	var array_notified:Array;
	var pausado:Boolean;
	var emisor:GestorEventos;
	var sonido:Sound;
	//--
	var netConn:NetConnection;
	var netStream:NetStream;
	//--------------------
	// CONSTRUCTORA:
	function ControladorVideo() {
		trace("(ControladorVideo.CONSTRUCTORA)!");
		pausado = false;
		sonido = new Sound();
		array_notified = new Array();
		init_emisor();
	}
	function init(p:String, d:Number) {
		trace("(ControladorVideo.init): "+p+", "+d);
		path = p;
		duracion = d;
		add_notified("init");
	}
	public function testScope(txt:String):Boolean {
		trace("(ControladorVideo.testScope)<-------- "+txt);
		return true;
	}
	//--------------------
	// NOTIFIES:
	public function notify_btPlay() {
		emisor.registrar("onPlay", btPlay);
		emisor.registrar("onStop", btPlay);
		add_notified("btPlay");
	}
	public function notify_progressBar() {
		emisor.registrar("onMonitorizar", progressBar);
		add_notified("progressBar");
	}
	public function notify_btVolumen() {
		emisor.registrar("onSetVolumen", btVolumen);
		setDefaultVolumen(75);
		add_notified("btVolumen");
	}
	public function notify_listener(donde:Object) {
		emisor.registrar("onMonitorizar", donde);
	}
	//--------------------
	// METODOS PUBLICOS DE BtPlay:
	function hacer_play() {
		trace("(ControladorVideo.hacer_play)!");
		if (pausado) {
			pausado = false;
			emisor.emitir_evento("onPlay");
			netStream.pause();
		}
	}
	function hacer_pause() {
		trace("(ControladorVideo.hacer_pause)!");
		if (!pausado) {
			pausado = true;
			emisor.emitir_evento("onStop");
			netStream.pause();
		}
	}
	//--------------------
	// METODOS PUBLICOS DE BtVolumen:
	function set_volumen(vol:Number) {
		trace("(ControladorVideo.set_volumen): "+vol);
		sonido.setVolume(vol);
	}
	//--------------------
	// METODOS PRIVADOS:
	private function setDefaultVolumen(vol:Number) {
		set_volumen(vol);
		var objEvento = new Object();
		objEvento.type = "onSetVolumen";
		objEvento.volumen = vol;
		emisor.emitir_objeto(objEvento);
	}
	private function add_notified(id:String) {
		trace("(ControladorVideo.add_notified): "+id);
		array_notified.push(id);
		if (array_notified.length == 4) {
			init_video();
		}
	}
	private function init_video() {
		trace("(ControladorVideo.init_video)!");
		var metaDuration:Number;
		var donde = this;
		netConn = new NetConnection();
		netConn.connect(null);
		netStream = new NetStream(netConn);
		clip.attachVideo(netStream);
		netStream.setBufferTime(5);
		netStream["onMetaData"] = function (infoObject:Object) {
			donde.metaDuration = infoObject.duration;
			// for (var propName in infoObject) {
			trace("   metaDuration (dentro funcion): "+donde.metaDuration);
		};
		//};
		netStream.play(path);
		trace("   metaDuration: "+metaDuration);
		if (metaDuration != undefined && metaDuration != null) {
			duracion = metaDuration;
		}
		trace("   duracion: "+duracion);
		//-- 
		//--
		var objEvento = new Object();
		objEvento.type = "onMonitorizar";
		objEvento.netStream = netStream;
		objEvento.duracion = duracion;
		emisor.emitir_objeto(objEvento);
	}
	//--------------------
	// EMISOR:
	function init_emisor() {
		emisor = new GestorEventos();
	}
	//--------------------
	// SNIPPETS:
}
