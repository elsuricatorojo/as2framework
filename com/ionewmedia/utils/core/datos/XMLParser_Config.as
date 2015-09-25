
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
import com.ionewmedia.utils.core.logica.Config
//--
class com.ionewmedia.utils.core.datos.XMLParser_Config {
	//--------------------
	// DOCUMENTACION:
	/*
	 * Esta clase nutre directamente a Config.
	 */
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	public function XMLParser_Config () {
		trace ("(XMLParser_Config.CONSTRUCTORA)!")
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters/Setters:
	public function set_data(objXML:XML):Void {
		trace("(XMLParser_Config.set_data)!")
		inter_objXML(objXML)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function inter_objXML(objXML:XML) {
		trace("(XMLParser_Config.inter_objXML)!");
		
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		//--
		var pos_config:Number = XML2.posicionSubnodo(nodo, "config")
		inter_config (nodoAnalizado[pos_config])
	}
	private function inter_config(nodo:XMLNode):Void {
		trace("(XMLParser_Config.inter_config)!");
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			var paramId:String = nodoAnalizado[subnodos].attributes.id
			var tipo:String = nodoAnalizado[subnodos].attributes.tipo
			var valorBruto:String = nodoAnalizado[subnodos].firstChild.nodeValue
			var valor
			//--
			if (tipo == "Number") {
				valor = Number (valorBruto)
			}else if (tipo == "Boolean") {
				valor =  Boolean(Number (valorBruto))
			}else if (tipo == "Array") {
				valor = valorBruto.split(",")
			}else {
				valor =  String(valorBruto)
			}
			trace ("   "+paramId+": "+valor)
			//--
			Config.nuevoParam(paramId, valor, tipo)
		}
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}