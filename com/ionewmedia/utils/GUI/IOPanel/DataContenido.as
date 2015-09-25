/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 02/04/2010 12:53
*/
import com.ionewmedia.utils.geom.Punto;
//--
class com.ionewmedia.utils.GUI.IOPanel.DataContenido {
	// import com.ionewmedia.utils.GUI.IOPanel.DataContenido
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var ancho:Number
	public var alto:Number
	public var posicion:Punto = null
	//public var puntoAplicacion:Punto = null
	//--------------------
	// CONSTRUCTORA:
	public function DataContenido(_ancho:Number, _alto:Number, _posicion:Punto) {
		//trace("(DataContenido.CONSTRUCTORA)!")
		ancho = _ancho
		alto = _alto
		if(_posicion!=null){
			posicion = _posicion
		}
		/*
		if(_puntoAplicacion!=null){
			puntoAplicacion = _puntoAplicacion
		}
		*/
	}
	//--------------------
	// METODOS PUBLICOS:
	public function clone():DataContenido {
		var newData:DataContenido = new DataContenido(ancho, alto, posicion.clone())
		return newData
	}
	public function toString():String {
		return ("DataContenido. ancho: "+ancho+"  alto: "+alto+" "+posicion)
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