/*
DOCUMENTACION:
- traceObject(obj:Object, id:String):Void
Hacer un trace del contenido del objeto.
*
* io newmedia S.L. - http://www.zona-io.com  
* roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
import tv.zarate.Utils.Trace;
class com.ionewmedia.utils.estaticas.Object2 {
	static function traceObject(o:Object, i:String) {
		// Hace un trace de todas las propiedades de un objeto
		trace("========================");
		trace("   "+i+":");
		for (var p in o) {
			trace("     "+p+": "+o[p]+"  typeOf: "+typeof (o[p]));
		}
		trace("========================");
	}
	static function zlogTrace(o:Object, i:String) {
		// NUEVO: 20061017
		// Hace un trace de todas las propiedades de un objeto en:
		// 1) la ventan de salida
		// 2) la consola de Zarate (zLog)
		Trace.trc("========================");
		//trace("   "+i+":");
		Trace.trc("   "+i+":");
		for (var p in o) {
			//trace("     "+p+": "+o[p]+"  typeOf: "+typeof (o[p]));
			Trace.trc("     "+p+": "+o[p]+"  typeOf: "+typeof (o[p]));
		}
		Trace.trc("========================");
	}
	static function copiarObjeto(obj:Object):Object {
		// Nuevo: 07/05/2008 11:16
		// Devuelve una copia de un objeto para evitar suscripciones
		// Realmente util cuando lo parametros del objeto son de tipo sencillo (String, Number, Boolean)
		var nuevoObj:Object = new Object()
		for (var param in obj) {
			nuevoObj[param]=obj[param]
		}
		return  nuevoObj
	}
}
