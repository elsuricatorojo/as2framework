/*
DOCUMENTACION:
- extraerAtributoNodo(nodo:XMLNode, nombreSubNodo:String, atributo:String):String
Dado un objeto XML 'nodo' lo examina y devuelve el valor del atributo especificado
por el parametro 'atributo' del subnodo especificado por 'nombreSubNodo'
- extraerValorNodo(nodo:XMLNode, nombreSubNodo:String):String
Dado un objeto XML lo examina y devuelve el nodeValue del subnodo cuyo nombre
coincida con "nombreSubNodo"
- posicionSubnodo(nodo:XMLNode, nombreSubNodo:String):Number
Dado un objeto XML 'nodo' lo examina y devuelve la posicion del subnodo especificado
por el parametro 'nombreSubNodo'
*
* io newmedia S.L. - http://www.zona-io.com  
* roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
import tv.zarate.Utils.Trace;
class com.ionewmedia.utils.estaticas.XML2 {
	static function getNodo(nodoContenedor:XMLNode, nombreSubNodo:String):XMLNode {
		//NUEVO: 07/09/2012 10:58
		//trace("(XML2.getNodo)!");
		// Dado un objeto nodo devuelve un subnodo con el nombre del valor subnodo
		var nodoAnalizado = nodoContenedor.childNodes;
		var pos_nodo:Number = posicionSubnodo(nodoContenedor, nombreSubNodo)
		return (nodoAnalizado[pos_nodo])
	}
	static function extraerAtributoNodo(nodo:XMLNode, nombreSubNodo:String, atributo:String):String {
		//trace("(XML2.extraerAtributoNodo)!");
		// Dado un objeto XML 'nodo' lo examina y devuelve el valor del atributo especificado
		// por el parametro 'atributo' del subnodo especificado por 'nombreSubNodo' 
		//var subNodos:XMLNode;
		var nombreNodo:String;
		var nodoAnalizado:Array = nodo.childNodes;
		for (var subNodos in nodoAnalizado) {
			nombreNodo = nodoAnalizado[subNodos].nodeName;
			if (nombreNodo == nombreSubNodo) {
				//trace("(IntEntrada_int.xml_extraerAtributoNodo) Atributo "+atributo+":"+nodoAnalizado[subNodos].attributes[atributo]);
				return (nodoAnalizado[subNodos].attributes[atributo]);
				break;
			}
		}
	}
	static function extraerValorNodo(nodo:XMLNode, nombreSubNodo:String):String {
		//trace("(XML2.extraerValorNodo)!");
		// Dado un objeto XML lo examina y devuelve el nodeValue del subnodo cuyo nombre
		// coincida con "nombreSubNodo"
		var nombreNodo:String;
		var nodoAnalizado:Array = nodo.childNodes;
		for (var subNodos in nodoAnalizado) {
			nombreNodo = nodoAnalizado[subNodos].nodeName;
			if (nombreNodo == nombreSubNodo) {
				//trace("(XML2.extraerValorNodo) "+nombreSubNodo+":"+nodoAnalizado[subNodos].firstChild.nodeValue);
				return (nodoAnalizado[subNodos].firstChild.nodeValue);
				break;
			}
		}
	}
	static function posicionSubnodo(nodo:XMLNode, nombreSubNodo:String):Number {
		//trace("(XML2.posicionSubnodo)!");
		// Dado un objeto XML 'nodo' lo examina y devuelve la posicion del subnodo especificado
		// por el parametro 'nombreSubNodo'
		var nombreNodo:String;
		var nodoAnalizado:Array = nodo.childNodes;
		for (var subNodos in nodoAnalizado) {
			nombreNodo = nodoAnalizado[subNodos].nodeName;
			if (nombreNodo == nombreSubNodo) {
				//trace("(IntEntrada_int.xml_posicionSubnodo) Posición subNodo("+nombreSubNodo+"):"+subNodos);
				return Number(subNodos);
				break;
			}
		}
	}
}
