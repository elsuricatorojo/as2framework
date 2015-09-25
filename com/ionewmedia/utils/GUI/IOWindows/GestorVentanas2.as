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
//--
import com.ionewmedia.utils.GUI.IOWindows.GestorMinimizadas
//--
class com.ionewmedia.utils.GUI.IOWindows.GestorVentanas2 {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	// Preferencias:
	public var posXDefault:Number = 100
	public var posYDefault:Number = 100
	public var reposicionarAlRedimensionar:Boolean=true // Indica si al redimensionar el stage las ventanas que se quedan fuera se reposicionan.
	public var posicionarRelativamente:Boolean = true
	public var enmarcar:Boolean = true
	public var margenMarco:Number = 10
	//--
	public var logicaMinimizadas:GestorMinimizadas
	//--
	private var mcRef:MovieClip // MovieClip de referencia sobre se attacharán las ventanas.
	private var emisor:EmisorExtendido
	private var data:Object
	private var stageListener:Object
	//--------------------
	// CONSTRUCTORA:
	function GestorVentanas2(_mcRef:MovieClip){
		trace("(GestorVentanas2.CONSTRUCTORA)!")
		emisor = new EmisorExtendido()
		logicaMinimizadas = new GestorMinimizadas()
		logicaMinimizadas.addListener(this)
		mcRef = _mcRef
		data = new Object()
		data.array_items = new Array()
		data.array_minimizadas = new Array()
		data.array_maximizadas = new Array()
		data.array_familias = new Array()
	}
	public function init() {
		trace("(GestorVentanas2.init)!")
	}
	public function testScope(txt:String):Void {
		trace("(GestorVentanas2.testScope) ------------ "+txt)
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevaVentana(ventanaId:String, linkageId:String, dataVentana:Object, posX:Number, posY:Number, familiaId:String):Void {
		trace("(GestorVentanas2.nuevaVentana): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		trace("   linkageId: " + linkageId)
		trace("   familiaId: " + familiaId)
		trace("   posX: " + posX)
		trace("   posY: " + posY)
		trace("   existe: " + existe)
		trace("   data.array_items: "+data.array_items)
		if (existe) {
			trace("Se ha pedido una nueva ventana que ya existe. La ponemos en foco sin abrir una nueva!!")
			var estaMinimizada:Boolean = Array2.estaEnElArray(data.array_minimizadas, ventanaId)
			if (estaMinimizada) {
				restaurar(ventanaId)
			}else {
				enfocarVentana(ventanaId)
			}
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
			//--
			data[ventanaId].maximizada = true
			data[ventanaId].posX_restaurada = posX
			data[ventanaId].posY_restaurada = posY
			//--
			data.array_items.push(ventanaId)
			data.array_maximizadas.push(ventanaId)
			//--
			mcRef.attachMovie(linkageId, ventanaId, mcRef.getNextHighestDepth())
			mcRef[ventanaId].ventanaId = ventanaId
			mcRef[ventanaId].familiaId = familiaId
			mcRef[ventanaId].linkageId = linkageId
			mcRef[ventanaId].data = dataVentana
			mcRef[ventanaId].posXInicial = posX
			mcRef[ventanaId].posYInicial = posY
			mcRef[ventanaId].maximizada = true
			mcRef[ventanaId].logicaVentanas = this
			//--
			var obj:Object = new Object()
			obj.type = "onNuevaVentana"
			obj.ventanaId = ventanaId
			obj.data = dataVentana
			emisor.emitir_objeto(obj);
			//--
			actualizar_arrayFamilias()
			reposicionarVentanasEnZ()
			enfocarUltimaMaximizada()
			//--
			trace("   data.array_familias: "+data.array_familias)
		}
	}
	public function enfocarVentana(ventanaId:String):Void {
		trace("(GestorVentanas2.enfocarVentana): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var maximizada:Boolean = eval_maximizada(ventanaId)
			if(maximizada){
				var posVentana:Number = Array2.devolverId(data.array_items, ventanaId)
				if (posVentana<(data.array_items.length-1)) {
					data.array_items = Array2.quitarElem(data.array_items, ventanaId)
					data.array_items.push(ventanaId)
					data.array_maximizadas = Array2.quitarElem(data.array_maximizadas, ventanaId)
					data.array_maximizadas.push(ventanaId)
					//--
					reposicionarVentanasEnZ()
					enfocarUltimaMaximizada()
				}else {
					trace("Se ha pedido enfocar una ventana que ya está enfocada!!")
				}
				
			}else {
				trace("Se ha pedido enfocar una ventana que está minimizada!!")
			}
		}else {
			trace("Se ha pedido enfocar una ventana que no existe!!")
		}
	}
	public function cerrarVentana(ventanaId:String):Void {
		trace("(GestorVentanas2.cerrarVentana): "+ventanaId)
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var maximizada:Boolean = eval_maximizada(ventanaId)
			if (maximizada) {
				data.array_maximizadas = Array2.quitarElem(data.array_maximizadas, ventanaId)
			}else {
				data.array_minimizadas = Array2.quitarElem(data.array_minimizadas, ventanaId)
			}
			//--
			data[ventanaId]=new Object()
			data.array_items = Array2.quitarElem(data.array_items, ventanaId)
			//--
			logicaMinimizadas.cerrarVentana(ventanaId)
			//--
			var obj:Object = new Object()
			obj.type = "onCerrarVentana"
			obj.ventanaId = ventanaId
			emisor.emitir_objeto(obj)
			//--
			actualizar_arrayFamilias()
			reposicionarVentanasEnZ()
			enfocarUltimaMaximizada()
		}else {
			trace("Se ha pedido cerrar una ventana que no existe!!!")
		}
	}
	public function cerrarTodas():Void {
		var arrayAux:Array=Array2.copiaDeEsteArray(data.array_items)
		//--
		data = new Object()
		data.array_items = new Array()
		data.array_maximizadas = new Array()
		data.array_minimizadas = new Array()
		//--
		logicaMinimizadas.cerrarTodas()
		//--
		var obj:Object = new Object()
		obj.type = "onCerrarTodasVentanas"
		obj.array_items = arrayAux // Mandamos el array por si el proceso de cerrar depende de la posicion de la ventana en el array.
		emisor.emitir_objeto(obj)
		//--
		actualizar_arrayFamilias()
		reposicionarVentanasEnZ()
		enfocarUltimaMaximizada()
	}
	// FOCO:
	public function rotarFoco() {
		// Envía la ventana enfocada al fondo de las maximizadas.
		var numVentanas:Number = data.array_maximizadas.length
		if (numVentanas > 1) {
			var numMinimizadas:Number=data.array_minimizadas.length
			var ultimaVentana:String = Array2.getUltimo(data.array_maximizadas)
			data.array_items = Array2.quitarElem(data.array_items, ultimaVentana)
			data.array_items = Array2.insertar(data.array_items, ultimaVentana, numMinimizadas)
			data.array_maximizadas = Array2.quitarElem(data.array_maximizadas, ultimaVentana)
			data.array_maximizadas = Array2.pull(data.array_maximizadas, ultimaVentana)
			//--
			reposicionarVentanasEnZ()
			enfocarUltimaMaximizada()
		}else {
			trace("Se está intentando rotar el foco pero solo hay "+numVentanas+" ventanas maximizadas!!")
		}

	}
	public function rotarFocoInverso() {
		// Envía la ventana del fondo al frente.
		var numVentanas:Number = data.array_maximizadas.length
		if (numVentanas > 1) {
			var primeraVentanaMaximizada:String = data.array_maximizadas[0]
			data.array_items = Array2.quitarElem(data.array_items, primeraVentanaMaximizada)
			data.array_items.push(primeraVentanaMaximizada)
			data.array_maximizadas = Array2.quitarElem(data.array_maximizadas, primeraVentanaMaximizada)
			data.array_maximizadas.push(primeraVentanaMaximizada)
			//--
			reposicionarVentanasEnZ()
			enfocarUltimaMaximizada()
		}else {
			trace("Se está intentando rotar el foco (inverso) pero solo hay " + numVentanas + " ventanas maximizadas!!")
		}
	}
	public function enviarFondo(ventanaId:String) {
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var maximizada:Boolean = eval_maximizada(ventanaId)
			if (maximizada) {
				var posVentana:Number = Array2.devolverId(data.array_maximizadas, ventanaId)
				if (posVentana != 0) {
					var numMinimizadas:Number=data.array_minimizadas.length
					data.array_items = Array2.quitarElem(data.array_items, ventanaId)
					data.array_items = Array2.insertar(data.array_items, ventanaId, numMinimizadas)
					data.array_maximizadas = Array2.quitarElem(data.array_maximizadas, ventanaId)
					data.array_maximizadas = Array2.pull(data.array_maximizadas, ventanaId)
					//--
					reposicionarVentanasEnZ()
					enfocarUltimaMaximizada()
					
				}else {
					trace("Se ha intentado enviar al fondo una ventana ya en el fondo!!!")
				}
			}else {
				trace("Se ha intentado enviar al fondo una ventana que está minimizada!!!")
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
	public function eval_maximizada(ventanaId:String):Boolean {
		var maximizada:Boolean = Array2.estaEnElArray(data.array_maximizadas, ventanaId)
		return maximizada
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
		for (var i = 0; i < data.array_maximizadas.length; i++) {
			var ventanaId:String = data.array_maximizadas[i]
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
			var maximizada:Boolean = eval_maximizada(ventanaId)
			if(maximizada){
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
				trace("Se está intentando centrar una ventana que está minimizada!!")
			}
		}else {
			trace("Se está intentando centrar una ventana que no existe!!")
		}
	}
	public function posicionarVentanaAleatoriamente(ventanaId:String, ancho:Number, alto:Number, animar:Boolean):Void {
		var existe:Boolean = Array2.estaEnElArray(data.array_items, ventanaId)
		if (existe) {
			var maximizada:Boolean = eval_maximizada(ventanaId)
			if(maximizada){
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
			}else {
				trace("Se está intentando posicionar aleatoriamente una ventana que minimizada!!")
			}
		}else {
			trace("Se está intentando posicionar aleatoriamente una ventana que no existe!!")
		}
	}
	// FAMILIAS:
	public function cerrarFamilia(familiaId:String):Void {
		var arrayQuitar:Array=new Array()
		for (var i = 0; i < data.array_items.length; i++ ) {
			var ventanaId:String = data.array_items[i]
			var familiaVentana:String = data[ventanaId].familiaId
			
			if (familiaId == familiaVentana) {
				arrayQuitar.push(ventanaId)
				var maximizada:Boolean = data[ventanaId].maximizada
				if(maximizada){
					logicaMinimizadas.cerrarVentana(ventanaId)
				}
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
		actualizar_arrayFamilias()
		reposicionarVentanasEnZ()
		enfocarUltimaMaximizada()
	}
	public function enfocarFamilia (familiaId:String):Void {
		var arrayEnfocar:Array=new Array()
		for (var i = 0; i < data.array_maximizadas.length; i++ ) {
			var ventanaId:String = data.array_maximizadas[i]
			var familiaVentana:String = data[ventanaId].familiaId
			if (familiaId == familiaVentana) {
				arrayEnfocar.push(ventanaId)
			}
		}
		data.array_items = Array2.quitarArray(data.array_items, arrayEnfocar)
		data.array_maximizadas = Array2.quitarArray(data.array_maximizadas, arrayEnfocar)
		for (var i = 0; i < arrayEnfocar.length; i++ ) {
			var ventanaId:String=arrayEnfocar[i]
			data.array_items.push(ventanaId)
			data.array_items.array_maximizadas(ventanaId)
		}
		//--
		reposicionarVentanasEnZ()
		enfocarUltimaMaximizada()
	}
	// MINIMIZADAS:
	public function minimizar(ventanaId:String, posX:Number, posY:Number):Void {
		trace("(GestorVentanas2.minimizar): "+ventanaId)
		logicaMinimizadas.minimizar(ventanaId, posX, posY)
	}
	public function restaurar(ventanaId:String, posX:Number, posY:Number):Void {
		trace("(GestorVentanas2.restaurar): "+ventanaId)
		logicaMinimizadas.restaurar(ventanaId, posX, posY)
	}
	public function minimizarFamilia(familiaId:String) {
		trace("(GestorVentanas2.minimizarFamilia): " + familiaId)
		var arrayVentanas:Array=new Array()
		for (var i = 0; i < data.array_maximizadas.length; i++ ) {
			var ventanaId:String = data.array_maximizadas[i]
			var familiaVentana:String = data[ventanaId].familiaId
			if (familiaId == familiaVentana) {
				arrayVentanas.push(ventanaId)
			}
		}
		for (var i = 0; i < arrayVentanas.length; i++ ) {
			var ventanaId:String=arrayVentanas[i]
			minimizar(ventanaId, null, null)
		}
	}
	public function minimizarTodas() {
		trace("(GestorVentanas2.minimizarTodas)!")
		var arrayVentanas:Array=new Array()
		for (var i = 0; i < data.array_maximizadas.length; i++ ) {
			var ventanaId:String = data.array_maximizadas[i]
			arrayVentanas.push(ventanaId)
		}
		for (var i = 0; i < arrayVentanas.length; i++ ) {
			var ventanaId:String=arrayVentanas[i]
			minimizar(ventanaId, null, null)
		}
	}
	public function restaurarFamilia(familiaId:String) {
		trace("(GestorVentanas2.restaurarFamilia): " + familiaId)
		var arrayVentanas:Array=new Array()
		for (var i = 0; i < data.array_minimizadas.length; i++ ) {
			var ventanaId:String = data.array_minimizadas[i]
			var familiaVentana:String = data[ventanaId].familiaId
			if (familiaId == familiaVentana) {
				arrayVentanas.push(ventanaId)
			}
		}
		for (var i = 0; i < arrayVentanas.length; i++ ) {
			var ventanaId:String=arrayVentanas[i]
			restaurar(ventanaId, null, null)
		}
	}
	public function restaurarTodas() {
		trace("(GestorVentanas2.restaurarTodas)!")
		var arrayVentanas:Array=new Array()
		for (var i = 0; i < data.array_minimizadas.length; i++ ) {
			var ventanaId:String = data.array_minimizadas[i]
			var familiaVentana:String = data[ventanaId].familiaId
			arrayVentanas.push(ventanaId)
		}
		for (var i = 0; i < arrayVentanas.length; i++ ) {
			var ventanaId:String=arrayVentanas[i]
			restaurar(ventanaId, null, null)
		}
	}
	public function minimizarFamiliasExcepto(familiaId:String) {
		// Minimiza todas las ventanas excepto las de una familia la deja comoe está.
		trace("(GestorVentanas2.minimizarFamiliasExcepto): " + familiaId)
		trace("   data.array_familias: "+data.array_familias)
		for (var i = 0; i < data.array_familias.length; i++ ) {
			var familiaTemp:String = data.array_familias[i]
			if (familiaTemp!=familiaId) {
				minimizarFamilia(familiaTemp)
			}
		}
	}
	public function minimizarFamiliasYRestaurar(familiaId:String) {
		// Minimiza todas las ventanas excepto las de una familia la cual restaura.
		trace("(GestorVentanas2.minimizarFamiliasYRestaurar): " + familiaId)
		trace("   data.array_familias: "+data.array_familias)
		for (var i = 0; i < data.array_familias.length; i++ ) {
			var familiaTemp:String = data.array_familias[i]
			if (familiaTemp==familiaId) {
				restaurarFamilia(familiaTemp)
			}else {
				minimizarFamilia(familiaTemp)
			}
		}
	}
	// EVENTO GENRICO:
	public function emitirEventoGenerico(tipo:String, data:Object) {
		trace("(GestorVentanas2.emitirEventoGenerico) tipo: " + tipo)
		var obj:Object = new Object()
		obj.type = "onEventoGenerico"
		obj.tipo = tipo
		obj.data = data
		emisor.emitir_objeto(obj)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function reposicionarVentanasEnZ() {
		trace("(GestorVentanas2.reposicionarVentanasEnZ)!")
		trace("   data.array_items: " + data.array_items)
		trace("   data.array_minimizadas: " + data.array_minimizadas)
		trace("   data.array_maximizadas: "+data.array_maximizadas)
		for (var i = 0; i < data.array_minimizadas.length; i++) {
			var ventanaId:String = data.array_minimizadas[i]
			mcRef[ventanaId].swapDepths(mcRef.getNextHighestDepth())
		}
		for (var i = 0; i < data.array_maximizadas.length; i++) {
			var ventanaId:String = data.array_maximizadas[i]
			mcRef[ventanaId].swapDepths(mcRef.getNextHighestDepth())
		}
	}
	private function enfocarUltimaMaximizada() {
		var nuevaUltima:String = Array2.getUltimo(data.array_items)
		var maximizada:Boolean = eval_maximizada(nuevaUltima)
		trace("(GestorVentanas2.enfocarUltimaMaximizada)!")
		trace("   nuevaUltima" + nuevaUltima)
		trace("   maximizada: "+maximizada)
		if(maximizada){
			var obj2:Object = new Object()
			obj2.type = "onEnfocarVentana"
			obj2.ventanaId = nuevaUltima
			emisor.emitir_objeto(obj2)
		}else {
			var obj2:Object = new Object()
			obj2.type = "onEnfocarVentana"
			obj2.ventanaId = null
			emisor.emitir_objeto(obj2)
		}
	}
	// MINIMIZADAS:
	private function minimizarVentana(ventanaId:String) {
		data.array_maximizadas = Array2.quitarElem(data.array_maximizadas, ventanaId)
		data.array_minimizadas = Array2.pull(data.array_minimizadas, ventanaId)
		data.array_items = Array2.quitarElem(data.array_items, ventanaId)
		data.array_items = Array2.pull(data.array_items, ventanaId)
		//--
		reposicionarVentanasEnZ()
		enfocarUltimaMaximizada()
	}
	private function restaurarVentana(ventanaId:String) {
		data.array_minimizadas = Array2.quitarElem(data.array_minimizadas, ventanaId)
		data.array_maximizadas.push(ventanaId)
		data.array_items = Array2.quitarElem(data.array_items, ventanaId)
		data.array_items.push(ventanaId)
		//--
		reposicionarVentanasEnZ()
		enfocarUltimaMaximizada()
	}
	// FAMILIAS:
	private function actualizar_arrayFamilias():Void {
		// Actualiza data.array_familias interrogando las ventanas creadas
		data.array_familias=new Array()
		for (var i = 0; i < data.array_items.length; i++ ) {
			var ventanaId:String = data.array_items[i]
			var familiaId:String = data[ventanaId].familiaId
			data.array_familias.push(familiaId)
		}
		data.array_familias=Array2.copiaArraySinRepeticiones(data.array_familias)
	}
	
	//--------------------
	// EVENTOS:
	public function onVentanaMinimizada(obj:Object):Void {
		trace("(GestorVentanas2.onVentanaMinimizada)!")
		minimizarVentana(obj.ventanaId)
	}
	public function onVentanaRestaurada(obj:Object):Void {
		trace("(GestorVentanas2.onVentanaRestaurada)!")
		restaurarVentana(obj.ventanaId)
	}
	public function onActualizarMinimizadas(obj:Object):Void {
		// NADA
	}
	//--------------------
	// EMISOR:
	public function addListenerMinimizadas(ref:Object) {
		logicaMinimizadas.addListener(ref)
	}
	public function addListener(ref:Object) {
		trace("(GestorVentanas2.addListener): "+ref)
		emisor.addEventListener("onNuevaVentana", ref);
		emisor.addEventListener("onPosicionarVentana", ref);
		emisor.addEventListener("onEnfocarVentana", ref);
		emisor.addEventListener("onCerrarVentana", ref);
		emisor.addEventListener("onCerrarTodasVentanas", ref);
		emisor.addEventListener("onCerrarFamilia", ref);
		emisor.addEventListener("onEventoGenerico", ref);
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