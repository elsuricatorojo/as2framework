
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
import com.ionewmedia.utils.core.logica.Paths
//--
class com.ionewmedia.utils.core.datos.XMLParser_Paths {
	//--------------------
	// DOCUMENTACION:
	/*
	 * Esta clase nutre directamente a Paths.
	 */
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	public function XMLParser_Paths () {
		trace ("(XMLParser_Paths.CONSTRUCTORA)!")
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters:
	// Setters:
	public function set_data(objXML:XML):Void {
		trace("(XMLParser_Paths.set_data)!")
		inter_objXML(objXML)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function inter_objXML(objXML:XML) {
		trace("(XMLParser_Paths.inter_objXML)!");
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		//--
		var pos_paths:Number = XML2.posicionSubnodo(nodo, "paths")
		inter_paths (nodoAnalizado[pos_paths])
	}
	private function inter_paths(nodo:XMLNode):Void {
		trace("(XMLParser_Paths.inter_paths)!");
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			var pathId:String = nodoAnalizado[subnodos].attributes.id
			var destino:String = nodoAnalizado[subnodos].attributes.target
			var path:String = nodoAnalizado[subnodos].firstChild.nodeValue
			// NUEVO: 24/09/2014 10:29
			// Si replace = 1: Si se encuentra otro path con el mismo id SI lo actualiza
			// Si replace = 0: Si se encuentra otro path con el mismo id NO lo actualiza
			var replaceString:String = nodoAnalizado[subnodos].attributes.replace
			if (replaceString != "1") {
				replaceString = "0"
			}
			var replace:Boolean = Boolean(Number(replaceString))
			trace("   ---")
			trace("   pathId: " + pathId)
			trace("   destino: " + destino)
			trace("   path: "+path)
			Paths.nuevoPath(pathId, path, destino, replace)
		}
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}