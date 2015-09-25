class com.ionewmedia.utils.textos.encriptacion.Enigma2
{
	//--------------------
	// DOCUMENTACION:
	// Creado el 01-06-2006 por Roberto Ferrero (roberto@zona-io.com)
	// La clase está diseñada para codificar y descodificar textos.
	// El tipo de codificación es por sustitución de unas cadenas por otras.
	// La relación entre los codigos y sus correspondientes cadenas descodificadas se..
	// ... establece en crear_codigos().
	//--------------------
	// PARAMETROS:
	private var codigos:Object;
	//--------------------
	// CONSTRUCTORA:
	function Enigma2(objCodigos:Object)
	{
		trace("(Enigma2.CONSTRUCTORA)!");
		crear_codigos(objCodigos);
	}
	//--------------------
	// METODOS PUBLICOS:
	public function codificar(texto:String):String
	{
		trace("(Enigma.codificar)!");
		for (var i = 0; i < codigos.cadena.length; i++)
		{
			var cadena = codigos.cadena[i];
			var codigo = "[" + codigos.codigo[i] + "]";
			
			var excepcion:String = "[" + cadena + "]";
			
			texto = texto.split(excepcion).join("[*]");
			texto = texto.split(cadena).join(codigo);
			texto = texto.split("[*]").join(excepcion);
			
		}
		texto = texto.split("[").join("");
		texto = texto.split("]").join("");
		return texto;
	}
	public function descodificar(texto:String):String
	{
		trace("(Enigma.descodificar)!"+texto);
		for (var i = 0; i < codigos.cadena.length; i++)
		{
			var cadena = "[" + codigos.cadena[i] + "]";
			var codigo = codigos.codigo[i];
			
			var excepcion:String = "[" + codigo + "]";
			
			texto = texto.split(excepcion).join("[*]");
			texto = texto.split(codigo).join(cadena);
			texto = texto.split("[*]").join(excepcion);
			
		}
		texto = texto.split("[").join("");
		texto = texto.split("]").join("");
		return texto;
		
	}
	//--------------------
	// METODOS PRIVADOS:
	private function crear_codigos(objCodigos:Object)
	{
		if (objCodigos == null || objCodigos == undefined)
		{
			codigos = new Object();
			codigos.cadena = new Array();
			codigos.codigo = new Array();
			codigos.cadena.push("&");
			codigos.codigo.push("/y/");
			codigos.cadena.push("=");
			codigos.codigo.push("/igual/");
			codigos.cadena.push("$");
			codigos.codigo.push("/dollar/");
			codigos.cadena.push("¿");
			codigos.codigo.push("/int1/");
			codigos.cadena.push("?");
			codigos.codigo.push("/int2/");
			//--
			codigos.cadena.push("[");
			codigos.codigo.push("/cor1/");
			codigos.cadena.push("]");
			codigos.codigo.push("/cor2/");
			codigos.cadena.push("<");
			codigos.codigo.push("/lla1/");
			codigos.cadena.push(">");
			codigos.codigo.push("/lla2/");
		}
		else
		{
			codigos = new Object();
			codigos = objCodigos;
		}
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
