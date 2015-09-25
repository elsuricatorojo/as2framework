/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 30/04/2009 12:42
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.data.Datos;
//--
import com.ionewmedia.utils.core.datos.XMLParser_Traductor
class com.ionewmedia.utils.core.logica.Traductor {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private static var inst:Traductor;
	private static var count:Number = 0;
	private static var data: Datos
	private static var _idioma:String = null
	//--------------------
	// CONSTRUCTORA:
	public function Traductor() {
		// emisor = new EmisorExtendido()
		data = new Datos("Traductor")
	}
	// Singelton:
	public static function getInstance ():Traductor{
		if (inst == null)	{
			inst = new Traductor ();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	public static function set_data(objXML:XML):Void {
		trace("(Traductor.set_data)!")
		var parser:XMLParser_Traductor = new XMLParser_Traductor()
		parser.set_data(objXML)
	}
	//--
	static public function nuevoTermino(terminoId:String):Void {
		var existe:Boolean = data.evalExiste(terminoId)
		if (!existe) {
			var obj:Object = new Object()
			obj.idiomas = new Datos("idiomas")
			obj.terminoId = terminoId
			data.nuevoItem(terminoId, obj)
		}else {
			trace("(Traductor.nuevoTermino)!")
			trace("ATENCION: El termino pasado ("+terminoId+") YA existe. No se hace nada.")
		}
	}
	static public function nuevaTraduccion(terminoId:String, idiomaId:String, traduccion:String, remplazar:Boolean) {
		trace("(Traductor.nuevaTraduccion) "+terminoId+"/"+idiomaId+": "+traduccion)
		if (remplazar != true) {
			remplazar = false
		}
		var existe:Boolean =data.evalExiste(terminoId)
		if (!existe) {
			trace("ATENCION: El termino pasado ("+terminoId+") NO existe. Lo creamos.")
			nuevoTermino(terminoId)
		}
		var objTermino:Object = data.getItem(terminoId)
		var existeIdioma:Boolean = objTermino.idiomas.evalExiste(idiomaId)
		var objIdioma:Object
		if (!existeIdioma) {
			objIdioma = new Object()
			objIdioma.idiomaId = idiomaId
			objIdioma.traduccion = traduccion
			objTermino.idiomas.nuevoItem(idiomaId, objIdioma)
		}else {
			objIdioma = objTermino.idiomas.getItem(idiomaId)
			trace("ATENCION: Ya existe una traduccion de ese termino para ese idioma:")
			trace("    terminoId: " + terminoId)
			trace("    idiomaId: " + idiomaId)
			trace("    traduccion existente: " + objIdioma.traduccion)
			trace("    traduccion nueva: " + traduccion)
			if (remplazar) {
				trace("Al ser remplazar=true, remplazamos por la nueva traduccion.")
				objIdioma.traduccion = traduccion
			}else {
				trace("Al ser remplazar=false, dejamos la antigua traduccion.")
			}
		}
	}
	static public function traducir(terminoId):String {
		trace("(Traductor.traducir) terminoId: "+terminoId)
		var traduccion:String
		if (_idioma!=null) {
			var existeTermino:Boolean = data.evalExiste(terminoId)
			var existeIdioma:Boolean
			if (existeTermino) {
				var objTermino:Object = data.getItem(terminoId)
				existeIdioma = objTermino.idiomas.evalExiste(_idioma)
				if (existeIdioma) {
					var objIdioma:Object = objTermino.idiomas.getItem(_idioma)
					traduccion = objIdioma.traduccion
				}else {
					trace("(Traductor.traducir)!")
					trace("   ATENCION: No existe una traduccion para el idioma "+_idioma+" del termino: "+terminoId+".  Se devuelve el código del término.")
					traduccion = terminoId
				}
			}else {
				trace("(Traductor.traducir)!")
				trace("   ATENCION: No existe el termino solicitado ("+terminoId+").  Se devuelve el código del término.")
				traduccion = terminoId
			}
		}else {
			trace("(Traductor.traducir)!")
			trace("   ATENCION: No se ha establecido un idioma. (idioma==null)")
			traduccion = null
		}
		return traduccion
	}
	//--
	// Getters/Setters:
	static public function get idioma():String { return _idioma; }
	
	static public function set idioma(value:String):Void{
		_idioma = value;
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