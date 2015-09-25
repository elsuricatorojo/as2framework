/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20061123
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.XML2;
class com.ionewmedia.utils.componentes.Multibanner.datos.DATA_elementos
{
	//--------------------
	// DOCUMENTACION:
	// Interpreta un xml con modelo de datos del tipo "data/menu/menu.xml"
	//--------------------
	// PARAMETROS:
	private var data:Object;
	//--------------------
	// CONSTRUCTORA:
	function DATA_elementos()
	{
		//trace("(DATA_elementos.CONSTRUCTORA)!");
		crear_data();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function set_data(objXML:XML):Void
	{
		//trace("(DATA_elementos.set_data): "+objXML);
		inter_objXML(objXML);
	}
	public function get_data():Object
	{
		//trace("(DATA_elementos.get_data)!");
		//devuelve un OBJECT con todos los datos
		return data;
	}
	public function get_dataElemento(elemento:String):Object
	{
		//trace("(DATA_elementos.get_data)!");
		//dada el ID de un elemento devuelve un OBJECT con todos sus datos	
		return data[elemento];
	}
	//--------------------
	// METODOS PRIVADOS:
	private function crear_data():Void
	{
		data = new Object();
		data.array_items = new Array();
	}
	//--------------------
	// INTER XML:
	private function inter_objXML(objXML:XML)
	{
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		var pos_elementos = XML2.posicionSubnodo(nodo, "elementos");
		inter_elementos(nodoAnalizado[pos_elementos]);
		var automatico:String = XML2.extraerValorNodo(nodo, "automatico");
		var tipoAnimacion:String = XML2.extraerValorNodo(nodo, "tipoAnimacion");
		var timeAnimacion:String = XML2.extraerValorNodo(nodo, "timeAnimacion");
		var imgDefault:String = XML2.extraerValorNodo(nodo, "imgDefault");
		
		data.automatico = automatico;
		data.tipoAnimacion = tipoAnimacion;
		data.timeAnimacion = timeAnimacion;
		data.imgDefault=imgDefault
		data.array_items.reverse();
	}
	private function inter_elementos(nodo:XMLNode)
	{
		//trace("(DATA_elementos.inter_elementos): "+nodo);
		var elementos = nodo.childNodes;
		for (var elemento in elementos)
		{
			inter_elemento(elementos[elemento]);
		}
	}
	private function inter_elemento(nodo:XMLNode, elementoId:String)
	{
		//trace("   (DATA_elementos.inter_elemento)!");
		var nodoAnalizado = nodo.childNodes;
		var elementoId:String = nodo.attributes.id;
		data[elementoId] = new Object();
		data[elementoId].id = elementoId;
		data[elementoId].ruta = XML2.extraerValorNodo(nodo, "ruta");
		data[elementoId].permanencia = XML2.extraerValorNodo(nodo, "permanencia");
		data[elementoId].link = XML2.extraerValorNodo(nodo, "link");
		data[elementoId].targetLink = XML2.extraerValorNodo(nodo, "targetLink");
		data[elementoId].transicion = XML2.extraerValorNodo(nodo, "transicion");
		data[elementoId].modoTransicion = XML2.extraerValorNodo(nodo, "modoTransicion");
		data.array_items.push(elementoId);
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
