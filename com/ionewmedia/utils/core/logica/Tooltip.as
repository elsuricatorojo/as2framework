/*
DOCUMENTACION:
* Roberto Ferrero - hola@robertoferrero.es
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 27/06/2013 18:44
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.core.logica.Tooltip {
	// import com.ionewmedia.utils.core.logica.Tooltip
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private static var inst:Tooltip;
	private static var count:Number = 0;
	//--
	private var emisor:EmisorExtendido;
	private var contadorIds:Number = 0
	//--
	public var anchoStage:Number = 800
	public var altoStage:Number = 600
	//--------------------
	// CONSTRUCTORA:
	public function Tooltip() {
		trace("(Tooltip.CONSTRUCTORA)!")
		emisor = new EmisorExtendido()
		
	}
	public static function getInstance ():Tooltip{
		if (inst == null)	{
			inst = new Tooltip ();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function mostrarTooltip(texto:String, pausaMil:Number):Void {
		
		if (pausaMil == null || pausaMil == undefined) {
			pausaMil = 0
		}
		trace("(Tooltip.mostrarTooltip): "+pausaMil)
		contadorIds++
		var obj:Object = new Object()
		obj.type = "onMostrarTooltip"
		obj.texto = texto
		obj.pausaMil = pausaMil
		obj.id = contadorIds
		emisor.emitir_objeto(obj)
	}
	public function ocultarTooltip() {
		emisor.emitir("onOcultarTooltip")
	}
	// Getters:
	// Setters:
	public function setStage(ancho:Number, alto:Number) {
		anchoStage = ancho
		altoStage = alto
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	
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
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}