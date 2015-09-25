/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070416
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.Emisor;
import com.ionewmedia.utils.estaticas.Object2;
import com.ionewmedia.utils.loaders.CargadorXML;
import com.ionewmedia.utils.componentes.Multibanner.datos.DATA_elementos;
class com.ionewmedia.utils.componentes.Multibanner.logica.LogicaMultibanner
{
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	// Singelton:
	private var emisor:Emisor;
	private var dataElementos:DATA_elementos;
	//--
	//--
	//--
	//--------------------
	// CONSTRUCTORA:
	function LogicaMultibanner()
	{
		trace("(LogicaMultibanner.CONSTRUCTORA)!");
		Trace.trc("(LogicaMultibanner.CONSTRUCTORA)!")
		emisor = new Emisor();
		dataElementos = new DATA_elementos();
	}
	public function init(ruta:String)
	{
		Trace.trc("(LogicaMultibanner.initA)!"+ruta)
		cargar_dataElementos(ruta);
	}
	//--------------------
	// METODOS PUBLICOS:
	function testScope(txt:String)
	{
		//trace("(LogicaMultibanner.testScope) -----> " + txt);
		//trace("   this: " + Object2.traceObject(this, "LogicaMultibanner"));
	}
	public function getDataElementos():Object
	{
		var datos:Object = new Object();
		datos = dataElementos.get_data();
		return datos;
	}
	public function getDataElemento(elemento:String):Object
	{
		var datos:Object = new Object();
		datos = dataElementos.get_dataElemento(elemento);
		return datos;
	}
	public function finPrecarga()
	{
		todoCargado();
	}
	public function finElemento()
	{
		emisor.emitir("onfinElemento");
	}
	//--------------------
	// CARGADORES XML:
	public function cargar_dataElementos(ruta:String)
	{
		trace("cargar_dataElementos()");
		var cargador:CargadorXML = new CargadorXML(ruta, this, "onXMLCargado", "onXMLError");
		//(path, dondeCallBack, eventoOK, eventoKO)
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EVENTOS:
	public function onXMLCargado(objXML:XML)
	{
		Trace.trc("onXMLCargado()"); 
		trace("LogicaMultibanner.onXMLCargado()");
		dataElementos.set_data(objXML);
		emisor.emitir("iniciaAplicacion");
		/*
		dataElementos.set_data(objXML);
		var data:Object = new Object();
		//data = dataElementos.get_data();
		data.id = "datos.xml";
		data.type = "onXmlCargado";
		emisor.emitir_objeto(data);
		//todoCargado( );		
		*/
	}
	private function todoCargado():Void
	{
		emisor.emitir("onTodoCargado");
	}
	//--------------------
	// EMISOR:
	public function addListener(donde:Object):Void
	{
	}
	public function addEventListener(evento:String, donde:Object):Void
	{
		emisor.registrar(evento, donde);
	}
	//--------------------
	// SNIPPETS:
}
