/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 27/07/2009 19:55
*/
import com.ionewmedia.utils.estaticas.String2;
class com.ionewmedia.utils.estaticas.Zinc {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	//--------------------
	// CONSTRUCTORA:
	public function Zinc() {
		// NADA
	}
	//--------------------
	// METODOS PUBLICOS:
	static public function eval_zinc():Boolean {
		trace("(Zinc.eval_zinc)!")
		// ATENCION: Poner esto en el init del ROOT:
		// mdm.Application.setEnvVar("init","true");
		// o cualquier otro setEnvVar
		var resultado:Boolean
		var valorEntrada:String = String2.get_randomString(5)
		_level0.mdm.Application.setEnvVar("testScope", valorEntrada);
		var valorSalida:String = _level0.mdm.Application.getEnvVar("testScope");
		if (valorEntrada==valorSalida) {
			resultado = true
		}else {
			resultado = false
		}
		return resultado
	}
}