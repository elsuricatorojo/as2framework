/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 2008
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.Emisor
//import com.ionewmedia.utils.estaticas.Object2
class com.ionewmedia.utils.movieclip.Coloreador {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	static function tintar (colorString:String, ref:MovieClip, token:String):Void {
		var colorHex:Number = parseInt(colorString, 16)
		var contador:Number=0
		for (var nombreInstancia:String in ref) {
			var instancia:Object=ref[nombreInstancia]
			var nombre:String = instancia._name
			var arrayToken:Array = nombre.split(token)
			if (arrayToken.length>1) {
			 var colorInstancia:Color = new Color(instancia)
			 colorInstancia.setRGB(colorHex)
			 contador++
			}
		}
		trace("(Coloreador.tintar): SE HAN COLOREADO "+contador+" ITEMS ("+colorString+")!")
	}
	static function tintarMc (colorString:String, ref:MovieClip):Void {
		var colorHex:Number = parseInt(colorString, 16)
		var colorInstancia:Color = new Color(ref)
		colorInstancia.setRGB(colorHex)
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}