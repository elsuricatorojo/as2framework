/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 07/04/2009 11:39
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.data.Datos;
//--
import com.ionewmedia.utils.core.datos.XMLParser_Config
class com.ionewmedia.utils.core.logica.Config {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private static var inst:Config;
	private static var count:Number = 0;
	private static var data: Datos
	//--------------------
	// CONSTRUCTORA:
	public function Config() {
		trace("(Config.CONSTRUCTORA)!")
		data = new Datos("config")
	}
	// Singelton:
	public static function getInstance ():Config{
		if (inst == null)	{
			inst = new Config ();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	public static function set_data(objXML:XML):Void {
		trace("(Config.set_data)!")
		//trace("   objXML: "+objXML)
		var parser:XMLParser_Config = new XMLParser_Config()
		parser.set_data(objXML)
	}
	public static  function nuevoParam(paramId:String, valor:Object, tipo:String, replace:Boolean):Void {
		trace("(Config.nuevoParam) paramId: "+paramId+"   valor: "+valor)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, paramId)
		if (replace == undefined || replace==null) {
			replace = false
		}
		if(!existe){
			var dataTemp:Object = new Object()
			dataTemp.paramId = paramId
			dataTemp.valor = valor
			dataTemp.tipo = tipo
			data.nuevoItem(paramId, dataTemp)
		}else {
			trace("(Config.nuevoPath) ATENCION: Ya existe el paramId que se quiere añadir: " + paramId)
			if (replace) {
				trace("COMO replace=true, replazamos el valor")
				var item:Object = data.getItem(paramId)
				item.valor = valor
				item.tipo = tipo
			}
		}
	}
	// Getters:
	public static function getParam(paramId:String) {
		trace("(Config.getParam): "+paramId)
		var existe:Boolean = data.evalExiste(paramId)
		if (existe) {
			//trace("(Config.getParam): "+paramId+" : "+data.getItem(paramId).valor)
			//trace("   valor: "+data.getItem(paramId).valor)
			trace("   valor: "+data.getItem(paramId).valor)
			return data.getItem(paramId).valor
		}else {
			trace("(Config.getParam): "+paramId)
			trace("ATENCION: El parametro solicitado ("+paramId+") NO existe. Se devuelve null")
			return null	
		}
	}
	// NUEVO: 15/10/2013 18:22
	public static function existeParam(paramId:String):Boolean {
		var existe:Boolean = data.evalExiste(paramId)
		return existe
	}
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}