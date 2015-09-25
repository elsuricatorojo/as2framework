/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20060906
*/
import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.timers.Pulsar2 {
	//--------------------
	// DOCUMENTACION:
	// NUEVO 20061204
	// Permite cambiar los segundo al continuar/renudar los pulsos.
	// NUEVO 20080306
	// Permite cambiar los segundos despues de la constructora.
	// NUEVO 20080404:
	// Al emitir el evento pasa la id suministrada en la constructora
	// Se peremetriza el nombre del evento a emitir siendo "onPulso" el por defecto para conservar retrocompatibilidad
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	private var secs:Number;
	private var interval:Number;
	// NUEVO 20080404
	private var pulsoId:String = null // Al emitir el evento pasa la id suministrada en la constructora
	private var nombreEvento:String = "onPulso" // Se peremetriza el nombre del evento a emitir siendo "onPulso" el por defecto para conservar retrocompatibilidad
	//--------------------
	// CONSTRUCTORA:
	function Pulsar2(s:Number, _nombreEvento:String, _pulsoId:String) {
		emisor = new EmisorExtendido();
		secs = s;
		if (_pulsoId != null && _pulsoId != undefined) {
			pulsoId=_pulsoId
		}
		if (_nombreEvento != null && _nombreEvento != undefined) {
			nombreEvento=_nombreEvento
		}
		trace("(Pulsar2.CONSTRUCTORA): "+secs+"  nombreEvento: "+nombreEvento+"  pulsoId: "+pulsoId);
		//--
		//init();
	}
	public function init() {
		//trace("(Pulsar2.init) secs:"+secs)
		var milisecs = secs * 1000;
		clearInterval(interval)
		interval = setInterval(pulso, milisecs, this);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function parar() {
		trace("(Pulsar2.parar)!");
		clearInterval(interval);
	}
	public function continuar(s:Number) {
		trace("(Pulsar2.continuar)!");
		// NUEVO 20061204
		if (s != undefined && s != null) {
			parar();
			secs = s;
		}
		init();
	}
	public function set_secs(_secs:Number):Void {
		// NUEVO 20080306
		secs=_secs
	}
	//--------------------
	// METODOS PRIVADOS:
	private function pulso(donde:Pulsar2) {
		//trace("(Pulsar2.pulso)!");
		donde.hacer_callBack();
	}
	private function hacer_callBack() {
		//trace("(Pulsar2.hacer_callBack): "+nombreEvento);
		var obj:Object = new Object()
		obj.type = nombreEvento
		obj.pulsoId = pulsoId
		obj.pulsarRef=this
		emisor.emitir_objeto(obj);
	}
	//--------------------
	// EmisorExtendido:
	public function addListener(ref:Object) {
		emisor.registrar(nombreEvento, ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// SNIPPETS:
}
