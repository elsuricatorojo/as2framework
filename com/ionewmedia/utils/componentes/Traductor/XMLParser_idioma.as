/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070611
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.XML2;
import com.ionewmedia.utils.estaticas.Object2;
import com.ionewmedia.utils.estaticas.String2;
import com.ionewmedia.utils.estaticas.Array2;
class com.ionewmedia.utils.componentes.Traductor.XMLParser_idioma {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var data:Object;
	private var sobreEscibir:Boolean;
	//--------------------
	// CONSTRUCTORA:
	function XMLParser_idioma() {
		trace("(XMLParser_idioma.CONSTRUCTORA)!");
		init_data();
	}
	public function testScope(txt:String):Void {
		trace("(XMLParser_idioma.testScope) ---------------- "+txt);
	}
	//--------------------		
	// METODOS PUBLICOS:
	public function set_data(objXML:XML):Void {
		trace("   (XMLParser_idioma.set_data): "+objXML);
		inter_objXML(objXML);
		//Object2.zlogTrace(data, "DataMenu.data");
	}
	public function set_sobreEscibir(valor:Boolean) {
		sobreEscibir = valor;
	}
	public function add_terminos(objXML:XML):Void {
		trace("   (XMLParser_idioma.add_terminos)!");
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			inter_item(nodoAnalizado[subnodos]);
		}
	}
	public function get_data():Object {
		return (data);
	}
	public function get_texto(textoId:String):String {
		return (data[textoId].texto);
	}
	public function mostrar_terminos() {
		for (var i = 0; i<data.array_items.length; i++) {
			var textoId:String = data.array_items[i];
			trace("   "+textoId+"  :  "+data[textoId].texto);
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_data() {
		data = new Object();
		data.array_items = new Array();
	}
	private function inter_objXML(objXML:XML) {
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			inter_item(nodoAnalizado[subnodos]);
		}
		data.array_items.reverse();
	}
	function inter_item(nodo:XMLNode) {
		trace("      (XMLParser_idioma.inter_item): "+nodo.attributes.id);
		//var nodoAnalizado = nodo.childNodes;
		var textoId:String = nodo.attributes.id;
		var esta:Boolean = Array.estaEnElArray(data.array_items, textoId);
		//--
		if (esta) {
			Trace.trc("      EL COD DE TEXTO: '"+textoId+"' YA ESTÁBA PRESENTE!!!");
			if (sobreEscibir) {
				Trace.trc("      SOBRE ESCRIBIMOS EL TERMINO YA QUE sobreEscibir=true.");
				data.array_items.push(textoId);
				data[textoId] = new Object();
				data[textoId].textoId = textoId;
				data[textoId].texto = nodo.firstChild.nodeValue;
			}
		} else {
			data.array_items.push(textoId);
			data[textoId] = new Object();
			data[textoId].textoId = textoId;
			data[textoId].texto = nodo.firstChild.nodeValue;
		}
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
