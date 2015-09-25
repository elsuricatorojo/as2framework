/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070506
*/
import com.ionewmedia.utils.estaticas.Object2
//--
class com.ionewmedia.utils.GUI.IOCombo.DataCombo {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var data:Object;
	//--------------------
	// CONSTRUCTORA:
	function DataCombo() {
		data = new Object();
		data.array_items = new Array();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function get_data():Object {
		//trace("(DataCombo.get_data)!")
		return data;
	}
	public function get_nombre(valor:String):String {
		return data[valor].nombre;
	}
	public function get_primerValor():String {
		return data.array_items[0];
	}
	public function addOption(nombre:String, valor:String) {
		data[valor] = new Object();
		data[valor].nombre = nombre;
		data[valor].valor = valor;
		data.array_items.push(valor);
	}
	public function trace_data() {
		trace("(DataCombo.trace_data)!")
		Object2.traceObject(data)
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}
