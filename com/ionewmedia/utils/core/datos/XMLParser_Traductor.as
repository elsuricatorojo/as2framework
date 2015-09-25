
/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 24/03/2009 11:57
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.XML2;
import com.ionewmedia.utils.data.Datos;
//--
import com.ionewmedia.utils.core.logica.Traductor
//--
class com.ionewmedia.utils.core.datos.XMLParser_Traductor {
	//--------------------
	// DOCUMENTACION:
	/*
	 * Esta clase nutre directamente a Paths.
	 */
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	public function XMLParser_Traductor () {
		trace ("(XMLParser_Traductor.CONSTRUCTORA)!")
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters:
	// Setters:
	public function set_data(objXML:XML):Void {
		trace("(XMLParser_Traductor.set_data)!")
		inter_objXML(objXML)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function inter_objXML(objXML:XML) {
		trace("(XMLParser_Traductor.inter_objXML)!");
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		//--
		var pos_traductor:Number = XML2.posicionSubnodo(nodo, "traductor")
		inter_traductor (nodoAnalizado[pos_traductor])
	}
	private function inter_traductor(nodo:XMLNode):Void {
		trace("(XMLParser_Traductor.inter_traductor)!");
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			var terminoId:String = nodoAnalizado[subnodos].attributes.id
			Traductor.nuevoTermino(terminoId)
			var nodoAnalizado2 = nodoAnalizado[subnodos].childNodes;
			for (var pos2 in nodoAnalizado2) {
				var idiomaId:String = nodoAnalizado2[pos2].attributes.id
				var traduccion:String = nodoAnalizado2[pos2].firstChild.nodeValue
				Traductor.nuevaTraduccion(terminoId, idiomaId, traduccion, false)
			}
		}
		//Traductor.nuevoPath(pathId, path, destino)
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}