import com.ionewmedia.utils.estaticas.String2;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.estaticas.Number2;
/*
DOCUMENTACION:
- validar_texto(txt:String):Boolean
     		Evalua si la cadena pasada es un String con contenido (length>0)
- validar_textoSeguro(txt:String):Boolean
     Evalua si la cadena pasada está formada por carateres seguros definido por el array "arraySeguros"
- validar_email(txt:String):Boolean
     Evalua si la cadena pasada es un email valido.
- validar_numero(valor:Number, min:Number, max:Number):Boolean 
     Dado un valor determina si es un valor numerico valido.
     Si se pasan valores de minimo y maximo evalua tambien si está en tramo intermedio
*
* io newmedia S.L. - http://www.zona-io.com  || 
* roberto@zona-io.com		(Roberto Ferrero)
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/	
*/
class com.ionewmedia.utils.estaticas.Form2 {
	//-------------------------------------
	// METODOS STATICOS:
	static function validar_texto(txt:String):Boolean {
		// Evalua si la cadena pasada es un String con contenido (length>0)
		if (txt.length>0) {
			return true;
		} else {
			return false;
		}
	}
	static function validar_textoMinimo(txt:String, min:Number):Boolean {
		// Evalua si la cadena pasada es un String con una longitud igual o superior al minimo
		if (txt.length>=min) {
			return true;
		} else {
			return false;
		}
	}
	static function validar_texto6(txt:String):Boolean {
		// Evalua si la cadena pasada es un String con una longitud igual o superior 6
		return validar_textoMinimo(txt, 6);
	}
	static function validar_texto3(txt:String):Boolean {
		// Evalua si la cadena pasada es un String con una longitud igual o superior 3
		return validar_textoMinimo(txt, 3);
	}
	static function validar_textoSeguro(txt:String):Boolean {
		// Devuelve si el valor pasado corresponde a una cadena
		txt=txt.toLowerCase()
		var arraySeguros:Array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "_", "-"];
		var valido:Boolean = String2.evalCaracteresValidos(txt, arraySeguros);
		return valido;
	}
	static function validar_email(txt:String):Boolean {
		return String2.validarMail(txt);
	}
	static function validar_numero(valor:Number, min:Number, max:Number):Boolean {
		// Dado un valor determina si es un valor numerico valido.
		// Si se pasan valores de minimo y maximo evalua tambien si está en tramo intermedio
		if (min == null || min == undefined) {
			min = Number.NEGATIVE_INFINITY;
		}
		if (max == null || max == undefined) {
			max = Number.POSITIVE_INFINITY;
		}
		valor = Number(valor);
		if (isNaN(valor)) {
			return false;
		} else {
			if (valor>=min && valor<=max) {
				return true;
			} else {
				return false;
			}
		}
	}
	static function validar_dia(valor:Number):Boolean {
		// Evalua si el valor pasado corresponde a un día
		valor = Number(valor);
		var entero:Boolean = Number2.valorEntero(valor);
		var valido:Boolean = validar_numero(valor, 1, 31);
		if (entero && valido) {
			return true;
		} else {
			return false;
		}
	}
	static function validar_mesNumerico(valor:Number):Boolean {
		// Evalua si el valor pasado corresponde a un mes (en número)
		valor = Number(valor);
		var entero:Boolean = Number2.valorEntero(valor);
		var valido:Boolean = validar_numero(valor, 1, 12);
		if (entero && valido) {
			return true;
		} else {
			return false;
		}
	}
	static function validar_mesCadena(valor:String):Boolean {
		// Evalua si la cadena pasada es un mes en castellano.
		var arrayMeses:Array = ["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "setiembre", "octubre", "noviembre", "diciembre"];
		var valor2:String = valor.toLowerCase();
		var valido:Boolean = false;
		for (var i = 0; i<arrayMeses.length; i++) {
			var mes:String = arrayMeses[i];
			if (valor2 == mes) {
				valido = true;
			}
		}
		return valido;
	}
	static function validar_dni(valor):Boolean {
		// Evalua si la cadena pasada es un DNI válido.
		valor = Number(valor);
		var valido = validar_numero(valor, 0, 99999999);
		return valido;
	}
	static function validar_nif(valor:String):Boolean {
		// Evalua si la cadena pasad corresponde a un NIF valido. Pare ello valida la parte
		// numerica con validar_dni() y comprueba que la letra es la correcta.
		valor = valor.split(" ").join("");
		valor = valor.split("-").join("");
		valor = valor.split("_").join("");
		var arrayNum = new Array();
		var arrayLetra = new Array();
		for (var i = 0; i<valor.length; i++) {
			var char:String = valor.charAt(i);
			if (isNaN(Number(char))) {
				arrayLetra.push(char);
			} else {
				arrayNum.push(char);
			}
		}
		var dni:Number = Number(arrayNum.join(""));
		var dniValido:Boolean = validar_dni(dni);
		var letra:String = String(arrayLetra.join(""));
		var letraCalculada:String = Number2.letraNif(dni);
		var letraValida:Boolean = false;
		if (letra == letraCalculada) {
			letraValida = true;
		}
		if (dniValido && letraValida) {
			return true;
		} else {
			return false;
		}
	}
	static function validar_letranif(valor:String):Boolean {
		// Evalua si el valor pasado corresponde a una letra de nif (no lo son todas las letras, solo: TRWAGMYFPDXBNJZSQVHLCKE)
		valor = valor.toUpperCase();
		if (valor.length == 1) {
			var letras = "TRWAGMYFPDXBNJZSQVHLCKE";
			var aux:Array = letras.split(valor);
			if (aux.length == 2) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}
