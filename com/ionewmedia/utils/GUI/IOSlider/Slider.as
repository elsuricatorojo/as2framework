/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@ionewmedia.com || roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 25/03/2010 21:05
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
//import com.ionewmedia.utils.estaticas.Array2;
import com.ionewmedia.utils.GUI.IOSlider.DataSlider 
//--
class com.ionewmedia.utils.GUI.IOSlider.Slider {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var id:String = null
	//--
	private var emisor:EmisorExtendido;
	//--
	public var data:DataSlider // Solo READ
	//--------------------
	// CONSTRUCTORA:
	public function Slider() {
		trace("(Slider.CONSTRUCTORA)!")
		//--
		emisor = new EmisorExtendido()
		//--
		
	}
	public function init(dataInicial:DataSlider) {
		trace("(Slider.init)!")
		data = dataInicial
		var obj:Object = new Object()
		obj.type = "onInicializarSlider"
		obj.id = id
		obj.data = data
		emisor.emitir_objeto(obj)
	
	}
	public function testScope(txt:String) {
		trace("(Slider.testScope) ------------------ "+txt)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function comenzarDrag(newData:DataSlider) {
		trace("(Slider.comenzarDrag)!")
	}
	public function pararDrag(newData:DataSlider) {
		trace("(Slider.comenzarDrag)!")
	}
	public function actualizarData(newData:DataSlider, romperBucle:Boolean) {
		//trace("(Slider.actualizarData): " + newData)
		if (romperBucle== null || romperBucle==undefined) {
			romperBucle = false
		}
		data = newData
		var obj:Object = new Object()
		obj.type = "onActualizarSlider"
		obj.id = id
		obj.data = data
		obj.romperBucle = romperBucle
		emisor.emitir_objeto(obj)
	}
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento, ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento, ref);
	}
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}