/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070109
*/
class com.ionewmedia.utils.numeros.Autonumerico2 {
	//--------------------
	// DOCUMENTACION:
	// Se acceso es estatico para casos donde no importe el valor autonum en si sino que sea distinto.
	// Devuelve un valor incrementado en 1 y por tanto unico al acceder al get()
	//--------------------
	// PARAMETROS:
	static var contador:Number = 0;
	//--------------------
	// CONSTRUCTORA:
	function Autonumerico2(inicio:Number) {
		//trace("(Autonumerico.CONSTRUCTORA)!");
		if (inicio != undefined || inicio != null) {
			contador = inicio;
		}
	}
	//--------------------
	// METODOS PUBLICOS:
	static public function get():Number {
		var valor = contador;
		contador++;
		return valor;
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
