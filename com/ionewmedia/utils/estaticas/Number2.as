/*
DOCUMENTACION:
- valorEntero(valor:Number):Boolean
     Evalua si el valor pasado es entero o tiene decimales.
- valorPar(valor:Number):Boolean
     Evalua si el valor pasado es entero y par.
- valorPrimo(valor:Number):Boolean 
     Evalua si el numero es primo (el 1 lo considera primo)
- limitarDecimales(valor:Number, numDecimales:Number):Number
	 Dado un valor debuelve otro con un redondeo al numero de decimales que se le indique
*
* io newmedia S.L. - http://www.zona-io.com  
* roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
class com.ionewmedia.utils.estaticas.Number2 {
	static function valorEntero(valor:Number):Boolean {
		// Evalua si el valor pasado es entero o tiene decimales.
		if (Math.round(valor) == valor) {
			return true;
		} else {
			return false;
		}
	}
	static function valorPar(valor:Number):Boolean {
		// Evalua si el valor pasado es entero y par.
		if (valorEntero(valor)) {
			var mitad:Number = valor/2;
			if (Math.round(mitad) == mitad) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	static function valorPrimo(valor:Number):Boolean {
		// Evalua si el numero es primo (el 1 lo considera primo)
		var positivo:Boolean = true;
		var entero:Boolean = valorEntero(valor);
		var divisible:Boolean;
		if (valor<0) {
			positivo = false;
		}
		for (var i = 2; i<valor; i++) {
			var resultado = valor/i;
			var resEntero:Boolean = valorEntero(resultado);
			if (resEntero == true) {
				divisible = true;
			}
		}
		if (positivo && entero && !divisible) {
			return true;
		} else {
			return false;
		}
	}
	static function letraNif(valor):String {
		//TRWAGMYFPDXBNJZSQVHLCKET
		var arrayLetras:Array = ["T", "R", "W", "A", "G", "M", "Y", "F", "P", "D", "X", "B", "N", "J", "Z", "S", "Q", "V", "H", "L", "C", "K", "E", "T"];
		valor = Number(valor);
		var modulo:Number = valor%23;
		return arrayLetras[modulo];
	}
	static function limitarDecimales(valor:Number, numDecimales:Number):Number {
		var potencia:Number = Math.pow(10, numDecimales);
		var resultado = (Math.round(valor*potencia))/potencia;
		return (resultado);
	}
	static function limitarDecimalesFloor(valor:Number, numDecimales:Number):Number {
		var potencia:Number = Math.pow(10, numDecimales);
		var resultado = (Math.floor(valor*potencia))/potencia;
		return (resultado);
	}
	static function limitarDecimalesCeil(valor:Number, numDecimales:Number):Number {
		var potencia:Number = Math.pow(10, numDecimales);
		var resultado = (Math.ceil(valor*potencia))/potencia;
		return (resultado);
	}
	static function interpolar (valor1:Number, valor2:Number, factor:Number):Number {
		var resultado:Number =valor1+((valor2-valor1)*factor)
		return resultado
}
}