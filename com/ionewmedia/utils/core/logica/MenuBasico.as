/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 02/05/2013 13:15
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.core.datos.DatosOpcionMenuBasico;
import com.ionewmedia.utils.data.Datos;
//--
import com.ionewmedia.utils.core.datos.XMLParser_MenuBasico
class com.ionewmedia.utils.core.logica.MenuBasico {
	// import com.ionewmedia.utils.core.logica.MenuBasico
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private static var inst:MenuBasico;
	private static var count:Number = 0;
	private static var data:Datos
	//--------------------
	// CONSTRUCTORA:
	public function MenuBasico() {
		// emisor = new EmisorExtendido()
		data = new Datos("MenuBasico")
	}
	// Singelton:
	public static function getInstance ():MenuBasico{
		if (inst == null)	{
			inst = new MenuBasico ();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	public static function set_data(objXML:XML, nodoMenu:String):Void {
		trace("(MenuBasico.set_data)!")
		if (nodoMenu == undefined || nodoMenu == null || nodoMenu == "") {
			nodoMenu = "menu"
		}
		var parser:XMLParser_MenuBasico = new XMLParser_MenuBasico()
		parser.set_data(objXML, nodoMenu)
	}
	//--
	static public function nuevaOpcion(dataOpcion:DatosOpcionMenuBasico):Void {
		data.nuevoItem(dataOpcion.opcionId, dataOpcion)
	}
	static public function reverseIndice():Void {
		data.reverseIndice()
	}
	static public function getDataOpciones():Datos {
		return data
	}
	static public function getOpcion(opcionId:String):DatosOpcionMenuBasico {
		return data.getItem(opcionId)
	}
	static public function getObjOpcion(opcionId:String):Object {
		var dataOpcion:DatosOpcionMenuBasico = data.getItem(opcionId)
		return dataOpcion.getObject()
	}
	static public function getNumOpciones():Number {
		return data.numItems
	}
	//--
	// Getters/Setters:
	
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}