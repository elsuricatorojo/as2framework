/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 12/03/2009 10:33
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
class com.ionewmedia.utils.timers.Crono {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var id:String
	private var emisor:EmisorExtendido;
	private var crono:Date
	private var tiempoAcumulado:Number = 0
	private var tiempoRef:Number = 0 
	public var iniciado:Boolean = false
	private var pausado:Boolean = false
	//--------------------
	// CONSTRUCTORA:
	public function Crono(_id:String) {
		trace("(Crono.CONSTRUCTORA)!")
		if(_id!=undefined){
			id = _id
		}
		emisor = new EmisorExtendido()
	}
	//--------------------
	// METODOS PUBLICOS:
	public function resetear():Void {
		pausado = false
		tiempoRef = 0
		tiempoAcumulado = 0
		iniciado = false
	}
	public function iniciar():Void {
		trace("(Crono.iniciar): "+id)
		if (!iniciado) {
			iniciado = true
			var cronoTemp:Date = new Date()
			tiempoRef = cronoTemp.getTime()
			//trace(" tiempoRef: " + tiempoRef)
		}else {
			trace("ATENCION: El crono ya está iniciado!")
			
		}
	}
	public function pausar():Void {
		trace("(Crono.pausar): "+id)
		if (iniciado) {
			if (!pausado) {
				pausado=true
				var cronoTemp:Date = new Date()
				var tiempoRef2 = cronoTemp.getTime()
				var avanzado:Number = tiempoRef2 - tiempoRef
				tiempoAcumulado = tiempoAcumulado+avanzado
			}
		}else {
			trace("ATENCION: El crono NO esta iniciado!")
			
		}
	}
	public function reanudar():Void {
		trace("(Crono.reanudar): "+id)
		if (iniciado) {
			if (pausado) {
				pausado=false
				var cronoTemp:Date = new Date()
				tiempoRef = cronoTemp.getTime()
			}
		}else {
			trace("ATENCION: El crono NO esta iniciado!")
		}
	}
	public function getTiempoMil():Number {
		//trace("(Crono.getTiempoMil)!")
		// Devuelve el tiempo transcurrido desde el inicio descontando las pausas
		var tiempoMil:Number
		if (iniciado) {
			if (pausado) {
				tiempoMil = tiempoAcumulado
			}else{
				var cronoTemp:Date = new Date()
				var tiempoRef2 = cronoTemp.getTime()
				var avanzado:Number = tiempoRef2 - tiempoRef
				tiempoMil = tiempoAcumulado+avanzado
			}
		}else {
			//trace("ATENCION: El crono NO esta iniciado!")
			tiempoMil = 0
		}
		//tiempoAcumulado = tiempoMil
		//--
		//trace("(Crono.getTiempoMil) id: " + id + "  mil: " + tiempoMil + "  pausado: " + pausado)
		//trace("   pausado: "+pausado)
		//trace("   tiempoAcumulado: "+tiempoAcumulado)
		//trace("   avanzado: "+avanzado)
		//trace("   tiempoRef: "+tiempoRef)
		//trace("   tiempoRef2: "+tiempoRef2)
		return tiempoMil
	}
	// Getters:
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