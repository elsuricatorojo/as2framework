/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
class com.ionewmedia.utils.mouse.DobleClick {
	//--------------------
	// PARAMETROS:
	var temp:Number;
	var ref:Number;
	//--------------------
	// CONSTRUCTORA:
	function DobleClick(t:Number) {
		trace("(DobleClick.CONSTRUCTORA)!");
		if (t == null || t == undefined) {
			temp = 100;
		} else {
			temp = t;
		}
		ref = 0;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function eval():Boolean {
		var ref2 = getTimer();
		var limite = ref+temp;
		//trace("   temp: "+temp);
		//trace("   ref: "+ref);
		//trace("   limite: "+limite);
		//trace("   ref2: "+ref2);
		if (ref2<=limite) {
			ref = ref2;
			trace("(DobleClick.eval): true");
			return true;
		} else {
			ref = ref2;
			return false;
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
