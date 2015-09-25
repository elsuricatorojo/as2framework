/*
DOCUMENTACION:
- validarMail(cadena:String):Boolean
   Dada una cadena devuelve true/false dependiendo de si es un mail valido o no.
- evalCaracteresValidos(txtOriginal:String, array_validos:Array):Boolean {
   Devuelve true/false si el text pasado está compuesto de chars validos
   Si no se define "array_validos" se tomará este array:
   ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "_", "-"]
- get_directorioUrl(cadena:String):String {
   Dada una URL como: http://www.zona-io.com/visor/2005/010Ronda/index.html
   devuelve el directorio que contiene el archivo (http://www.zona-io.com/visor/2005/010Ronda/)
- quitarAcentos(cadena:String):String {
   NUEVO 20060907
   Dada una cadena pasa sus vocales con acentos a vocales normales.
- recortarEntradilla(cadena:String, max:Number):String
   NUEVO 20060928
   Dada una cadena devuelve otra de extensión similar a 'max' (+3 chars como max),
   y a la cual, si ha sido cortada, se le añade "..."
- soloNumeros(cadena:String):String
	NUEVO: 20061011
	Dada una cadena alphanumerica, devuelve otra igual pero solo con aquellso caracteres numericos
	Ej.: "A5B67" ---> "567"
- filtrarURLSafe(cadena:String):String {
    NUEVO: 20070208
    Dada una cadena devuelve otra donde se sustituyen:
- ejecutarString(cadena:String, mcRef:MovieClip):Void
    NUEVO: 20080205
    Dado un string tipo "_level0.world.miFuncion('param1')" lo ejecuta como si fuera un comando de código.
    Solo permite hasta 3 parametros tipo String
    la ruta debería ser absoluta.
- contieneCadena(cadenaBase:String, cadenaEvaluar:String, sensibleMayusculas:Boolean):Boolean
	NUEVO: 05/06/2008
	Dada una cadenaBase y cadenaEvaluar evalua si la cadenaEvaluar existe dentro de cadenaBase
- get_randomString(longitud:Number):String {
	// NUEVO: 03/09/2008 17:00
	Devuelve una cadena de n elementos al azar de entre el array charsValidos
*
* io newmedia S.L. - http://www.zona-io.com  
* roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
class com.ionewmedia.utils.estaticas.String2 {
	static function validarMail(xES:String):Boolean {
		// Dada una cadena devuelve true/false dependiendo de si es un mail valido o no.
		xES = xES.toLowerCase();
		var xVE:Boolean = true;
		var xA:Number = xES.indexOf("@");
		var xB:String = xES.substring(0, xA);
		var xD:Number = xES.length-1;
		var xE:Number = xES.lastIndexOf(".");
		var xC:String = xES.substring(xA+1, xE);
		var xF:Number = (xD)-(xE+1);
		var xCheckSUVC = function (xESS) {
			var xV:Boolean = true;
			var xUC:Array = new Array("!", "£", "$", "%", "^", "&", "*", "+", "=", "?", ":", ";", "'", "	", " ", '"', "~", "#", "/");
			for (var i = 0; i<=xUC.length-1; i++) {
				if (xESS.indexOf(xUC[i], 0) != -1) {
					xV = false;
					break;
				}
			}
			return xV;
		};
		//--
		if (xA == -1) {
			xVE = false;
		}
		if (xA != xES.lastIndexOf("@")) {
			xVE = false;
		}
		if (xCheckSUVC(xB) != true) {
			xVE = false;
		}
		if (xB.length<1) {
			xVE = false;
		}
		if (xCheckSUVC(xC) != true) {
			xVE = false;
		}
		if (xC.length<2) {
			xVE = false;
		}
		if (xCheckSUVC(xES.substr(xE+1, xD)) != true) {
			xVE = false;
		}
		if (xF<1 || xF>3) {
			xVE = false;
		}
		return xVE;
	}
	static function evalCaracteresValidos(txtOriginal:String, array_validos:Array):Boolean {
		// Devuelve true/false si el text pasado está compuesto de chars validos
		trace("(evalCaracteresValidos)!");
		var valido:Boolean = true;
		var f_estaEnElArray = function (a1:Array, elem:Object) {
			// Devuelve true/false dependiendo de si un elemento está en el array
			var control:Boolean = false;
			for (var i = 0; i<a1.length; i++) {
				if (a1[i] == elem) {
					control = true;
				}
			}
			return control;
		};
		var charsValidos:Array;
		if (array_validos == null || array_validos == undefined) {
			charsValidos = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "_", "-"];
		} else {
			charsValidos = array_validos;
		}
		trace("   charsValidos: "+charsValidos);
		var arrayOriginal = txtOriginal.split("");
		for (var i = 0; i<arrayOriginal.length; i++) {
			var char = arrayOriginal[i];
			var esta = f_estaEnElArray(charsValidos, char);
			if (!esta) {
				trace("   '"+char+"'  NO ESTÁ!");
				valido = false;
			}
		}
		//trace("   arrayOriginal: "+arrayOriginal);
		return valido;
	}
	static function get_directorioUrl(cadena:String):String {
		// Dada una URL como: http://www.zona-io.com/visor/2005/010Ronda/index.html
		// devuelve el directorio que contiene el archivo: "http://www.zona-io.com/visor/2005/010Ronda/"
		// Añadido el 20060822_1300
		var arrayCadena = cadena.split("/");
		arrayCadena.reverse();
		arrayCadena.shift();
		arrayCadena.reverse();
		var directorio = arrayCadena.join("/");
		if (directorio.length>0) {
			directorio += "/";
		}
		return directorio;
	}
	static function quitarAcentos(cadena:String):String {
		// NUEVO 20060907
		// MODIFICADO: 07/07/2009 10:08 añadiendo mayusculas
		// Dada una cadena pasa sus vocales con acentos a vocales normales.
		cadena = cadena.split("á").join("a");
		cadena = cadena.split("é").join("e");
		cadena = cadena.split("í").join("i");
		cadena = cadena.split("ó").join("o");
		cadena = cadena.split("ú").join("u");
		cadena = cadena.split("Á").join("a");
		cadena = cadena.split("É").join("e");
		cadena = cadena.split("Í").join("i");
		cadena = cadena.split("Ó").join("o");
		cadena = cadena.split("Ú").join("u");
		return cadena;
	}
	static function recortarEntradilla(cadena:String, max:Number):String {
		// NUEVO 20060928
		// Dada una cadena devuelve otra de extensión similar a 'max' (+3 chars como max),
		// y a la cual, si ha sido cortada, se le añade "..."
		var array_cadena:Array = cadena.split(" ");
		var array_resultado:Array = new Array();
		var contador:Number = 0;
		var pos:Number = 0;
		for (var i = 0; i<array_cadena.length; i++) {
			var temp:String = array_cadena[i];
			if ((contador+temp.length)<max) {
				array_resultado.push(temp);
				contador = contador+temp.length+1;
			}
		}
		var resultado:String
		if (array_cadena.length == array_resultado.length) {
			 resultado = array_cadena.join(" ");
		} else {
			 resultado = array_resultado.join(" ")+"...";
		}
		return resultado;
	}
	static function soloNumeros(cadena:String):String {
		//NUEVO: 20061011
		//Dada una cadena alphanumerica, devuelve otra igual pero solo con aquellso caracteres numericos
		//Ej.: "A5B67" ---> "567"
		var array_cadena:Array = cadena.split("");
		var array_resultado:Array = new Array();
		var cadena_validos:String = "0123456789";
		for (var i = 0; i<array_cadena.length; i++) {
			var char=array_cadena[i]
			var array_aux:Array=cadena_validos.split(char)
			if(array_aux.length==2){
				array_resultado.push(char)
			}
		}
		var resultado=array_resultado.join("")
		return resultado
	}
	static function filtrarURLSafe(cadena:String):String {
		//NUEVO: 20070208
		// Dada una cadena devuelve otra donde se sustituyen:
		//   los "&" por " y "
		//   los "?" por ""
		cadena = cadena.split("&").join(" y ");
		cadena = cadena.split("?").join("");
		return cadena;
	}
	static function ejecutarString(cadena:String, ref:Object):Void {
		trace("(String2.ejecutarString): " + cadena +" / "+ref);
		var pathInstancia:Object = ref;
		var arrayGenealogico:Array = cadena.split(".");
		for (var i = 0; i < arrayGenealogico.length; i++) {
			var cadenaInstancia:String = arrayGenealogico[i];
			var esFuncion:Boolean = eval_esFuncion(cadenaInstancia);
			if (esFuncion) {
				var instanciaFuncion:String = get_instanciaFuncion(cadenaInstancia);
				var parametroFuncion:String = get_parametroFuncion(cadenaInstancia);
				var parametroFuncionTemp:String = parametroFuncion.split(" ").join("");
				parametroFuncionTemp = parametroFuncionTemp.split("'").join("");
				var arrayParametros:Array = parametroFuncionTemp.split(",");
				//--
				if (arrayParametros.length == 0) {
					pathInstancia[instanciaFuncion]();
				} else if (arrayParametros.length == 1) {
					pathInstancia[instanciaFuncion](arrayParametros[0]);
				} else if (arrayParametros.length == 2) {
					pathInstancia[instanciaFuncion](arrayParametros[0], arrayParametros[1]);
				} else if (arrayParametros.length == 3) {
					pathInstancia[instanciaFuncion](arrayParametros[0], arrayParametros[1], arrayParametros[2]);
				}
			} else {
				pathInstancia = pathInstancia[cadenaInstancia];
			}
		}
	}
	private static function eval_esFuncion(cadena:String):Boolean {
		//trace("(ROOT.eval_esFuncion): " + cadena);
		var esFuncion:Boolean;
		var cadenaFuncion:String = cadena.split("(").join("__parentesis__");
		cadenaFuncion = cadenaFuncion.split(")").join("__parentesis__");
		var arrayFuncion:Array = cadenaFuncion.split("__parentesis__");
		//trace("   cadenaFuncion: " + cadenaFuncion);
		//trace("   arrayFuncion: " + arrayFuncion);
		if (arrayFuncion.length > 1) {
			//trace("ES FUNCION!");
			esFuncion = true;
		} else {
			//trace("NO ES FUNCION!");
			esFuncion = false;
		}
		return esFuncion;
	}
	private static function get_instanciaFuncion(cadena:String):String {
		var cadenaFuncion:String = cadena.split("(").join("__parentesis__");
		cadenaFuncion = cadenaFuncion.split(")").join("__parentesis__");
		var arrayFuncion:Array = cadenaFuncion.split("__parentesis__");
		return (arrayFuncion[0]);
	}
	private static function get_parametroFuncion(cadena:String):String {
		var cadenaFuncion:String = cadena.split("(").join("__parentesis__");
		cadenaFuncion = cadenaFuncion.split(")").join("__parentesis__");
		cadenaFuncion = cadenaFuncion.split("__parentesis____parentesis__").join("");
		var arrayFuncion:Array = cadenaFuncion.split("__parentesis__");
		if (arrayFuncion.length > 1) {
			return (arrayFuncion[1]);
		} else {
			return ("");
		}
	}
	// NUEVO 05/06/2008 13:18
	static function contieneCadena(cadenaBase:String, cadenaEvaluar:String, sensibleMayusculas:Boolean):Boolean {
		var contiene:Boolean = false;
		if (sensibleMayusculas == undefined || sensibleMayusculas == null) {
			sensibleMayusculas = false;
		}
		if (!sensibleMayusculas) {
			cadenaBase = cadenaBase.toLowerCase();
			cadenaEvaluar = cadenaEvaluar.toLowerCase();
		}
		var arrayToken:Array = cadenaBase.split(cadenaEvaluar);
		if (arrayToken.length > 1) {
			contiene = true;
		}
		return (contiene);
	}
	// NUEVO 03/09/2008 16:59
	static function get_randomString(longitud:Number):String {
		// Devuelve una cadena de n elementos al azar de entre el array charsValidos
		// MODIFICACION: 06/08/2009 10:45 Se eliminan la ñ
		var cadena:String = "";
		var charsValidos:Array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
		if (longitud == undefined || longitud == null) {
			longitud = 5;
		}
		for (var i = 0; i < longitud; i++) {
			var dadoPos:Number=Math.round(Math.random()*(charsValidos.length-1))
			var letra:String=charsValidos[dadoPos]
			cadena=cadena+letra
		}
		return cadena
	}
	// NUEVO 12/07/2009 16:03
	static function filtrarUndefineds(cadena:String):String {
		if (cadena==undefined || cadena==null) {
			cadena = null
		}
		return cadena
	}
}
