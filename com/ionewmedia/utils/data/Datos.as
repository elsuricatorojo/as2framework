/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 07/07/2008 11:22
* Modificada: 29/07/2008 12:58 (en nuevoItem data es opcional)
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.Object2
import com.ionewmedia.utils.estaticas.Array2
class com.ionewmedia.utils.data.Datos extends Object {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var id:String = null
	public var array_items:Array
	private var _numItems:Number
	//--------------------
	// CONSTRUCTORA:
	function Datos(_id:String){
		//trace("(Datos.CONSTRUCTORA) id: "+_id)
		if (_id != undefined && _id != null) {
			id=_id
		}
		array_items = new Array();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevoItem(itemId:String, data):Void {
		array_items.push(itemId)
		if (data == null || data == undefined) {
			this[itemId]=new Object()
		}else {
			this[itemId] = data
		}
		_numItems=array_items.length
	}
	public function nuevoItemAt(itemId:String, data, pos:Number):Void {
		array_items[pos] = itemId
		if (data == null || data == undefined) {
			this[itemId]=new Object()
		}else {
			this[itemId] = data
		}
		_numItems=array_items.length
	}
	public function quitarItem(itemId:String):Void {
		var existe:Boolean = Array2.estaEnElArray(array_items, itemId)
		if (existe) {
			array_items = Array2.quitarElem(array_items, itemId)
			this[itemId]=null
		}else {
			trace("(Datos.quitarItem): "+itemId)
			trace("ATENCION: El itemId que se desea eliminar ('"+itemId+"') no existe!")
		}
		_numItems=array_items.length
	}
	public function getItem(itemId:String) {
		var existe:Boolean = Array2.estaEnElArray(array_items, itemId)
		if (existe) {
			return this[itemId]
		}else {
			trace("(Datos.getItem): "+itemId)
			trace("ATENCION: El itemId solicitado ('"+itemId+"') no existe!")
		}
	}
	// NUEVO: 08/05/2009 9:28
	public function getItemIdAt(pos:Number):String {
		// Devuelve la id del item en la posición pasada (0=primero)
		return array_items[pos]
	}
	public function getItemAt(pos:Number) {
		// Devuelve el item en la posición pasada (0=primero)
		var itemId:String = getItemIdAt(pos)
		return getItem(itemId)
	}
	//--
	public function get numItems():Number {
		return array_items.length
	}
	public function traceObject():Void {
		Object2.traceObject(this, id)
	}
	public function zlogTrace():Void {
		Object2.zlogTrace(this, id)
	}
	// NUEVO: 14/12/2008 17:23
	public function evalExiste(itemId:String):Boolean {
		return Array2.estaEnElArray(array_items, itemId)
	}
	// NUEVO: 05/03/2009 17:19
	public function desordenarIndice():Void {
		// Desordena el array_items
		array_items = Array2.desordenar(array_items)
	}
	public function reverseIndice():Void {
		// Hace reverse sobre array_items
		array_items.reverse()
	}
	// NUEVO 02/08/2009 15:04
	public function getPos(itemId:String):Number {
		var pos:Number = null
		if (evalExiste(itemId)) {
			pos = Array2.devolverId(array_items, itemId)
		}
		return pos
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}