/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070416
*/
class com.ionewmedia.utils.componentes.Multibanner.logica.TimeTracer
{
	// PARAMETROS:
	private var donde:MovieClip;
	private var intervalId:Number;
	private var contador:Number;
	private var maxcontador:Number;
	private var duration:Number = 1000;
	//--------------------
	// CONSTRUCTORA:
	function TimeTracer()
	{
	}
	//--------------------
	// METODOS PUBLICOS:
	public function iniciaInterval(duracion:Number, dondeP:MovieClip)
	{
		contador = 0;
		maxcontador = duracion;
		donde = dondeP;
		arrancaInterval();
		if (maxcontador < 1 || maxcontador == undefined)
		{
			clearInterval(intervalId);
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	private function arrancaInterval():Void
	{
		if (intervalId != null)
		{
			//trace("clearInterval");
			clearInterval(intervalId);
		}
		intervalId = setInterval(this, "ejecutaTic", duration);
	}
	private function mataInterval()
	{
	}
	public function ejecutaTic():Void
	{
		//trace("ejecuta Tic: " + intervalId + " contador: " + contador);
		if (contador >= maxcontador)
		{
			clearInterval(intervalId);
			fin();
		}
		contador++;
	}
	public function fin()
	{
		donde.tiempoFinalizado();
		//donde.onfinElemento( );
	}
	//--------------------
	// EMISOR:
}
