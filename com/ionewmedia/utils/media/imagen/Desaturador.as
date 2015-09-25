/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061019
*/
import flash.filters.ColorMatrixFilter;
class com.ionewmedia.utils.media.imagen.Desaturador {
	//--------------------
	// DOCUMENTACION:
	private var donde_mc:MovieClip;
	private var cantidad:Number;
	//--
	var colorFilter:ColorMatrixFilter;
	var redIdentity = [1, 0, 0, 0, 0];
	var greenIdentity = [0, 1, 0, 0, 0];
	var blueIdentity = [0, 0, 1, 0, 0];
	var alphaIdentity = [0, 0, 0, 1, 0];
	var grayluma = [.3, .59, .11, 0, 0];
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	function Desaturador(mc:MovieClip) {
		trace("(Desaturador.CONSTRUCTORA) 1833!");
		donde_mc=mc
		//--
		colorFilter = new flash.filters.ColorMatrixFilter();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function update(mod:Number) {
		trace("(Desaturador.update): "+mod);
		// create new array to represent the matrix
		// information used in colorFilter
		var colmatrix:Array = new Array();
		// populate the array with values resulting from the blended
		// grayluma array and the color identities given the amount
		// provided by the slider. 0 = all grayluma, no identity
		// 1 = no grayluma, all identity
		colmatrix = colmatrix.concat(interpolarArrays(grayluma, redIdentity, mod));
		colmatrix = colmatrix.concat(interpolarArrays(grayluma, greenIdentity, mod));
		colmatrix = colmatrix.concat(interpolarArrays(grayluma, blueIdentity, mod));
		colmatrix = colmatrix.concat(alphaIdentity);
		// alpha not affected
		// assign the new matrix to colorFilter
		colorFilter.matrix = colmatrix;
		// apply the filter to the image
		donde_mc.filters = [colorFilter];
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EVENTOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
	private function interpolarArrays(ary1:Array, ary2:Array, t:Number) {
		var result:Array = (ary1.length>=ary2.length) ? ary1.slice() : ary2.slice();
		var i = result.length;
		while (i--) {
			result[i] = ary1[i]+(ary2[i]-ary1[i])*t;
		}
		return result;
	}
}
