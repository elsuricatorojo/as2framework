/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070719
*/
import com.ionewmedia.utils.componentes.Traductor.Traductor;
class com.ionewmedia.utils.componentes.Traductor.AutoTraductor {
	static function traducir(ref:MovieClip, prefijo:String) {
		// dado un movieClip de referencia la función rastrea todas las entidades,
		// detectando aquellas que sean textField* y que tengan un prefijo que coincida con
		// el pasado como parametro, en cuyo caso toma el nombre del TextField como código de traducción
		// y lo traduce llamando al Traductor.
		trace("(AutoTraductor.traducir): "+prefijo);
		var traductor:Traductor = Traductor.getInstance();
		traductor.mostrar_terminos()
		for (var entidades in ref) {
			var entidad:Object = ref[entidades];
			var tipo:String = typeof (entidad);
			var cadena = entidades.toString();
			var arrayAux:Array = cadena.split("_");
			var prefijoEntidad:String = arrayAux[0];
			var sizeArrayAux:Number = arrayAux.length;
			if (tipo == "object" && prefijoEntidad == prefijo && sizeArrayAux>1) {
				var traduccion:String = Traductor.traducir(cadena);
				entidad.text = traduccion;
			}
		}
	}
}
