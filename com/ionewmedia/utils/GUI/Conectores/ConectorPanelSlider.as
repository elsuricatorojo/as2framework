/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 05/04/2010 19:58
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.GUI.IOPanel.Panel;
import com.ionewmedia.utils.GUI.IOSlider.Slider;
import com.ionewmedia.utils.GUI.IOSlider.DataSlider 
//import com.ionewmedia.utils.estaticas.Array2;
class com.ionewmedia.utils.GUI.Conectores.ConectorPanelSlider {
	// import com.ionewmedia.utils.GUI.Conectores.ConectorPanelSlider
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var panel:Panel
	private var slider:Slider
	private var propiedad:String // {"_x", "_y"}
	private var emisor:EmisorExtendido;
	//--------------------
	// CONSTRUCTORA:
	public function ConectorPanelSlider(_panel:Panel, _slider:Slider, _propiedad:String) {
		trace("(ConectorPanelSlider.CONSTRUCTORA)!")
		panel = _panel
		panel.testScope("(ConectorPanelSlider)")
		panel.addEventListener("onActualizarContenidoPanel", this)
		panel.addEventListener("onInitPanel", this)
		slider = _slider
		slider.testScope("(ConectorPanelSlider)")
		slider.addEventListener("onActualizarSlider", this)
		propiedad = _propiedad
		//--
		emisor = new EmisorExtendido()
	}
	//--------------------
	// METODOS PUBLICOS:
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
	private function onInitPanel(obj:Object) {
		if(propiedad=="_x"){
			var btSize:Number = slider.data.baseSize * obj.ratioAnchos
			var ratio:Number = 1-obj.ratioX
			//trace("   btSize: " + btSize)
			//trace("   ratio: "+ratio)
			var dataSlider:DataSlider = new DataSlider(slider.data.baseSize, btSize, null, ratio)
			slider.actualizarData(dataSlider, true)
		}else if (propiedad == "_y") {
			var btSize:Number = slider.data.baseSize * obj.ratioAltos
			var ratio:Number = 1-obj.ratioY
			//trace("   btSize: " + btSize)
			//trace("   ratio: "+ratio)
			var dataSlider:DataSlider = new DataSlider(slider.data.baseSize, btSize, null, ratio)
			slider.actualizarData(dataSlider, true)
		}
	}
	private function onActualizarContenidoPanel(obj:Object) {
		//trace("(ConectorPanelSlider.onActualizarContenidoPanel): "+propiedad)
		//trace("   obj.anchoPanel: "+obj.anchoPanel)
		//trace("   obj.altoPanel: "+obj.altoPanel)
		//trace("   obj.ratioAnchos: " + obj.ratioAnchos)
		//trace("   obj.ratioAltos: "+obj.ratioAltos)
		//trace("   obj.rangoX: "+obj.rangoX)
		//trace("   obj.ratioX: "+obj.ratioX)
		//trace("   obj.rangoY: "+obj.rangoY)
		//trace("   obj.ratioY: "+obj.ratioY)
		if(propiedad=="_x"){
			var btSize:Number = slider.data.baseSize * obj.ratioAnchos
			var ratio:Number = 1-obj.ratioX
			//trace("   btSize: " + btSize)
			//trace("   ratio: "+ratio)
			var dataSlider:DataSlider = new DataSlider(slider.data.baseSize, btSize, null, ratio)
			slider.actualizarData(dataSlider, true)
		}else if (propiedad == "_y") {
			var btSize:Number = slider.data.baseSize * obj.ratioAltos
			var ratio:Number = 1-obj.ratioY
			//trace("   btSize: " + btSize)
			//trace("   ratio: "+ratio)
			var dataSlider:DataSlider = new DataSlider(slider.data.baseSize, btSize, null, ratio)
			slider.actualizarData(dataSlider, true)
		}
	}
	private function onActualizarSlider(obj:Object) {
		var ratio:Number = 1-obj.data.ratio
		if (propiedad == "_x" && !obj.romperBucle) {
			//trace("(ConectorPanelSlider.onActualizarSlider): " + propiedad)
			panel.actualizarRatioX(ratio)
		}else if (propiedad == "_y" && !obj.romperBucle) {
			panel.actualizarRatioY(ratio)
		}
	}
	//--------------------
	// SNIPPETS:
}