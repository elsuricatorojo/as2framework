/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061018
*/
class com.ionewmedia.utils.stage.Alineador_DerAbajo {
	//--------------------
	// DOCUMENTACION:
	// Pasado una instancia de MovieClip como parametro, la clase se encarga de alinearlo abajo a la izquierda
	// Si los parametros ancho y alto son Null alinea su 0,0
	// IMPORTANTE: Necesita los tween de Zeh Fernando (o los de Zigo).
	//--------------------
	// PARAMETROS:
	var donde_mc:MovieClip;
	var ancho:Number;
	var alto:Number;
	var segundos:Number;
	var tipoAnim:String;
	// NUEVO 20080222-----
	private var mostrarInicioSiempre:Boolean = false;
	private var limiteMinimoX:Number = null;
	private var limiteMinimoY:Number = null;
	//--
	private var stageListener:Object;
	//--------------------
	// CONSTRUCTORA:
	function Alineador_DerAbajo(dmc:MovieClip, an:Number, al:Number, sec:Number, ease:String) {
		// (donde_mc, ancho, alto, segundos, tipoAnim, aling)
		trace("(Alineador_DerAbajo.CONSTRUCTORA): " + dmc._name);
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
		//--
		if (ancho == null || ancho == undefined) {
			ancho=0
		}
		if (alto == null || alto == undefined) {
			alto=0
		}
		//--                   
		crear_StageListeners();
		ejecutarSinAnim();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_limiteMinimos(minX:Number, minY:Number) {
		limiteMinimoX = minX;
		limiteMinimoY = minY;
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
		var arrayPos:Array = get_arrayPos();
		donde_mc._x = arrayPos[0];
		donde_mc._y = arrayPos[1];
	}
	private function ejecutarConAnim() {
		var arrayPos:Array = get_arrayPos();
		//trace(arrayPos);
		donde_mc.stopTween("_x","_y");
		donde_mc.slideTo(arrayPos[0],arrayPos[1],segundos,tipoAnim);
	}
	private function ejecutar() {
		//trace("(Alineador_DerAbajo.ejecutar): "+donde_mc._name);
		if (segundos == 0) {
			ejecutarSinAnim();
		} else {
			ejecutarConAnim();
		}
	}
	public function get_arrayPos():Array {
		// Devuelve un array con las pos x,y de la posición centrada de World respecto al Stage
		var arrayPos:Array = new Array();
		var anchoStage = Stage.width;
		var altoStage = Stage.height;
		var nuevaPosX:Number = Math.round((anchoStage) - (ancho/2));
		//var nuevaPosX:Number = 0 + (ancho/2);
		var nuevaPosY = Math.round((altoStage) - (alto/2));
		//-----
		if (limiteMinimoX != null) {
			if (nuevaPosX < limiteMinimoX) {
				nuevaPosX = limiteMinimoX;
			}
		}
		if (limiteMinimoY != null) {
			if (nuevaPosY < limiteMinimoY) {
				nuevaPosY = limiteMinimoY;
			}
		}
		//--------------------   
		arrayPos.push(nuevaPosX);
		arrayPos.push(nuevaPosY);
		//trace("   arrayPos: "+donde_mc+" -->"+arrayPos);
		return arrayPos;
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}