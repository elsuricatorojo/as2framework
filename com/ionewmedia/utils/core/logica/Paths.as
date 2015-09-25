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
import com.ionewmedia.utils.estaticas.Object2;
//--
import com.ionewmedia.utils.core.datos.XMLParser_Paths
class com.ionewmedia.utils.core.logica.Paths {
	// import com.ionewmedia.utils.core.logica.Paths
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private static var inst:Paths;
	private static var count:Number = 0;
	private static var data: Datos
	//--------------------
	// CONSTRUCTORA:
	public function Paths() {
		trace("(Paths.CONSTRUCTORA)!")
		data = new Datos("paths")
	}
	// Singelton:
	public static function getInstance ():Paths{
		if (inst == null)	{
			inst = new Paths ();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	public static function set_data(objXML:XML):Void {
		trace("(Paths.set_data)!")
		var parser:XMLParser_Paths = new XMLParser_Paths()
		parser.set_data(objXML)
	}
	public static  function nuevoPath(pathId:String, path:String, destino:String, replace:Boolean):Void {
		trace("(Paths.nuevoPath) pathId: "+pathId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, pathId)
		if(!existe){
			var dataTemp:Object = new Object()
			dataTemp.pathId = pathId
			dataTemp.path = path
			dataTemp.destino = destino
			data.nuevoItem(pathId, dataTemp)
		}else {
			trace("(Paths.nuevoPath) ATENCION: Ya existe el pathId que se quiere añadir: " + pathId)
			// NUEVO: 24/09/2014 10:34
			if (replace) {
				trace("(Paths.nuevoPath) ATENCION: Como replace=true actualizamos los datos!!!")
				var itemExistente:Object = data.getItem(pathId)
				itemExistente.path = path
				itemExistente.destino = destino
			}
		}
	}
	// Getters:
	public static function getPath(pathId:String):String {
		trace("(Paths.getPath): "+pathId)
		var path:String=null
		var existe:Boolean = Array2.estaEnElArray(data.array_items, pathId)
		if(existe){
		var dataTemp:Object = data.getItem(pathId)
			path=dataTemp.path
		}else {
			trace("(Paths.getPath) ATENCION: El pathId solicitado NO existe!!")
		}
		return path
	}
	public static function existePath(pathId:String):Boolean {
		trace("(Paths.existePath): "+pathId)
		// NUEVO: 20140818
		// Devuelve true o false en función de si existe el pathId pasado.
		return Array2.estaEnElArray(data.array_items, pathId)
	}
	public static function getDestino(pathId:String):String {
		// NUEVO: 28/04/2009 11:46
		trace("(Paths.getDestino): " + pathId)
		var destino:String=null
		var existe:Boolean = Array2.estaEnElArray(data.array_items, pathId)
		if(existe){
			var dataTemp:Object = data.getItem(pathId)
			destino=dataTemp.destino
		}else {
			trace("(Paths.getPath) ATENCION: El pathId solicitado NO existe!!")
		}
		return destino
	}
	public static function modificarPath(pathId:String, nuevoPath:String):Void {
		trace("(Paths.modificarPath)  pathId: " + pathId+"   nuevoPath: "+nuevoPath)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, pathId)
		if (existe) {
			var dataTemp:Object = Object2.copiarObjeto(data.getItem(pathId))
			data.quitarItem(pathId)
			dataTemp.path = nuevoPath
			data.nuevoItem(pathId, dataTemp)
			Object2.traceObject(dataTemp, "nuevo data")
		}else {
			trace("(Paths.modificarPath) ATENCION: El pathId solicitado NO existe!!")
		
		}
		
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