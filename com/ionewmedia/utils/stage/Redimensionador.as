/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061018
*/
class com.ionewmedia.utils.stage.Redimensionador {
	//--------------------
	// DOCUMENTACION:
	// Pasado una instancia de MovieClip como parametro, la clase se encarga de escalarlo
	// IMPORTANTE: Necesita los tween de Zeh Fernando (o los de Zigo).
	//--------------------
	// PARAMETROS:
	var donde_mc:MovieClip;
	var ancho:Number;
	var alto:Number;
	var xScale:Number;
	var yScale:Number;
	var segundos:Number;
	var tipoAnim:String;
	//--
	private var stageListener:Object;
	//--------------------
	// CONSTRUCTORA:
	function Redimensionador(dmc:MovieClip, an:Number, al:Number, xs:Number, ys:Number, sec:Number, ease:String) {
		// (donde_mc, ancho, alto, scalaX, scalaY, segundos, tipoAnim)
		trace("(Redimensionador.CONSTRUCTORA): "+dmc._name);
		donde_mc = dmc;
		ancho = an;
		alto = al;
		xScale = xs;
		if (xScale == undefined || xScale == null) {
			xScale = 100;
		}
		yScale = ys;
		if (yScale == undefined || yScale == null) {
			yScale = 100;
		}
		segundos = sec;
		if (segundos == undefined || segundos == null) {
			segundos = 0;
		}
		tipoAnim = ease;
		if (tipoAnim == undefined || tipoAnim == null) {
			tipoAnim = "easeOutQuad";
		}
		//--            
		crear_StageListeners();
		ejecutarSinAnim();
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	private function crear_StageListeners() {
		var donde = this;
		stageListener = new Object();
		stageListener.onResize = function() {
			donde.ejecutar();
		};
		Stage.addListener(stageListener);
	}
	private function ejecutarSinAnim() {
		var ancho_calc = Stage.width*(xScale/100);
		var alto_calc = Stage.height*(yScale/100);
		var ancho_final = ancho*(ancho_calc/ancho);
		var alto_final = alto*(alto_calc/alto);
		//--
		donde_mc._width = ancho_final;
		donde_mc._height = alto_final;
	}
	private function ejecutarConAnim() {
		var ancho_calc = Stage.width*(xScale/100);
		var alto_calc = Stage.height*(yScale/100);
		var ancho_final = ancho*(ancho_calc/ancho);
		var alto_final = alto*(alto_calc/alto);
		//--
		donde_mc.stopTween("_width", "_height");
		donde_mc.tween("_width", ancho_final, segundos, tipoAnim);
		donde_mc.tween("_height", alto_final, segundos, tipoAnim);
	}
	private function ejecutar() {
		//trace("(Redimensionador.ejecutar): "+donde_mc._name);
		if (segundos == 0) {
			ejecutarSinAnim();
		} else {
			ejecutarConAnim();
		}
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
