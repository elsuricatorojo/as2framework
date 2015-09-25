/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 2008
*/
import com.ionewmedia.utils.data.Datos;
import com.ionewmedia.utils.timers.frameBased.Tempo
import com.ionewmedia.utils.geom.vectores.Fuerza;
import com.ionewmedia.utils.geom.trigonometria.MathUtil
class com.ionewmedia.utils.geom.vectores.fuerzas.GestorAngular {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var data:Datos
	private var reloj:Tempo
	private var enRotacion:Boolean=false
	private var incrementoRotacion:Number=0
	//--------------------
	// CONSTRUCTORA:
	function GestorAngular(){
		trace("(GestorAngular.CONSTRUCTORA)!")
		reloj = Tempo.getInstance()
		reloj.addListener(this)
		data=new Datos()
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevaFuerzaAngular(fuerza:Fuerza, fuerzaId:String) {
		trace("(GestorAngular.nuevaFuerzaAngular): "+fuerzaId)
		data.nuevoItem(fuerzaId, fuerza)
		//--
		var numItems:Number = data.numItems
		trace("   numItems: " + numItems)
		trace("   data.array_items: "+data.array_items)
		var anguloPorcion:Number = 360 / numItems
		trace("   anguloPorcion: " + anguloPorcion)
		for (var i = 0; i < data.array_items.length; i++) {
			var anguloDeg:Number = anguloPorcion * i
			trace("   anguloDeg: "+anguloDeg)
			var fuerzaIdTemp:String=data.array_items[i]
			var fuerzaTemp:Object = data.getItem(fuerzaIdTemp)
			fuerzaTemp.set_anguloDeg(anguloDeg)
		}
	}
	public function rotar(_incrementoRotacion:Number) {
		trace("(GestorAngular.rotar): "+_incrementoRotacion)
		incrementoRotacion = _incrementoRotacion
		if (incrementoRotacion == 0) {
			enRotacion=false
		}else {
			enRotacion=true
		}
	}
	public function set_distancia(distancia:Number) {
		for (var i = 0; i < data.array_items.length; i++) {
			var fuerzaIdTemp:String=data.array_items[i]
			var fuerzaTemp:Object = data.getItem(fuerzaIdTemp)
			fuerzaTemp.DISTANCIA_OPTIMA=distancia
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	private function actualizar() {
		if (enRotacion) {
			actualizarRotacion()
		}
	}
	private function actualizarRotacion() {
		//trace("(GestorAngular.actualizarRotacion): "+incrementoRotacion)
		for (var i = 0; i < data.array_items.length; i++) {
			var fuerzaIdTemp:String=data.array_items[i]
			var fuerzaTemp:Object = data.getItem(fuerzaIdTemp)
			var nuevoAnguloDeg:Number = fuerzaTemp.get_anguloDeg()
			nuevoAnguloDeg = nuevoAnguloDeg + incrementoRotacion
			nuevoAnguloDeg = MathUtil.fixAngle(nuevoAnguloDeg)
			fuerzaTemp.set_anguloDeg(nuevoAnguloDeg)
		}
	}
	//--------------------
	// EVENTOS:
	public function onTempo() {
		actualizar()
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}