/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/

IMPORTANTE:
Los 9 slices deben incluir "_slice.as" que se encuentra en esta carpeta.
Las practica habitual es copiar "_slice.as" al classspath del proyecto "./as" normalmente e
incluirlo mediante "#include "as/_slice.as"
Todo esto es debido a que utiliza metodos de tween (de Laco o de Zeh Fernando) y por lo tanto
no nativos de la clase MovieClip, y da error de compilación.
*/
import com.ionewmedia.utils.eventos.gestoreventos.GestorEventos;
class com.ionewmedia.utils.movieclip.slice9.AreaEscalable extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var emisor:GestorEventos;
	var cuad:Number;
	var ancho:Number;
	var alto:Number;
	var segundos:Number;
	var easeType:String;
	//Mcs Anidados:
	var slice1:MovieClip;
	var slice2:MovieClip;
	var slice3:MovieClip;
	var slice4:MovieClip;
	var slice5:MovieClip;
	var slice6:MovieClip;
	var slice7:MovieClip;
	var slice8:MovieClip;
	var slice9:MovieClip;
	//--------------------
	// CONSTRUCTORA:
	function AreaEscalable() {
		trace("(AreaEscalable.CONSTRUCTORA2)!");
		init_emisor();
	}
	function init(an:Number, al:Number, c:Number, s:Number, eT:String) {
		trace("(AreaEscalable.init)!");
		ancho = an;
		alto = al;
		cuad = c;
		segundos = s;
		easeType = eT;
		//--
		set_dimensiones(ancho, alto);
	}
	public function testScope(txt:String) {
		trace("(AreaEscalable.testScope) ------------- "+txt);
		return true
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_dimensiones(an:Number, al:Number) {
		trace("(AreaEscalable.set_dimensiones)!");
		ancho = an;
		alto = al;
		//----
		var objData = get_objData();
		//----
		var objEvento = new Object();
		objEvento.type = "onReposicionar";
		objEvento.ancho = ancho;
		objEvento.alto = alto;
		objEvento.cuad = cuad;
		objEvento.segundos = segundos;
		objEvento.easeType = easeType;
		objEvento.objData = objData;
		emisor.emitir_objeto(objEvento);
	}
	public function redimensionar(an:Number, al:Number, pausa:Number) {
		trace("(AreaEscalable.redimensionar): "+an+", "+al+", "+pausa);
		ancho = an;
		alto = al;
		//---
		if (pausa == undefined) {
			pausa=0
		}
		//----
		var objData = get_objData();
		//----
		var objEvento = new Object();
		objEvento.type = "onRedimensionar";
		objEvento.ancho = ancho;
		objEvento.alto = alto;
		objEvento.cuad = cuad;
		objEvento.segundos = segundos;
		objEvento.easeType = easeType;
		objEvento.objData = objData;
		objEvento.pausa = pausa;
		emisor.emitir_objeto(objEvento);
	}
	//--------------------
	// METODOS PRIVADOS:
	private function get_objData():Object {
		var obj = new Object();
		var array_x = new Array();
		var array_y = new Array();
		var array_width = new Array();
		var array_height = new Array();
		//: _x
		array_x[0] = null;
		array_x[1] = null;
		array_x[2] = null;
		array_x[3] = ancho-(cuad*1);
		array_x[4] = ancho-(cuad*1);
		array_x[5] = ancho-(cuad*1);
		array_x[6] = null;
		array_x[7] = null;
		array_x[8] = null;
		array_x[9] = null;
		//: _y
		array_y[0] = null;
		array_y[1] = null;
		array_y[2] = null;
		array_y[3] = null;
		array_y[4] = null;
		array_y[5] = alto-(cuad*1);
		array_y[6] = alto-(cuad*1);
		array_y[7] = alto-(cuad*1);
		array_y[8] = null;
		array_y[9] = null;
		//: _widht
		array_width[0] = null;
		array_width[1] = null;
		array_width[2] = ancho-(cuad*2);
		array_width[3] = null;
		array_width[4] = null;
		array_width[5] = null;
		array_width[6] = ancho-(cuad*2);
		array_width[7] = null;
		array_width[8] = null;
		array_width[9] = ancho-(cuad*2);
		//: _widht
		array_height[0] = null;
		array_height[1] = null;
		array_height[2] = null;
		array_height[3] = null;
		array_height[4] = alto-(cuad*2);
		array_height[5] = null;
		array_height[6] = null;
		array_height[7] = null;
		array_height[8] = alto-(cuad*2);
		array_height[9] = alto-(cuad*2);
		//--
		obj.array_x = array_x;
		obj.array_y = array_y;
		obj.array_width = array_width;
		obj.array_height = array_height;
		return obj;
	}
	public function notify_slice(mc:MovieClip, sliceId:Number) {
		//trace("(AreaEscalable.notify_slice)!");
		var obj = get_objData();
		mc.reposicionar(obj);
	}
	public function addEventListener(evento:String, donde:Object):Void {
		emisor.registrar(evento, donde);
	}
	//--------------------
	// EMISOR:
	private function init_emisor() {
		emisor = new GestorEventos();
		emisor.registrar("onReposicionar", slice1);
		emisor.registrar("onRedimensionar", slice1);
		emisor.registrar("onReposicionar", slice2);
		emisor.registrar("onRedimensionar", slice2);
		emisor.registrar("onReposicionar", slice3);
		emisor.registrar("onRedimensionar", slice3);
		emisor.registrar("onReposicionar", slice4);
		emisor.registrar("onRedimensionar", slice4);
		emisor.registrar("onReposicionar", slice5);
		emisor.registrar("onRedimensionar", slice5);
		emisor.registrar("onReposicionar", slice6);
		emisor.registrar("onRedimensionar", slice6);
		emisor.registrar("onReposicionar", slice7);
		emisor.registrar("onRedimensionar", slice7);
		emisor.registrar("onReposicionar", slice8);
		emisor.registrar("onRedimensionar", slice8);
		emisor.registrar("onReposicionar", slice9);
		emisor.registrar("onRedimensionar", slice9);
	}
	//--------------------
	// SNIPPETS:
}
