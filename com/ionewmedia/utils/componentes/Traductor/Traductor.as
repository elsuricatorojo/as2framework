/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070611
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;	
import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.componentes.Traductor.XMLParser_idioma;
class com.ionewmedia.utils.componentes.Traductor.Traductor {
	//--------------------
	// DOCUMENTACION:
	// Singelton:
	private static var inst:Traductor;
	private static var count:Number = 0;
	//--
	private static var idiomas:Object;
	private static var idiomaSeleccionado:String;
	private static var sobreEscibir:Boolean = true;
	//--------------------
	// PARAMETROS:
	static private var emisor:EmisorExtendido
	//--------------------
	// CONSTRUCTORA:
	function Traductor() {
		trace("(Traductor.CONSTRUCTORA)!");
		emisor = new EmisorExtendido()
		init_idiomas();
	}
	public static function getInstance():Traductor {
		if (inst == null) {
			inst = new Traductor();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	// GETTERS:
	public function get_idiomaSeleccionado():String {
		return idiomaSeleccionado;
	}
	public static function traducir(textoId:String):String {
		var traduccion:String = idiomas[idiomaSeleccionado].get_texto(textoId);
		//trace("(Traductor.traducir): ("+idiomaSeleccionado+")"+textoId+" >> "+traduccion);
		if (traduccion==undefined) {
			traduccion="**"+textoId+"**"
		}
		return (traduccion);
	}
	// SETTERS:
	public function set_idiomaSeleccionado(idiomaId:String):Void {
		trace("(Traductor.set_idiomaSeleccionado): "+idiomaId);
		idiomaSeleccionado = idiomaId;
				//--
		var obj:Object = new Object()
		obj.type = "onNuevoIdiomaSeleccionado"
		obj.idiomaSel = idiomaSeleccionado
		emisor.emitir_objeto(obj)
	}
	public function set_idioma(idiomaId:String, dataXml:XML):Void {
		trace("(Traductor.set_idioma): "+idiomaId);
		var existe:Boolean = Array2.estaEnElArray(idiomas.array_items, idiomaId);
		if (existe) {
			add_terminos(idiomaId, dataXml);
		} else {
			nuevo_idioma(idiomaId, dataXml);
		}
	}
	public function set_sobreEscibir(valor:Boolean) {
		// Determina si en caso de cargar nuevos terminos y alguno coincide con
		// un código existente, sobre-escribirlo o der el original
		sobreEscibir = valor;
	}
	public function mostrar_terminos() {
		for (var i = 0; i<idiomas.array_items.length; i++) {
			var idiomaId:String = idiomas.array_items[i];
			trace("=================================");
			trace("IDIOMA: "+idiomaId);
			idiomas[idiomaId].mostrar_terminos();
			trace("=================================");
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	private function init_idiomas():Void {
		idiomas = new Object();
		idiomas.array_items = new Array();
	}
	private function nuevo_idioma(idiomaId:String, dataXml:XML):Void {
		trace("(Traductor.nuevo_idioma): "+idiomaId);
		idiomas.array_items.push(idiomaId);
		trace("   idiomas.array_items:"+idiomas.array_items)
		idiomas[idiomaId] = new XMLParser_idioma();
		idiomas[idiomaId].testScope("Traductor añadiendo el idioma: "+idiomaId)
		idiomas[idiomaId].set_data(dataXml);
		idiomas[idiomaId].set_sobreEscibir(sobreEscibir);
		idiomas[idiomaId].mostrar_terminos();
	}
	private function add_terminos(idiomaId:String, dataXml:XML):Void {
		trace("(Traductor.add_terminos): "+idiomaId);
		// Añade traducciones a las ya existentes
		idiomas[idiomaId].add_terminos(dataXml);
		idiomas[idiomaId].mostrar_terminos();
	}
	//--------------------
	// EMISOR:
	public static function addListener(ref:Object) {
		emisor.addEventListener("onNuevoIdiomaSeleccionado", ref)
	}
	public static  function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public static  function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// SNIPPETS:
}
