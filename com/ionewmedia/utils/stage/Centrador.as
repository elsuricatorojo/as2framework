/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061018
*/
class com.ionewmedia.utils.stage.Centrador {
	//--------------------
	// DOCUMENTACION:
	// Pasado una instancia de MovieClip como parametro, la clase se encarga de centrarlo sobre el stage.
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
	// NUEVO 20080222-----
	private var mostrarInicioSiempre:Boolean = false;
	private var limiteMinimoX:Number = null;
	private var limiteMinimoY:Number = null;
	private var activo:Boolean=true
	//--
	private var stageListener:Object;
	//--------------------
	// CONSTRUCTORA:
	function Centrador(dmc:MovieClip, an:Number, al:Number, sec:Number, ease:String, ali:String) {
		// (donde_mc, ancho, alto, segundos, tipoAnim, aling)
		trace("(Centrador.CONSTRUCTORA): " + dmc._name);
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
	// NUEVO 20080222-----
	public function set_limitesMinimos(minX:Number, minY:Number) {
		limiteMinimoX = minX;
		limiteMinimoY = minY;
		ejecutar()
	}
	// NUEVO: 23/06/2008 16:08
	public function desactivar() {
		activo=false
	}
	public function activar() {
		activo=true
	}
	// NUEVO: 03/03/2011 10:26 (pasado a publico)
	public function ejecutar() {
		//trace("(Centrador.ejecutar): "+donde_mc._name);
		if(activo){
			if (segundos == 0) {
				ejecutarSinAnim();
			} else {
				ejecutarConAnim();
			}
		}
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
		donde_mc._x = arrayCentrado[0];
		donde_mc._y = arrayCentrado[1];
	}
	private function ejecutarConAnim() {
		var arrayCentrado:Array = get_arrayCentrado();
		//trace(arrayCentrado);
		donde_mc.stopTween("_x","_y");
		donde_mc.slideTo(arrayCentrado[0],arrayCentrado[1],segundos,tipoAnim);
	}
	
	public function get_arrayCentrado():Array {
		// Devuelve un array con las pos x,y de la posición centrada de World respecto al Stage
		var arrayCentrado:Array = new Array();
		var anchoStage = Stage.width;
		var altoStage = Stage.height;
		if (alineo == "izq") {
			var nuevaPosX = Math.round((anchoStage / 2) - (ancho / 2));
			var nuevaPosY = Math.round((altoStage / 2) - (alto / 2));
		} else {
			var nuevaPosX = Math.round((anchoStage / 2));
			var nuevaPosY = Math.round((altoStage / 2));
		}
		// NUEVO 20080222-----
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
		arrayCentrado.push(nuevaPosX);
		arrayCentrado.push(nuevaPosY);
		//trace("   arrayCentrado: "+donde_mc+" -->"+arrayCentrado);
		return arrayCentrado;
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}