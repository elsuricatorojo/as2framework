/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061018
*/
class com.ionewmedia.utils.stage.IntroPosicionador {
	//--------------------
	// DOCUMENTACION:
	// Pasado una instancia de MovieClip como parametro, la clase se encarga de no se salga de los limites.
	// IMPORTANTE: Necesita los tween de Zeh Fernando (o los de Zigo).
	//--------------------
	// PARAMETROS:
	var donde_mc:MovieClip;
	var ancho:Number;
	var alto:Number;
	var segundos:Number;
	var tipoAnim:String;
	// Valores: izq, centro
	var alineo:String;
	//--
	private var stageListener:Object;
	//--------------------
	// CONSTRUCTORA:
	function IntroPosicionador(dmc:MovieClip, an:Number, al:Number, sec:Number, ease:String, ali:String) {
		// (donde_mc, ancho, alto, segundos, tipoAnim, aling)
		trace("(IntroPosicionador.CONSTRUCTORA): "+dmc._name);
		donde_mc = dmc;
		ancho = an;
		alto = al;
		segundos = sec;
		if (segundos == undefined || segundos == null) {
			segundos = 0;
		}
		tipoAnim = ease;
		if (tipoAnim == undefined || tipoAnim == null) {
			tipoAnim = "easeOutQuad";
		}
		alineo = ali;
		if (alineo == undefined || alineo == null) {
			alineo = "izq";
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
		var arrayPosicion:Array = get_arrayPosicion();
		donde_mc._x = arrayPosicion[0];
		donde_mc._y = arrayPosicion[1];
	}
	private function ejecutarConAnim() {
		var arrayPosicion:Array = get_arrayPosicion();
		donde_mc.stopTween("_x", "_y");
		donde_mc.slideTo(arrayPosicion[0], arrayPosicion[1], segundos, tipoAnim);
	}
	private function ejecutar() {
		//trace("(IntroPosicionador.ejecutar): "+donde_mc._name);
		if (segundos == 0) {
			ejecutarSinAnim();
		} else {
			ejecutarConAnim();
		}
	}
	private function get_arrayPosicion():Array {
		// Devuelve un array con las pos x,y de la posición centrada de World respecto al Stage
		var arrayPosicion:Array = new Array();
		var anchoStage = Stage.width;
		var altoStage = Stage.height;
		//--
		if (alineo == "izq") {
			if (donde_mc._x+ancho>anchoStage) {
				arrayPosicion[0] = (anchoStage-ancho);
			} else {
				arrayPosicion[0] = donde_mc._x;
			}
			if (donde_mc._y+alto>altoStage) {
				arrayPosicion[1] = (altoStage-alto);
			} else {
				arrayPosicion[1] = donde_mc._y;
			}
		} else {
			if (donde_mc._x+(ancho/2)>anchoStage) {
				arrayPosicion[0] = (anchoStage-(ancho/2));
			} else {
				arrayPosicion[0] = donde_mc._x;
			}
			if (donde_mc._y+(alto/2)>altoStage) {
				arrayPosicion[1] = (altoStage-(alto/2));
			} else {
				arrayPosicion[1] = donde_mc._y;
			}
		}
		if (arrayPosicion[0]<0){
			arrayPosicion[0]=0
		}
		if (arrayPosicion[1]<0){
			arrayPosicion[1]=0
		}
		//--
		return arrayPosicion;
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
