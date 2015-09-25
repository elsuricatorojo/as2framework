/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20060906
*/
class com.ionewmedia.utils.timers.Pulsar {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var dondeCallBack:Object;
	private var funcCallBack:String;
	private var secs:Number;
	private var interval:Number;
	//--------------------
	// CONSTRUCTORA:
	function Pulsar(d:Object, f:String, s:Number) {
		trace("(Pulsar.CONSTRUCTORA): "+s);
		dondeCallBack = d;
		funcCallBack = f;
		secs = s;
		//--
		init();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function parar() {
		trace("(Pulsar.parar)!");
		clearInterval(interval);
	}
	public function continuar(s:Number) {
		trace("(Pulsar.continuar)!");
		// NUEVO 20061204
		if (s != undefined && s != null) {
			parar()
			secs = s;
		}
		init();
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init() {
		var milisecs = secs*1000;
		interval = setInterval(pulso, milisecs, this);
	}
	private function pulso(donde:Pulsar) {
		//trace("(Pulsar.pulso)!");
		donde.hacer_callBack();
	}
	private function hacer_callBack() {
		//trace("(Pulsar.hacer_callBack)!");
		//trace("   dondeCallBack: "+dondeCallBack);
		//trace("   funcCallBack: "+funcCallBack);
		dondeCallBack[funcCallBack]();
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
