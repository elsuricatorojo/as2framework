/*
DOCUMENTACION:
* Roberto Ferrero - hola@robertoferrero.es
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 24/06/2013 13:43
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.data.EstadoMC {
	// import com.ionewmedia.utils.data.EstadoMC
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var id:String
	public var x:Number
	public var y:Number
	public var width:Number
	public var height:Number
	public var rotation:Number = 0
	public var xscale:Number = 100
	public var yscale:Number = 100
	public var alpha:Number = 100
	//--------------------
	// CONSTRUCTORA:
	public function EstadoMC(_id:String) {
		trace("(EstadoMC.CONSTRUCTORA)!")
		id = _id
	}
	//--------------------
	// METODOS PUBLICOS:
	public function copiarEstado(ref:MovieClip) {
		x = ref._x
		y = ref._y
		width = ref._width
		height = ref._height
		rotation = ref._rotation
		xscale = ref._xscale
		yscale = ref._yscale
		alpha = ref._alpha
	}
	public function clone(newId:String):EstadoMC {
		var newData:EstadoMC = new EstadoMC(newId)
		newData.x = x
		newData.y = y
		newData.width = width
		newData.height = height
		newData.rotation = rotation
		newData.xscale = xscale
		newData.yscale = yscale
		newData.alpha = alpha
		return newData
	}
	// Getters:
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	/*
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
	*/
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}