
/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 01/03/2010 22:23
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.geom.vectores.Vector
import com.ionewmedia.utils.geom.vectores.Fuerza;
//--
class com.ionewmedia.utils.geom.vectores.fuerzas.Gravedad implements Fuerza{
	// import com.ionewmedia.utils.geom.vectores.fuerzas.Gravedad
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	private var gravedad:Number = 10
	private var fuerzaG:Vector
	//--------------------
	// CONSTRUCTORA:
	public function Gravedad(_gravedad:Number) {
		trace("(Gravedad.CONSTRUCTORA)!")
		if (_gravedad != undefined && _gravedad!= null) {
			gravedad=_gravedad
		}
		emisor = new EmisorExtendido()
		//--
		fuerzaG = new Vector(gravedad, 90)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function sumarFuerza(vector:Vector):Vector {
		trace("(Gravedad.sumarFuerza)!")
		trace("   vector: "+vector)
		var resultante:Vector = vector.clone()
		resultante.sumarVector(fuerzaG)
		trace("   resultante: "+resultante)
		return resultante
	}
	public function getFuerza():Vector {
		return fuerzaG
	}
	//--
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		//emisor.addEventListener("onActivarIman", ref);
		//emisor.addEventListener("onDesactivarIman", ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento, ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento, ref);
	}
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}