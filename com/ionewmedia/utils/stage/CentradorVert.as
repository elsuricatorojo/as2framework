/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061018
*/
class com.ionewmedia.utils.stage.CentradorVert {
	//--------------------
	// DOCUMENTACION:
	// Pasado una instancia de MovieClip como parametro, la clase se encarga de centrarlo VERTICALMENTE sobre el stage.
	// IMPORTANTE: Necesita los tween de Zeh Fernando (o los de Zigo).
	//--------------------
	// PARAMETROS:
	var donde_mc:MovieClip;
	var alto:Number;
	var segundos:Number;
	var tipoAnim:String;
	var limiteMinimoY:Number = null
	// Valores: izq, centro
	var alineo:String;
	//--
	private var stageListener:Object;
	//--------------------
	// CONSTRUCTORA:
	function CentradorVert(dmc:MovieClip, al:Number, sec:Number, ease:String, ali:String) {
		// (donde_mc, alto, segundos, tipoAnim, aling)
		trace("(CentradorVert.CONSTRUCTORA): "+dmc._name);
		donde_mc = dmc;
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
			alineo = "top";
		}
		//--                
		crear_StageListeners();
		ejecutarSinAnim();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_limitesMinimos(minY:Number) {
		// NUEVO: 02/03/2011 19:29
		limiteMinimoY = minY;
		ejecutar()
	}
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
		var arrayCentrado:Array = get_arrayCentrado();
		donde_mc._y = arrayCentrado[1];
	}
	private function ejecutarConAnim() {
		var arrayCentrado:Array = get_arrayCentrado();
		donde_mc.stopTween("_y");
		donde_mc.tween("_y", arrayCentrado[1], segundos, tipoAnim);
	}
	private function ejecutar() {
		//trace("(CentradorVert.ejecutar): "+donde_mc._name);
		if (segundos == 0) {
			ejecutarSinAnim();
		} else {
			ejecutarConAnim();
		}
	}
	private function get_arrayCentrado():Array {
		// Devuelve un array con las pos x,y de la posición centrada de World respecto al Stage
		var arrayCentrado:Array = new Array();
		var altoStage = Stage.height;
		arrayCentrado.push(null);
		var nuevaPosY:Number
		if (alineo == "top") {
			 nuevaPosY = Math.round((altoStage/2)-(alto/2));
			//arrayCentrado.push(nuevaPosY);
		} else {
			nuevaPosY = Math.round((altoStage/2));
			//arrayCentrado.push(nuevaPosY);
		}
		//trace("   limiteMinimoY: "+limiteMinimoY)
		//trace("   nuevaPosY: "+nuevaPosY)
		if (limiteMinimoY != null) {
			
			if (nuevaPosY < limiteMinimoY) {
				//trace("*")
				nuevaPosY = limiteMinimoY;
			}
		}
		arrayCentrado.push(nuevaPosY);
		return arrayCentrado;
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
