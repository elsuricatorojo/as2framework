/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20080312
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Array2
import com.ionewmedia.utils.GUI.IOWindows.GestorMinimizadas 
class com.ionewmedia.utils.GUI.IOWindows.GestorVentanas {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var logicaMinimizadas:GestorMinimizadas=null
	// Preferencias:
	public var posXDefault:Number = 100
	public var posYDefault:Number = 100
	public var reposicionarAlRedimensionar:Boolean=true // Indica si al redimensionar el stage las ventanas que se quedan fuera se reposicionan.
	public var posicionarRelativamente:Boolean = true
	public var enmarcar:Boolean = true
	public var margenMarco:Number = 10
	//--
	private var mcRef:MovieClip // MovieClip de referencia sobre se attacharán las ventanas.
	private var emisor:EmisorExtendido
	private var data:Object
	private var stageListener:Object
	//--------------------
	// CONSTRUCTORA:
	function GestorVentanas(_mcRef:MovieClip){
		trace("(GestorVentanas.CONSTRUCTORA)!")
		emisor=new EmisorExtendido()
		mcRef = _mcRef
		data = new Object()
		data.array_items = new Array()
	}
	public function init() {
		trace("(GestorVentanas.init)!")
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevaVentana(ventanaId:String, linkageId:String, dataVentana:Object, posX:Number, posY:Number, familiaId:String):Void {
		trace("(GestorVentanas.nuevaVentana): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		trace("   existe: " + existe)
		trace("   data.array_items: "+data.array_items)
		if (existe) {
			trace("Se ha pedido una nueva ventana que ya existe. La ponemos en foco sin abrir una nueva!!")
			enfocarVentana(ventanaId)
		}else{
			// Acomodamos datos:
			if (posX == null || posX == undefined) {
				posX=posXDefault
			}
			if (posY == null || posY == undefined) {
				posY=posYDefault
			}
			if (dataVentana == undefined) {
				dataVentana=null
			}
			if (familiaId == undefined) {
				familiaId=null
			}
			// Creamos ventana:
			data[ventanaId] = new Object
			data[ventanaId].ventanaId = ventanaId
			data[ventanaId].familiaId = familiaId
			data[ventanaId].linkageId = linkageId
			data[ventanaId].data = dataVentana
			data.array_items.push(ventanaId)
			//--
			mcRef.attachMovie(linkageId, ventanaId, mcRef.getNextHighestDepth())
			mcRef[ventanaId].ventanaId = ventanaId
			mcRef[ventanaId].familiaId = familiaId
			mcRef[ventanaId].linkageId = linkageId
			mcRef[ventanaId].data = dataVentana
			mcRef[ventanaId].posXInicial = posX
			mcRef[ventanaId].posYInicial = posY
			mcRef[ventanaId].logicaVentanas = this
			//--
			var obj:Object = new Object()
			obj.type = "onNuevaVentana"
			obj.ventanaId = ventanaId
			obj.data = dataVentana
			emisor.emitir_objeto(obj);
			//--
			var obj2:Object = new Object()
			obj2.type = "onEnfocarVentana"
			obj2.ventanaId = ventanaId
			emisor.emitir_objeto(obj2);
		}
	}
	public function enfocarVentana(ventanaId:String):Void {
		trace("(GestorVentanas.enfocarVentana): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var posVentana:Number = Array2.devolverId(data.array_items, ventanaId)
			trace("   posVentana: " + posVentana)
			trace("   data.array_items: "+data.array_items)
			if (posVentana<(data.array_items.length-1)) {
				data.array_items = Array2.quitarElem(data.array_items, ventanaId)
				data.array_items.push(ventanaId)
			}else {
				trace("Se ha pedido enfocar una ventana que ya está enfocada!!")
			}
			//--
			reposicionarVentanasEnZ()
			//--
			var obj:Object = new Object()
			obj.type = "onEnfocarVentana"
			obj.ventanaId = ventanaId
			emisor.emitir_objeto(obj)
		}else {
			trace("Se ha pedido enfocar una ventana que no existe!!")
		}
		
	}
	public function cerrarVentana(ventanaId:String):Void {
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			data[ventanaId]=new Object()
			data.array_items = Array2.quitarElem(data.array_items, ventanaId)
			//--
			var obj:Object = new Object()
			obj.type = "onCerrarVentana"
			obj.ventanaId = ventanaId
			emisor.emitir_objeto(obj)
			//--
			var ultimaVentana:String = Array2.getUltimo(data.array_items)
			var obj2:Object = new Object()
			obj2.type = "onEnfocarVentana"
			obj2.ventanaId = ultimaVentana
			emisor.emitir_objeto(obj2)
		}else {
			trace("Se ha pedido cerrar una ventana que no existe!!!")
		}
	}
	public function cerrarTodas():Void {
		var obj:Object = new Object()
		obj.type = "onCerrarTodasVentanas"
		obj.array_items = data.array_items // Mandamos el array por si el proceso de cerrar depende de la posicion de la ventana en el array.
		emisor.emitir_objeto(obj)
		//--
		data = new Object()
		data.array_items = new Object()
	}
	// FOCO:
	public function rotarFoco() {
		// Envía la ventana enfocada al fondo.
		var numVentanas:Number = data.array_items.length
		if(numVentanas>1){
			var ultimaVentana:String = Array2.getUltimo(data.array_items)
			data.array_items = Array2.quitarElem(data.array_items, ultimaVentana)
			data.array_items = Array2.pull(data.array_items, ultimaVentana)
			//--
			reposicionarVentanasEnZ()
			//--
			var nuevaUltima:String= Array2.getUltimo(data.array_items)
			var obj:Object = new Object()
			obj.type = "onEnfocarVentana"
			obj.ventanaId = nuevaUltima
			emisor.emitir_objeto(obj)
		}else {
			trace("Se está intentando rotar el foco pero solo hay "+numVentanas+" ventanas!!")
		}
	}
	public function rotarFocoInverso() {
		// Envía la ventana del fondo al frente.
		var numVentanas:Number = data.array_items.length
		if(numVentanas>1){
			var primeraVentana:String = data.array_items[0]
			data.array_items = Array2.quitarElem(data.array_items, primeraVentana)
			data.array_items.push(primeraVentana)
			//--
			reposicionarVentanasEnZ()
			//--
			var nuevaUltima:String= Array2.getUltimo(data.array_items)
			var obj:Object = new Object()
			obj.type = "onEnfocarVentana"
			obj.ventanaId = nuevaUltima
			emisor.emitir_objeto(obj)
		}else {
			trace("Se está intentando rotar el foco pero solo hay "+numVentanas+" ventanas!!")
		}
	}
	public function enviarFondo(ventanaId:String) {
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var posVentana:Number = Array2.devolverId(data.array_items, ventanaId)
			if (posVentana!=0) {
				data.array_items = Array2.quitarElem(data.array_items, ventanaId)
				data.array_items = Array2.pull(data.array_items, ventanaId)
				//--
				reposicionarVentanasEnZ()
				//--
				var nuevaUltima:String= Array2.getUltimo(data.array_items)
				var obj:Object = new Object()
				obj.type = "onEnfocarVentana"
				obj.ventanaId = nuevaUltima
				emisor.emitir_objeto(obj)
			}else {
				trace("Se ha intentado enviar al fondo una ventana ya en el fondo!!!")
			}
		}else {
			trace("Se está intentando enviar al fondo una ventana que no existe!!!")
		}
	}
	public function enviarFrente(ventanaId:String) {
		enfocarVentana(ventanaId)
	}
	public function eval_enfocada(ventanaId:String):Boolean {
		// Evalua si la ventana está en foco/al frente
		var resultado:Boolean
		var ultima:String = Array2.getUltimo(data.array_items)
		if (ultima == ventanaId) {
			resultado=true
		}else {
			resultado=false
		}
		return resultado
	}
	// POSICION:
	public function crearCascada(inicioX:Number, inicioY:Number, incrementoX:Number, incrementoY:Number, animar:Boolean):Void {
		if (inicioX==null || inicioX==undefined) {
			inicioX=margenMarco
		}
		if (inicioY==null || inicioY==undefined) {
			inicioY=margenMarco
		}
		if (incrementoX==null || incrementoX==undefined) {
			incrementoX=margenMarco
		}
		if (incrementoY==null || incrementoY==undefined) {
			incrementoY=margenMarco
		}
		if (animar==null || animar==undefined) {
			animar=false
		}
		var acumuladoX:Number = inicioX
		var acumuladoY:Number=inicioY
		//--
		for (var i = 0; i < data.array_items.length; i++) {
			var ventanaId:String = data.array_items[i]
			//--
			var obj:Object = new Object()
			obj.type = "onPosicionarVentana"
			obj.ventanaId = ventanaId
			obj.posX = acumuladoX
			obj.posY = acumuladoY
			obj.animar = animar
			emisor.emitir_objeto(obj)
			//--
			acumuladoX += incrementoX
			acumuladoY += incrementoY
		}
	}
	public function centrarVentana(ventanaId:String, ancho:Number, alto:Number, animar:Boolean):Void {
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var posX:Number = Math.round((Stage.width - ancho) / 2)
			var posY:Number = Math.round((Stage.height - alto) / 2)
			//--
			var obj:Object = new Object()
			obj.type = "onPosicionarVentana"
			obj.ventanaId = ventanaId
			obj.posX = posX
			obj.posY = posY
			obj.animar = animar
			emisor.emitir_objeto(obj)
		}else {
			trace("Se está intentando cerrar una ventana que no existe!!")
		}
	}
	public function posicionarVentanaAleatoriamente(ventanaId:String, ancho:Number, alto:Number, animar:Boolean):Void {
		var rangoX:Number = (Stage.width - ancho)
		var rangoY:Number = (Stage.height - alto)
		var posX:Number = Math.round(Math.random()*rangoX)
		var posY:Number = Math.round(Math.random() * rangoY)
		//--
		var obj:Object = new Object()
		obj.type = "onPosicionarVentana"
		obj.ventanaId = ventanaId
		obj.posX = posX
		obj.posY = posY
		obj.animar = animar
		emisor.emitir_objeto(obj)
	}
	// Familias:
	public function cerrarFamilia(familiaId:String):Void {
		var arrayQuitar:Array=new Array()
		for (var i = 0; i < data.array_items.length; i++ ) {
			var ventanaId:String = data.array_items[i]
			var familiaVentana:String = data[ventanaId].familiaId
			if (familiaId == familiaVentana) {
				arrayQuitar.push(ventanaId)
			}
		}
		for (var i = 0; i < arrayQuitar.length; i++ ) {
			var ventanaId:String=arrayQuitar[i]
			data[ventanaId]=new Object()
		}
		data.array_items = Array2.quitarArray(data.array_items, arrayQuitar)
		//--
		var obj:Object = new Object()
		obj.type = "onCerrarFamilia"
		obj.familiaId = familiaId
		obj.array_items = arrayQuitar
		emisor.emitir_objeto(obj)
		//--
		var nuevaUltima:String= Array2.getUltimo(data.array_items)
		var obj2:Object = new Object()
		obj2.type = "onEnfocarVentana"
		obj2.ventanaId = nuevaUltima
		emisor.emitir_objeto(obj2)
	}
	public function enfocarFamilia (familiaId:String):Void {
		var arrayEnfocar:Array=new Array()
		for (var i = 0; i < data.array_items.length; i++ ) {
			var ventanaId:String = data.array_items[i]
			var familiaVentana:String = data[ventanaId].familiaId
			if (familiaId == familiaVentana) {
				arrayEnfocar.push(ventanaId)
			}
		}
		data.array_items = Array2.quitarArray(data.array_items, arrayEnfocar)
		for (var i = 0; i < arrayEnfocar.length; i++ ) {
			var ventanaId:String=arrayEnfocar[i]
			data.array_items.push(ventanaId)
		}
		//--
		reposicionarVentanasEnZ()
		//--
		var nuevaUltima:String= Array2.getUltimo(data.array_items)
		var obj2:Object = new Object()
		obj2.type = "onEnfocarVentana"
		obj2.ventanaId = nuevaUltima
		emisor.emitir_objeto(obj2)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function reposicionarVentanasEnZ() {
		for (var i = 0; i < data.array_items.length; i++) {
			var ventanaId:String = data.array_items[i]
			mcRef[ventanaId].swapDepths(mcRef.getNextHighestDepth())
		}
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		trace("(GestorVentanas.addListener): "+ref)
		emisor.addEventListener("onNuevaVentana", ref);
		emisor.addEventListener("onPosicionarVentana", ref);
		emisor.addEventListener("onEnfocarVentana", ref);
		emisor.addEventListener("onCerrarVentana", ref);
		emisor.addEventListener("onCerrarTodasVentanas", ref);
		emisor.addEventListener("onCerrarFamilia", ref);
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
	// SNIPPETS:
}