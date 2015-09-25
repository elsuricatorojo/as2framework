/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 03/07/2009 9:52
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.timers.Crono;
//--
class com.ionewmedia.utils.core.logica.Fecha {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	// Singelton:
	private static var inst:Fecha;
	private static var count:Number = 0;
	//--
	private var crono:Crono
	private var fechaRef:Date
	//--------------------
	// CONSTRUCTORA:
	public function Fecha() {
		trace("(Fecha.CONSTRUCTORA)!")
		crono = new Crono("crono_fecha")
	}
	public static function getInstance ():Fecha{
		if (inst == null)	{
			inst = new Fecha ();
		}
		++count;
		return inst;
	}
	//--------------------
	// METODOS PUBLICOS:
	public function init(fechaActual:String) {
		trace("(Fecha.init): " + fechaActual)
		// fechaActual (opcional):indica con formato aammddhhmmss la hora/fecha actual.
		// Si no se pasa se toma la del ordenador que ejecute el swf.
		set_fechaRef(fechaActual)
		crono.iniciar()
	}
	public function get_fechaRef():Date {
		return fechaRef
	}
	public function get_fechaActual():Date {
		var fechaActual:Date = new Date()
		var secsAvanzados:Number = crono.getTiempoMil()
		var timeRef:Number = fechaRef.getTime()
		var timeActual:Number = timeRef + secsAvanzados
		fechaActual.setTime(timeActual)
		//trace("   fechaRef: " + fechaRef)
		//trace("   fechaActual: "+fechaActual)
		return fechaActual
	}
	public function get_diasDiferencias(fechaString:String):Number {
		// Devuelve el numero de dias entre la fecha actual y la pasada
		// NUEVO: 09/07/2009 22:15
		trace("(Fecha.get_diasDiferencias): " + fechaString)
		fechaString = String(fechaString)
		var ano = Number(fechaString.slice(0,4))
		var mes = Number(fechaString.slice(4,6))
		var dia = Number(fechaString.slice(6,8))
		var hora = Number(fechaString.slice(8,10))
		var min = Number(fechaString.slice(10, 12))
		trace("   ano: " + ano)
		trace("   mes: " + mes)
		trace("   dia: " + dia)
		trace("   hora: " + hora)
		trace("   min: " + min)
		var fechaTemp:Date = new Date(ano, (mes - 1), dia, hora, min, 0) // Datde de la fecha pasada
		var timeFechaTemp:Number = fechaTemp.getTime() // time de la fechas pasada
		//--
		var fechaActual:Date = get_fechaActual() // Date actual
		var timeActual:Number = fechaActual.getTime() // Time Actual
		//--
		var lapsoMil:Number = Math.abs(timeFechaTemp - timeActual) // Diferencia absoluta entre las 2 fechas
		var diaMil:Number = Date.UTC(1970, 0, 2, 0, 0, 0, 0) // Milisegundos en un dia
		var diasDif:Number = lapsoMil / diaMil // Dieas en el lapso calculado.
		// Vemos el signo. Positivo es que la fecha pasada es del pasado, y negativo es que la fecha pasada es del futuro.
		if (timeFechaTemp<timeActual) {
			diasDif = -diasDif
		}
		//--
		return diasDif
	}
	public function get_arrayFecha():Array {
		// arrayFecha: ano,mes,dia,hora,min,sec
		var fechaActual:Date = get_fechaActual()
		var arrayFecha:Array = new Array()
		arrayFecha[0] = fechaActual.getFullYear()
		arrayFecha[1] = (fechaActual.getMonth() + 1)
		arrayFecha[2] = fechaActual.getDate()
		arrayFecha[3] = fechaActual.getHours()
		arrayFecha[4] = fechaActual.getMinutes()
		arrayFecha[5] = fechaActual.getSeconds()
		return arrayFecha
	}
	public function getEdad(fechaString:String):Number {
		// NUEVO: 11/07/2009 21:03
		var edad:Number = null
		var anoRef = Number(fechaString.slice(0,4))
		var mesRef = Number(fechaString.slice(4,6))
		var diaRef = Number(fechaString.slice(6,8))
		var horaRef = Number(fechaString.slice(8,10))
		var minRef = Number(fechaString.slice(10, 12))
		//--
		var fechaNacimiento:Date = new Date(anoRef, (mesRef - 1), diaRef, horaRef, minRef, 0)
		var anoNacimiento:Number = fechaNacimiento.getFullYear()
		//--
		var fechaActual:Date = get_fechaActual()
		var timeActual:Number = fechaActual.getTime()
		//--
		var fechaTemp:Date
		var timeTemp:Number
		var contadorAnos:Number = 0
		var edadDetectada:Boolean = false
		do { 
			var fechaTemp:Date = cloneDate(fechaNacimiento)
			fechaTemp.setFullYear(anoNacimiento + contadorAnos)
			timeTemp = fechaTemp.getTime()
			//trace("---")
			//trace("   contadorAnos: " + contadorAnos)
			//trace("   timeTemp: " + timeTemp)
			//trace("   timeActual: "+timeActual)
			if (timeTemp >= timeActual) {
				edadDetectada = true
			}else {
				contadorAnos++
			}
		} 
		while (!edadDetectada);
		//--
		edad = contadorAnos-1
		return edad
	}
	public function evalMayorDeEdad(fechaString:String):Boolean {
		// Evalua si respecto a la fechaRef la fecha pasa implica mas de 18 años de diferencia.
		var esMayorDeEdad:Boolean = false
		var anoRef = Number(fechaString.slice(0,4))
		var mesRef = Number(fechaString.slice(4,6))
		var diaRef = Number(fechaString.slice(6,8))
		var horaRef = Number(fechaString.slice(8,10))
		var minRef = Number(fechaString.slice(10, 12))
		//--
		var fechaNacimiento:Date = new Date(anoRef, (mesRef - 1), diaRef, horaRef, minRef, 0)
		var anoNacimiento:Number = fechaNacimiento.getFullYear()
		//--
		var fechaMayorDeEdad:Date = cloneDate(fechaNacimiento)
		fechaMayorDeEdad.setFullYear(anoNacimiento + 18)
		//--
		var timeRef:Number = fechaRef.getTime()
		var timeMayorDeEdad:Number = fechaMayorDeEdad.getTime()
		//--
		trace("---")
		trace("   timeRef: " + timeRef)
		trace("   timeMayorDeEdad: "+timeMayorDeEdad)
		//--
		if (timeRef>=timeMayorDeEdad) {
			esMayorDeEdad = true
		}
		trace("   esMayorDeEdad: "+esMayorDeEdad)
		return esMayorDeEdad
	}
	public function get_mesesHasta(fechaHasta:Date):Number {
		trace("(Fecha.get_mesesHasta)!")
		// Devuelve el numero de meses enteros (Math.floor) que hay entre la fecha pasada y la actual.
		var fechaActual:Date = get_fechaActual()
		var fechaTemp:Date = cloneDate(fechaActual)
		//--
		fechaTemp = quitarHorasYMin(fechaTemp)
		fechaHasta = quitarHorasYMin(fechaHasta)
		//--
		trace("   fechaTemp: " + fechaTemp)
		trace("   fechaHasta: "+fechaHasta)
		//--
		var contadorMeses:Number = 0
		var sobrepasado:Boolean = false
		//--
		do {
			contadorMeses++
			var mesTemp:Number = fechaTemp.getMonth()
			var anoTemp:Number = fechaTemp.getFullYear()
			//trace("   mesTemp: " + mesTemp)
			//trace("   anoTemp: "+anoTemp)
			fechaTemp.setMonth(fechaTemp.getMonth() + 1)
			trace("   fechaTemp.getTime(): " + fechaTemp.getTime())
			trace("   fechaHasta.getTime(): " + fechaHasta.getTime())
			var valorTemp = Math.floor(fechaTemp.getTime() / 10000)
			var valorHasta = Math.floor(fechaHasta.getTime() / 10000)
			trace("   valorTemp: " + valorTemp)
			trace("   valorHasta: " + valorHasta)
			if (valorTemp > valorHasta) {
				sobrepasado=true
			}
		} while (!sobrepasado);
		//--
		contadorMeses = contadorMeses-1
		return contadorMeses
	}
	public function get_restoDiasHasta(fechaHasta:Date):Number {
		trace("(Fecha.get_restoDiasHasta)!")
		// Devuelve, una vez quitados los meses enteros, los dias enteros entre la fecha pasada y la actual.
		// Ejemplo si hoy es 20090804 y paso 20091114 devuelve 10 dias.
		var fechaActual:Date = cloneDate(get_fechaActual())
		var fechaMesEnetro:Date = cloneDate(fechaActual)
		//--
		fechaActual = quitarHorasYMin(fechaActual)
		fechaMesEnetro = quitarHorasYMin(fechaMesEnetro)
		fechaHasta = quitarHorasYMin(fechaHasta)
		var mesesHasta:Number = get_mesesHasta(fechaHasta)
		//--
		for (var i = 0; i < mesesHasta; i++ ) {
			//trace(i)
			fechaMesEnetro.setMonth(fechaMesEnetro.getMonth() + 1)
		}
		//--
		trace("   fechaActual: "+fechaActual)
		trace("   fechaHasta: "+fechaHasta)
		trace("   fechaMesEnetro': " + fechaMesEnetro)
		//--
		var timeMesEnetro:Number = fechaMesEnetro.getTime()
		var timeHasta:Number = fechaHasta.getTime()
		//--
		var lapsoMil:Number = Math.abs(timeHasta - timeMesEnetro) // Diferencia absoluta entre las 2 fechas
		var diaMil:Number = Date.UTC(1970, 0, 2, 0, 0, 0, 0) // Milisegundos en un dia
		var diasDif:Number = lapsoMil / diaMil // Dias en el lapso calculado.
		// Vemos el signo. Positivo es que la fecha pasada es del pasado, y negativo es que la fecha pasada es del futuro.
		if (timeHasta<timeMesEnetro) {
			diasDif = -diasDif
		}
		//--
		return diasDif
	}
	private function quitarHorasYMin(fecha:Date):Date {
		var fechaTemp:Date = cloneDate(fecha)
		fechaTemp.setHours(0)
		fechaTemp.setMinutes(0)
		fechaTemp.setSeconds(0)
		fechaTemp.getMilliseconds(0)
		return fechaTemp
	}
	// UTILS:
	public function dateToString(fechaTemp:Date):String {
		var ano:String = String(fechaTemp.getFullYear())
		var mes:String = filtrarNum(fechaTemp.getMonth() + 1)
		var dia:String = filtrarNum(fechaTemp.getDate())
		var hora:String = filtrarNum(fechaTemp.getHours())
		var min:String = filtrarNum(fechaTemp.getMinutes())
		var fechaString:String = ano + mes + dia + hora + min
		return fechaString
	}
	public function stringToDate(fechaString:String):Date {
		var ano = Number(fechaString.slice(0,4))
		var mes = Number(fechaString.slice(4,6))
		var dia = Number(fechaString.slice(6,8))
		var hora = Number(fechaString.slice(8,10))
		var min = Number(fechaString.slice(10, 12))
		var fechaTemp:Date = new Date(ano, (mes - 1), dia, hora, min, 0) // Date de de la fecha pasada
		return fechaTemp
	}
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	private function filtrarNum(valor:Number):String {
		var cadena:String = String(valor)
		if (valor < 10) {
			cadena = "0"+cadena
		}
		return cadena
	}
	private function set_fechaRef(fechaString:String) {
		trace("(Fecha.set_fechaRef): " + fechaString)
			if(fechaString!=null && fechaString!=undefined){
			var anoRef = Number(fechaString.slice(0,4))
			var mesRef = Number(fechaString.slice(4,6))
			var diaRef = Number(fechaString.slice(6,8))
			var horaRef = Number(fechaString.slice(8,10))
			var minRef = Number(fechaString.slice(10, 12))
			//--
			trace("   anoRef: " + anoRef)
			trace("   mesRef: " + mesRef)
			trace("   diaRef: " + diaRef)
			trace("   horaRef: " + horaRef)
			trace("   minRef: " + minRef)
			//--
			fechaRef = new Date(anoRef, (mesRef - 1), diaRef, horaRef, minRef, 0)
		}else {
			trace("ATENCIO! No se ha pasado fecha por lo que se toma la del ordenador")
			fechaRef = new Date()
		}
		//--	
	}
	private function cloneDate(date:Date):Date {
		var clonedDate:Date = new Date()
		clonedDate.setTime(date.getTime())
		return clonedDate
	}
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}