/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070525
*/
import com.ionewmedia.utils.estaticas.Boolean2
//--
class com.ionewmedia.utils.estaticas.Random2 {
	static function rnd_segmento(p1:Number, p2:Number):Number {
		// Dado un segmento p1-p2 devuelve un valor aleatorio perteneciente a ese segmento
		var rango:Number = p2-p1;
		var dado:Number = Math.random();
		var resultado:Number = p1+(dado*rango);
		return (resultado);
	}
	static function rnd_modificador(valor:Number, mod:Number):Number {
		// Dado un valor y modificador (0->1) devuelve un valor aleatorio entre..
		// el valor-(valor*mod) y valor+(valor*mod)
		var margen:Number = valor*mod;
		var p1:Number = valor-margen;
		var p2:Number = valor+margen;
		var rango:Number = p2-p1;
		var dado:Number = Math.random();
		var resultado:Number = p1+(dado*rango);
		return (resultado);
	}
	static function rnd_modificadorLow(valor:Number, mod:Number):Number {
		// Dado un valor y modificador (0->1) devuelve un valor aleatorio entre..
		// el valor-(valor*mod) y valor
		var margen:Number = valor*mod;
		var p1:Number = valor-margen;
		var p2:Number = valor;
		var rango:Number = p2-p1;
		var dado:Number = Math.random();
		var resultado:Number = p1+(dado*rango);
		return (resultado);
	}
	static function rnd_modificadorHigh(valor:Number, mod:Number):Number {
		// Dado un valor y modificador (0->1) devuelve un valor aleatorio entre..
		// el valor y  el valor+(valor*mod)
		var margen:Number = valor*mod;
		var p1:Number = valor;
		var p2:Number = valor+margen;
		var rango:Number = p2-p1;
		var dado:Number = Math.random();
		var resultado:Number = p1+(dado*rango);
		return (resultado);
	}
	static function dado(caras:Number) {
		// Simula una tirada de 1 dado de tantas caras como el parametro "caras"
		var resultado:Number = Math.ceil(Math.random()*caras);
		return (resultado);
	}
	//--
	static function rnd_baseModificada(base:Number, mod:Number):Number {
		// base:Number - Valor entre 0->1
		// mod:Numbre - Valor entre 0->1
		// Dado un valor base de 0 a 1 y un modificador de 0 a 1..
		// ... se hace un random de rnd*mod y se lo suma o resta a la base...
		// ... limitando el minimo a 0 y el maximo a 1.
		var positivo:Boolean = Boolean2.get_randomBoolean();
		var incremento:Number = mod * Math.random();
		if (!positivo) {
			incremento = -incremento;
		}
		var resultado:Number = base + incremento;
		if (resultado < 0) {
			resultado=0
		} else if (resultado > 1) {
			resultado=1
		}
		return resultado
	}
}
