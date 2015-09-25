/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 25/03/2010 21:25
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
//import com.ionewmedia.utils.GUI.IOSlider.Slider
//--
class com.ionewmedia.utils.GUI.IOSlider.DataSlider {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
		public var baseSize:Number // El área donde se mueve el slider
		public var btSize:Number // Alto del botón slider
		public var ratio:Number // {0->1} Factor de la posición del slider respecto al rango
		//public var slider:Slider
		//--
		public var rango:Number // El margen de movimiento del slider
		public var posicion:Number // Posición del botón slider
		public var cobertura:Number // {0->1} Relación entre el tamaño del slider y su rango
		public var propiedad:String
	//--------------------
	// CONSTRUCTORA:
	public function DataSlider(_baseSize:Number, _btSize:Number, _posicion:Number, _ratio:Number, _propiedad:String) {
			baseSize= _baseSize
			btSize = _btSize
			propiedad = _propiedad
			//--
			// Valores deducidos:
			rango = baseSize - btSize
			//--
			if (_posicion != null && _posicion != undefined) {
				//trace("Asignamos posicion, deducimos ratio")
				if (_ratio!= null && _ratio!=undefined) {
					trace("(Slider) ATENCION!! Se ha pasado valor para posicion y ratio. Se descarta el valor de ratio y se deduce desde la posicion.")
				}
				posicion = _posicion
				ratio = posicion / rango
			}else {
				trace("Asignamos ratio, deducimos posicion")
				ratio = _ratio
				posicion = rango*ratio
			}
			cobertura = btSize / baseSize
	}
	//--------------------
	// METODOS PUBLICOS:
	public function clone():DataSlider {
		var newData:DataSlider = new DataSlider(baseSize, btSize, posicion, null, propiedad)
		return newData
	}
	public function toString():String {
		return ("(DataSlider)  baseSize:"+baseSize+"  btSize:"+btSize+"  rango:"+rango+"  posicion:"+posicion+"  ratio:"+ratio+"  cobertura: "+cobertura+"  propiedad: "+propiedad)
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