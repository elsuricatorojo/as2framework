/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070416
*/
class com.ionewmedia.utils.componentes.Multibanner.logica.Cargador
{
	// PARAMETROS:
	private var target_mc:MovieClip;
	private var world:MovieClip;
	private var contenedor_mc:MovieClip;
	private var cargadorElemento:MovieClipLoader;
	private var rutImg:String;
	var tiempo:Number;
	//--------------------
	// CONSTRUCTORA:
	function Cargador()
	{
		trace("(Cargador.CONSTRUCTORA)!");
	}
	//--------------------
	// METODOS PUBLICOS:
	public function cargaImagen(worldP:MovieClip, URL:String, target:MovieClip, deph:Number, tiempoP:Number):Void
	{
		cargadorElemento = new MovieClipLoader();
		cargadorElemento.addListener(this);
		/*
		trace("worldP--->" + worldP);
		trace("url--->" + URL);
		trace("target--->" + target);
		trace("deph--->" + deph);
		trace("tiempoP--->" + tiempoP);
		*/
		world = worldP;
		rutImg = URL;
		target_mc = target;
		tiempo = tiempoP;
		creaHolder(target, deph);
		cargadorElemento.loadClip(URL, contenedor_mc);
		//world.info_mc.info_txt.text = "CARGANDO";
	}
	public function destroy():Void
	{
		//trace("############ destroy---->+"+contenedor_mc+ " ################")
		cargadorElemento.removeListener(this);
		contenedor_mc.removeMovieClip();
	}
	//--------------------
	//--------------------
	// METODOS PRIVADOS:
	private function cargadoOk(target:MovieClip)
	{
		//trace("cargador.elementoCargado"+target+"tiempo---> "+tiempo)
		world.elementoCargadoOk(target, tiempo);
	}
	private function onLoadProgress(target:MovieClip, bytesLoaded:Number, bytesTotal:Number):Void
	{
		//trace("progress--->" + bytesLoaded);
		//world.info_mc.info_txt.text = " CARGANDO " + Math.floor(bytesLoaded / 1024) + "/" + Math.floor(bytesTotal / 1024) + " KB";
	}
	private function onLoadInit(target:MovieClip):Void
	{
		//trace("onLoadInit" + target);
		//world.info_mc.info_txt.text = ""
		cargadoOk(target);
	}
	private function onLoadError(target:MovieClip, errorCode:String):Void
	{
		//trace("load error" + errorCode);
		//world.info_mc.info_txt.text = "Error de carga" + errorCode;
		//world.info_mc.info_txt.text+= newline+"no encuentro el elemento->"+rutImg;
		world.errorCarga();
	}
	private function creaHolder(target:MovieClip, deph:Number):Void
	{
		//trace("target--->"+target)
		//trace("deph--->"+deph)
		contenedor_mc = target_mc.createEmptyMovieClip("elemento_" + deph, deph);
	}
	//--------------------
	// EVENTOS:
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
