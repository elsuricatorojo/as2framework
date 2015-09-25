/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 02/05/2013 12:49
*/
import com.ionewmedia.utils.estaticas.XML2;
import com.ionewmedia.utils.data.Datos;
//--
import com.ionewmedia.utils.core.logica.MenuBasico
import com.ionewmedia.utils.core.datos.DatosOpcionMenuBasico
//--
class com.ionewmedia.utils.core.datos.XMLParser_MenuBasico {
	// import com.ionewmedia.utils.core.datos.XMLParser_MenuBasico
	//--------------------
	// DOCUMENTACION:
	/*
	 <menu>
		<item id="01_librerias" color="FF0000">
			<nombre><![CDATA[Ya en las<br>librerías]]></nombre>
			<external_path>http://www.elpais.es</external_path>
			<imagen1_path>data/menu/01_librerias.png</imagen1_path>
			<imagen2_path>data/menu/01_librerias.png</imagen2_path>
		</item>
	</menu>
	 */
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	public function XMLParser_menu () {
		trace ("(XMLParser_menu.CONSTRUCTORA)!")
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters/Setters:
	public function set_data(objXML:XML, nombreNodo:String):Void {
		trace("(XMLParser_menu.set_data)!")
		if (nombreNodo == undefined) {
			nombreNodo = "menu"
		}
		inter_objXML(objXML, nombreNodo)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function inter_objXML(objXML:XML, nombreNodo:String) {
		trace("(XMLParser_menu.inter_objXML)!");
		var nodo = objXML.firstChild;
		var nodoAnalizado = nodo.childNodes;
		//--
		var pos_nodo:Number = XML2.posicionSubnodo(nodo, nombreNodo)
		inter_nodo (nodoAnalizado[pos_nodo])
	}
	private function inter_nodo(nodo:XMLNode):Void {
		trace("(XMLParser_menu.inter_nodo)!");
		var nodoAnalizado = nodo.childNodes;
		var contador:Number = 0
		for (var subnodos in nodoAnalizado) {
			contador++
			var dataOpcion:DatosOpcionMenuBasico = new DatosOpcionMenuBasico()
			dataOpcion.opcionId = nodoAnalizado[subnodos].attributes.id
			dataOpcion.nombre = XML2.extraerValorNodo(nodoAnalizado[subnodos], "nombre")
			dataOpcion.texto2 = XML2.extraerValorNodo(nodoAnalizado[subnodos], "texto2")
			dataOpcion.colorString = nodoAnalizado[subnodos].attributes.color
			dataOpcion.colorHex = parseInt(dataOpcion.colorString, 16)
			dataOpcion.external_path = XML2.extraerValorNodo(nodoAnalizado[subnodos], "external_path")
			dataOpcion.imagen1_path = XML2.extraerValorNodo(nodoAnalizado[subnodos], "imagen1_path")
			dataOpcion.imagen2_path = XML2.extraerValorNodo(nodoAnalizado[subnodos], "imagen2_path")
			//--
			MenuBasico.nuevaOpcion(dataOpcion)
		}
		MenuBasico.reverseIndice()	
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}