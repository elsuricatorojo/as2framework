/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20080306
*/
import com.ionewmedia.utils.estaticas.XML2;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.estaticas.Object2;
import mx.utils.XMLString;
import tv.zarate.Utils.Trace;
class com.ionewmedia.utils.GUI.IOMultibanner.XMLParser_Multibanner {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var data:Object;
	//--------------------
	// CONSTRUCTORA:
	function XMLParser_Multibanner() {
		//trace("(XMLParser_Multibanner.CONSTRUCTORA)!");
		init_data();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_data(objXML):Void {
		//trace("(XMLParser_Multibanner.set_data)!");
		inter_objXML(objXML);
		//Object2.zlogTrace(data,"IMAGENES MULTIBANNER");
	}
	public function replace_data(obj:Object) {
		data = obj
		//Object2.zlogTrace(data,"IMAGENES MULTIBANNER");
	}
	public function get_data():Object {
		//trace("(XMLParser_Multibanner.get_data)! ")
		return (data);
	}
	public function get_dataItem(itemId:String):Object {
		return data[itemId]
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_data() {
		data = new Object();
		data.array_items=new Array()
	}
	private function inter_objXML(objXML:XML) {
		// ESTE METODO ES EL QUE DEBE EXTENDERSE PARA UNA IMPLEMENTACIÓN DISTINTA DEL ORIGINAL DEL MULTIBANNER
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			var itemId:String = nodoAnalizado[subnodos].attributes.id;
			data[itemId] = new Object()
			data.array_items.push(itemId)
			data[itemId].itemId = itemId
			data[itemId].pausa = nodoAnalizado[subnodos].attributes.pausa
			data[itemId].pausaDelegada = nodoAnalizado[subnodos].attributes.pausaDelegada
			data[itemId].titulo = XML2.extraerValorNodo(nodoAnalizado[subnodos], "titulo");
			data[itemId].path = XML2.extraerValorNodo(nodoAnalizado[subnodos], "path");
			data[itemId].clickTag = XML2.extraerValorNodo(nodoAnalizado[subnodos], "clickTag");
			data[itemId].target = XML2.extraerAtributoNodo(nodoAnalizado[subnodos], "clickTag", "target")
			data[itemId].ejecutar = XML2.extraerValorNodo(nodoAnalizado[subnodos], "ejecutar");
			//--
			// Filtramos valores:
			if (data[itemId].pausa == undefined || data[itemId].pausa == "") {
				data[itemId].pausa=null // Multibanner lo sustituirá por la pausa por defecto.
			}else {
				data[itemId].pausa=Number(data[itemId].pausa)
			}
			if (data[itemId].pausaDelegada==undefined || data[itemId].pausaDelegada=="" || data[itemId].pausaDelegada=="0") {
				data[itemId].pausaDelegada=false
			}else {
				data[itemId].pausaDelegada=true
			}
			if (data[itemId].ejecutar == undefined|| data[itemId].ejecutar == "") {
				data[itemId].ejecutar=null
			}
			if (data[itemId].clickTag == undefined || data[itemId].clickTag == "") {
				data[itemId].clickTag=null
			}
			//--
			//trace("itemId: " + data[itemId].itemId)
			//trace("  pausa: " + data[itemId].pausa)
			//trace("  pausaDelegada: " + data[itemId].pausaDelegada)
			//trace("  titulo: " + data[itemId].titulo)
			//trace("  path: " + data[itemId].path)
			//trace("  clickTag: " + data[itemId].clickTag)
			//trace("  target: " + data[itemId].target)
			//trace("  ejecutar: " + data[itemId].ejecutar)
		}
		data.array_items.reverse()
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}