/*
DOCUMENTACION:
*
* io newmedia S.L. - http://www.zona-io.com  || 
* roberto@zona-io.com		(Roberto Ferrero)
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/	
* Creada el 20061128
*/
class com.ionewmedia.utils.estaticas.Grid {
	//-------------------------------------
	// METODOS STATICOS:
	static function getCoordenadas(pos:Number, numCols:Number):Array {
		var arrayCoord:Array = new Array();
		var col:Number = ((pos/numCols)-(Math.floor(pos/numCols)))*numCols;
		var fila:Number = Math.floor(pos/numCols);
		arrayCoord[0] = col;
		arrayCoord[1] = fila;
		return (arrayCoord);
	}
	static function getPos(pos:Number, numCols:Number, anchoCelda:Number, altoCelda:Number):Array {
		var arrayPos:Array = new Array();
		var arrayCoord:Array = getCoordenadas(pos, numCols);
		var col:Number = arrayCoord[0];
		var fila:Number = arrayCoord[1];
		arrayPos[0] = col*anchoCelda;
		arrayPos[1] = fila*altoCelda;
		return (arrayPos);
	}
	static function getFilaId(pos:Number, numCols:Number):Number {
		var arrayPos:Array = new Array();
		var arrayCoord:Array = getCoordenadas(pos, numCols);
		var col:Number = arrayCoord[0];
		var fila:Number = arrayCoord[1];
		return (fila);
	}
}
