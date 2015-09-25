/*
DOCUMENTACION:

  import com.ionewmedia.utils.estaticas.Array2
	
- copiaArraySinRepeticiones(esteArray:Array):Array
    Devuelve una copia de un array sin repeticiones
- copiaDeEsteArray(esteArray:Array):Array
    Devuelve una copia del array evitando que se realice una suscripción
- desordenar(a1:Array):Array
    Dado un array devuelve otro con sus elementos desordenados
- devolverId(a1:Array, elem:Object):Number
    Devuelve la posición del elemento dentro del array
- estaEnElArray(a1:Array, elem:Object):Boolean
    Devuelve true/false dependiendo de si un elemento está en el array
- evalHayFalse(a1:Array):Boolean
    Devuelve true/false dependiendo de si hay un false
- evalHayTrue(a1:Array):Boolean
    Devuelve true/false dependiendo de si hay un true
- evalTodosFalse(a1:Array):Boolean
    Devuelve true/false dependiendo de si todos los elementos son false
- evalTodosTrue(a1:Array):Boolean
    Devuelve true/false dependiendo de si todos los elementos son true
- ordenarCreciente(miArray:Array):Array
    Dado un array devuele otro con los mismo elementos pero odenados crecientemente
- ordenarCreciente2(a1:Array, a2:Array):Array {
    Dado un array a1 y otro a2 con numeros,
    devuelve uno con los elementos de a1 ordenado crecientemente segun el a2
- quitarElem(a1:Array, elem:Object):Array
    Dado un array base a1 y un elem, se devuelve un array copia de a1 sin el elemento
- quitarArray(arrayBase:Array, arrayResta:Array):Array
    Dado un array a1 y otro arrayResta de resta, se devuelve un 3ero con:
    Aquellos elementos que están en arrayBase menos los de arrayResta
- quitarArray2(arrayBase:Array, arrayResta:Array, arrayQuitar:Array):Array
    Al array a1 se le quita el array a2 y aquellas ids quitadas se le quitan a a3
    del cual se deveulve una copia modificada.	
- quitarUltimo(a1:Array):Array
	Devuleve un array sin el ultimo elemento
- quitarPrimero(a1:Array):Array
	Devuleve un array sin el primer elemento
- arrayEnArray(a1:Array, a2:Array):Boolean {
    Nuevo: 20060907
    Dado el array a1 y el array a2, se evalua si TODOS los elemento de a1 están en a2
- sumarArrays(a1:Array, a2:Array):Array{
    Nuevo: 20060908
    Dados 2 arrays devuele un tercero con elem de a1 + los elem de a2
- pull(arrayRef:Array, elem:Object):Array {
    Nuevo: 20071501
    Dado un array "arrayRef" inserta el elemento "elem" al inicio del mismo.
    Igual que el "push" pero insertandolo al inicio en vez de al final
- getTramo(arrayRef:Array, valor:Number):Number {
    Nuevo: 20071522
    Dado un array de valores numéricos crecientes por ejemplo [0, 20, 40] y un valor, devuelve
    el tramo del valor pasado de tal forma que:
    -infinito <--tramo0 --> 0 <--tramo1--> 20 <--tramo2--> 40 <--tramo3--> +infinito
    Los puntos de discontinuidad son inicio de tramo (0 es del tramo1 y 40 del tramo3)
- getUltimo(arrayRef:Array):Object {
    NUEVO: 20070122
    Dado un array devuelvesu ultimo elemento
- getRandomItem(arrayRef:Array):Object
    NUEVO 20080304
	Dado un array devuelve uno de sus elementos al azar.
- getSumaElementos(arrayRef:Array):Number
	NUEVO 20080319
    Dado un array cuyos elementos son números se devuelve la suma de todos los elementos
- interseccionar (a1:Array, a2:Aeeay):Array
	NUEVO 05/06/2008 15:17
	Dados 2 arrays devuelve un tercero con los elementos comunes en ambos.
- rotarArray (array1:Array, item:Object):Array {
	NUEVO 02/07/2008 12:14
	Dado un array y un iteme de el devuelve otro con el item en primera posicion:
	arrayEjemplo=["a", "b", "c", "d", "e"]
	rotarArray(arrayEjemplo, "d")
	devuelve: ["d", "e", "a", "b", "c"]
	NUEVO 04/09/2008 16:20
- traceArray(arrayAux.Array):Void
	NUEVO 04/09/2008 16:20
- getSiguiente(a1:Array, elem, loop:Boolean)
	NUEVO: 17/12/2008 19:08
	Dado un array y un elemento del mismo devuleve el siguiente.
	Si es el ultimo y loop=true devuelve el primero.
	Si es el ultimo y loop=false devuelve null
- getAnterior(a1:Array, elem, loop:Boolean)
	NUEVO: 17/12/2008 19:08
	Dado un array y un elemento del mismo devuleve el anterior.
	Si es el primero y loop=true devuelve el ultimo.
	Si es el primero y loop=false devuelve null
- getPagina(a1:Array, itemsPagina:Number, pagina:Number):Array {
	NUEVO: 21/01/2009 17:55
	Dado un array lo pagina en páginas con tantos items como "itemsPagina"
	...y devulve un array de la página solicitada.
 - ordenarSegunIndice(arrayIndice:Array, arrayAOrdenar:Array):Array {
	NUEVO 22/01/2009 17:30
	Dado un array que actua como indice y dado otro a ordenar
	devuelve un 3er array con la intersección entre a1 y a2 y ordenado segun a1
- pushSiNoExiste(a1:Array, elem:Object)
	NUEVO 14/07/2015 18:19
	// Añade un elem si no está presente
*
* io newmedia S.L. - http://www.zona-io.com  || 
* roberto@zona-io.com		(Roberto Ferrero)
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/	
*/
import com.ionewmedia.utils.estaticas.Random2
class com.ionewmedia.utils.estaticas.Array2 {
	// import com.ionewmedia.utils.estaticas.Array2
	//-------------------------------------
	// METODOS STATICOS:
	
	static function evalMismosElem(a1:Array, a2:Array) {
		// NUEVO 14/07/2015 18:19
		// Evalua true o false dependiendo de si los dos array tienen los mismos elementos
		var mismosElem:Boolean = true
		for (var i = 0; i < a1.length; i++ ) {
			var item1:Object = a1[i]
			var existe:Boolean = evalExiste(a2, item1)
			if (!existe) {
				mismosElem = false
			}
		}
		if (mismosElem && a1.length== a2.length) {
			// NADA
		}else {
			mismosElem = false
		}
		return mismosElem
	}
	
	static function pushSiNoExiste(a1:Array, elem:Object) {
		// NUEVO 14/07/2015 18:19
		// Añade un elem si no está presente
		var existe:Boolean = evalExiste(a1, elem)
		if (!existe) {
			a1.push(elem)
		}
		return a1
	}
	
	static function copiaArraySinRepeticiones(a1:Array):Array {
		// Devuelve una copia de un array sin repeticiones
		var sumar:Boolean;
		var elem:Object;
		var a2 = new Array();
		for (var i = 0; i<a1.length; i++) {
			sumar = true;
			elem = a1[i];
			for (var j = 0; j<a2.length; j++) {
				if (elem == a2[j]) {
					sumar = false;
				}
			}
			if (sumar) {
				a2.push(elem);
			}
		}
		return a2;
	}
	static function copiaDeEsteArray(a1:Array):Array {
		// Devuelve una copia del array evitando que se realice una suscripción
		var a2 = new Array();
		for (var i = 0; i<a1.length; i++) {
			a2.push(a1[i]);
		}
		return a2;
	}
	static function desordenar(a1:Array):Array {
		// Dado un array devuelve otro con sus elementos desordenados
		var a2 = new Array();
		var numElem = a1.length;
		for (var i = 0; i<numElem; i++) {
			var numElemAhora = a1.length;
			var rndElem = Math.ceil(Math.random()*numElemAhora);
			a2.push(a1[rndElem-1]);
			a1.splice(rndElem-1, 1);
		}
		return a2;
	}
	static function devolverId(a1:Array, elem:Object):Number {
		// Devuelve la posición del elemento dentro del array
		for (var i = 0; i<a1.length; i++) {
			if (a1[i] == elem) {
				return i;
			}
		}
		return null;
	}
	static function estaEnElArray(a1:Array, elem:Object):Boolean {
		// Devuelve true/false dependiendo de si un elemento está en el array
		var control:Boolean = false;
		for (var i = 0; i<a1.length; i++) {
			if (a1[i] == elem) {
				control = true;
			}
		}
		return control;
	}
	// NUEVO: 20140919
	static function evalExiste(a1:Array, elem:Object):Boolean {
		return estaEnElArray (a1, elem)
	}
	
	
	static function evalHayFalse(a1:Array):Boolean {
		// Si hay un elem en el array false devuelve true, sino false
		// Modificado el 20060920 ya que un valor null era interpretado como false
		var control:Boolean = false;
		for (var i = 0; i<a1.length; i++) {
			if (a1[i] == false) {
				control = true;
			}
		}
		return (control);
	}
	static function evalHayTrue(a1:Array):Boolean {
		// Si hay un elem en el array true devueleve true, sino false
		var control:Boolean = false;
		for (var i = 0; i<a1.length; i++) {
			if (a1[i]) {
				control = true;
			}
		}
		return (control);
	}
	static function evalTodosFalse(a1:Array):Boolean {
		// Si todos los elementos del array son false devuelve true, sino false
		var control:Boolean = true;
		for (var i = 0; i<a1.length; i++) {
			if (a1[i]) {
				control = false;
			}
		}
		return (control);
	}
	static function evalTodosTrue(a1:Array):Boolean {
		// Si todos los elementos del array son true devueleve true, sino false
		var control:Boolean = true;
		for (var i = 0; i<a1.length; i++) {
			if (!a1[i]) {
				control = false;
			}
		}
		return (control);
	}
	static function ordenarCreciente(a1:Array):Array {
		// Dado un array devuele otro con los mismo elementos pero odenados crecientemente
		var aResultado:Array = new Array();
		aResultado.push(a1[0]);
		for (var i = 1; i<a1.length; i++) {
			var valor = a1[i];
			var pos:Number = 0;
			var esElMenor:Boolean = true;
			for (var j = 0; j<aResultado.length; j++) {
				//trace("aResultado: "+aResultado);
				//trace("valor("+valor+") major que "+aResultado[j]+" ?");
				if (valor>aResultado[j]) {
					//trace("  si");
					pos = j;
					esElMenor = false;
				} else {
					//trace("  no");
				}
			}
			//trace("pos: "+pos);
			if (esElMenor) {
				aResultado.splice(0, 0, valor);
			} else {
				aResultado.splice(pos+1, 0, valor);
			}
			//trace("------------------");
		}
		return (aResultado);
	}
	static function ordenarCreciente2(a1:Array, a2:Array):Array {
		// Dado un array a1 y otro a2 con numeros, devuelve:
		// un con los elementos de a1 ordenado crecientemente segun el a2
		var aResultado:Array = new Array();
		var aResultado_medias:Array = new Array();
		aResultado.push(a1[0]);
		aResultado_medias.push(a2[0]);
		for (var i = 1; i<a1.length; i++) {
			var valor_ids = a1[i];
			var valor_medias = a2[i];
			var pos = 0;
			var esElMenor:Boolean = true;
			for (var j = 0; j<aResultado_medias.length; j++) {
				if (valor_medias>aResultado_medias[j]) {
					pos = j;
					esElMenor = false;
				} else {
				}
			}
			if (esElMenor) {
				aResultado.splice(0, 0, valor_ids);
				aResultado_medias.splice(0, 0, valor_medias);
			} else {
				aResultado.splice(pos+1, 0, valor_ids);
				aResultado_medias.splice(pos+1, 0, valor_medias);
			}
			//trace("aResultado: "+aResultado);
			//trace("aResultado_medias: "+aResultado_medias);
		}
		return (aResultado);
	}
	static function quitarElem(a1:Array, elem:Object):Array {
		// Dado un array base a1 y un elem, se devuelve un array copia de a1 sin el elemento
		var aResultado:Array = new Array();
		for (var i = 0; i<a1.length; i++) {
			var valorBase = a1[i];
			if (valorBase != elem) {
				aResultado.push(valorBase);
			}
		}
		return aResultado;
	}
	static function quitarArray(a1:Array, a2:Array):Array {
		// Dado un a1 y otro a2 de resta, se devuelve un 3ero con:
		// Aquellos elementos que están en el base y no el resta
		var aResultado:Array = new Array();
		for (var i = 0; i<a1.length; i++) {
			var sumarEste = true;
			var valorBase = a1[i];
			for (var j = 0; j<a2.length; j++) {
				var valorResta = a2[j];
				if (valorBase == valorResta) {
					sumarEste = false;
				}
			}
			if (sumarEste) {
				aResultado.push(valorBase);
			}
		}
		return aResultado;
	}
	static function quitarArray2(arrayBase:Array, arrayResta:Array, arrayQuitar:Array):Array {
		// Dado un array base y otro de resta, se devuelve un 3ero con:
		// Aquellso elementos que están en el base y no el resta
		// v2: Aplica la lógica a un segundo array eliminado los ids que se han eliminado en el primero
		var aResultado:Array = new Array();
		var aResultado2:Array = new Array();
		var arrayReturn:Array = new Array();
		for (var i = 0; i<arrayBase.length; i++) {
			var sumarEste = true;
			var valorBase = arrayBase[i];
			var valorBase2 = arrayResta[i];
			for (var j = 0; j<arrayQuitar.length; j++) {
				var valorResta = arrayQuitar[j];
				if (valorBase == valorResta) {
					sumarEste = false;
				}
			}
			if (sumarEste) {
				aResultado.push(valorBase);
				aResultado2.push(valorBase2);
			}
		}
		arrayReturn[0] = aResultado;
		arrayReturn[1] = aResultado2;
		return arrayReturn;
	}
	// NUEVO 12/05/2014 20:22
	static function quitarUltimo(a1:Array):Array {
		var ultimo:Object = getUltimo(a1)
		var arrayAux:Array = quitarElem(a1, ultimo)
		return arrayAux
	}
	static function quitarPrimero(a1:Array):Array {
		var primero:Object = a1[0]
		var arrayAux:Array = quitarElem(a1, primero)
		return arrayAux
	}
	// NUEVO: 20060907
	static function arrayEnArray(a1:Array, a2:Array, estricto:Boolean):Boolean {
		//trace("(Array2.arrayEnArray)!");
		// 20080227 Añadido el parametro opcional estricto.
		// Dado el array a1 y el array a2, se evalua si:
		// estricto=true -> TODOS los elemento de a1 están en a2
		// estricto=false -> ALGUNO de los elemento de a1 están en a2
		var control:Boolean
		if (estricto==undefined || estricto==null) {
			estricto=true
		}
		//--
		if (estricto) {
			control=true
			for (var i = 0; i<a1.length; i++) {
				var elem = a1[i];
				var esta = estaEnElArray(a2, elem);
				if (!esta) {
				control = false;
				}
			}
		}else {
			control=false
			for (var i = 0; i<a1.length; i++) {
				var elem = a1[i];
				var esta = estaEnElArray(a2, elem);
				if (esta) {
				control = true;
				}
			}
		}
		return (control);
	}
	// NUEVO: 20060908
	static function sumarArrays(a1:Array, a2:Array):Array {
		for (var i = 0; i<a2.length; i++) {
			a1.push(a2[i]);
		}
		return a1;
	}
	// NUEVO: 20070115
	static function pull(arrayRef:Array, elem:Object):Array {
		// Dado un array "arrayRef" inserta el elemento "elem" al inicio del mismo.
		// Igual que el "push" pero insertandolo al inicio en vez de al final
		var nuevoArray:Array = new Array();
		nuevoArray.push(elem);
		for (var i = 0; i<arrayRef.length; i++) {
			nuevoArray.push(arrayRef[i]);
		}
		return (nuevoArray);
	}
	// NUEVO: 20070122
	static function getTramo(arrayRef:Array, valor:Number):Number {
		// Dado un array de valores numéricos crecientes por ejemplo [0, 20, 40] y un valor, devuelve
		// el tramo del valor pasado de tal forma que:
		// -infinito <--tramo0 --> 0 <--tramo1--> 20 <--tramo2--> 40 <--tramo3--> +infinito
		// Los puntos de discontinuidad son inicio de tramo (0 es del tramo1 y 40 del tramo3)
		var tramo:Number = null;
		if (valor>=arrayRef[arrayRef.length-1]) {
			tramo = arrayRef.length;
		} else if (valor<arrayRef[0]) {
			tramo = 0;
		} else {
			for (var i = 0; i<arrayRef.length-1; i++) {
				var tramo_inicio:Number = arrayRef[i];
				var tramo_fin:Number = arrayRef[i+1];
				//trace("   tramo_inicio: "+tramo_inicio);
				//trace("   tramo_fin: "+tramo_fin);
				if (valor>=tramo_inicio && valor<tramo_fin) {
					//trace("tramo: "+i);
					tramo = i+1;
				}
			}
		}
		return (tramo);
	}
	// NUEVO: 20070122
	static function getUltimo(arrayRef:Array) {
		// Dado un array devuelve su ultimo elemento
		return (arrayRef[arrayRef.length-1]);
	}
	// NUEVO 20070317
	//static function cortarPrimero(miArray:Array) {
	//var elem = miArray.splice(0, 1);
	//return (elem);
	//}
	// NUEVO 20080304:
	static function getRandomItem (itemArray:Array):Object {
		var randomPos:Number=Random2.dado(itemArray.length)-1
		return (itemArray[randomPos]);
	}
	// NUEVO 20080319
	static function getSumaElementos(arrayRef:Array):Number {
		// Dado un array cuyos elementos son número se devuelve la suma de todos los elementos
		var total:Number=0
		for (var i = 0; i < arrayRef.length; i++) {
			total+=arrayRef[i]
		}
		return total
	}
	// NUEVO 28/04/2008 12:00
	static function insertar (arrayRef:Array, elem:Object, posicion:Number):Array {
		// Dado un array, un elemento y una posicion, inserta dicho elemto en el array...
		// siendo la posición del elemento insertado la posición pasada como param.
		// Ejem: ["a", "b", "c"] elem="d" pos=1 -> ["a", "d", "b", "c"]
		// Sigue misma logica que Array.splice() solo que devuelve el array en vez de modificar el original
		var arrayAux:Array = copiaDeEsteArray(arrayRef)
		arrayAux.splice(posicion, 0, elem)
		return arrayAux
	}
	static function interseccionar(a1:Array, a2:Array):Array {
		var arrayAux:Array = new Array()
		for (var i = 0; i < a1.length; i++ ) {
			var item:Object = a1[i]
			var intersecciona:Boolean = Array2.estaEnElArray(a2, item)
			if (intersecciona) {
				arrayAux.push(item)				
			}
		}
		return arrayAux
	}
	// NUEVO: 02/07/2008 12:13
	static function rotarArray (array1:Array, item:Object):Array {
		// Dado un array y un iteme de el devuelve otro con el item en primera posicion:
		// arrayEjemplo=["a", "b", "c", "d", "e"]
		// rotarArray(arrayEjemplo, "d")
		// devuelve: ["d", "e", "a", "b", "c"]
		var arrayAux:Array=Array2.copiaArraySinRepeticiones(array1)
		var posItem:Number=Array2.devolverId(arrayAux, item)
		for (var i=0; i<posItem; i++) {
			var itemAux:Object=arrayAux[0]
			arrayAux=Array2.quitarElem(arrayAux,itemAux)
			arrayAux.push(itemAux)
		}
		return arrayAux
	}
	// NUEVO 04/09/2008 16:20
	static function traceArray(arrayAux:Array) {
		for (var i = 0; i < arrayAux.length; i++ ) {
			trace(i+": "+arrayAux[i])
		}
	}
	
	static function getSiguiente(a1:Array, elem:String, loop:Boolean) {
		// NUEVO: 17/12/2008 19:10
		//Dado un array y un elemento del mismo devuleve el siguiente.
		//Si es el ultimo y loop=true devuelve el primero.
		//Si es el ultimo y loop=false devuelve null
		if (loop==null || loop==undefined) {
			loop = false
		}
		var existe:Boolean = Array2.estaEnElArray(a1, elem)
		var siguiente
		if (existe) {
			var pos:Number = Array2.devolverId(a1, elem)
			if (a1.length == 1) {
				if (loop) {
					siguiente = elem
				}else {
					siguiente = null
				}
			}else if (pos==0) {
				siguiente = a1[pos+1]
			}else if (pos == a1.length - 1) {
				if (loop) {
					siguiente = a1[0]
				}else {
					siguiente = null
				}
			}else {
				siguiente = a1[pos+1]
			}
		}else {
			trace ("(Array2.get_siguiente) ATENCION: Se pide el siguiente elem a: "+elem+" en: "+a1+" PERO NO EXISTE!!")
			siguiente = null
		}
		return siguiente
	}
	static function getAnterior(a1:Array, elem, loop:Boolean) {
		//NUEVO: 17/12/2008 19:08
		//Dado un array y un elemento del mismo devuleve el anterior.
		//Si es el primero y loop=true devuelve el ultimo.
		//Si es el primero y loop=false devuelve null
		if (loop==null || loop==undefined) {
			loop = false
		}
		var existe:Boolean = Array2.estaEnElArray(a1, elem)
		var siguiente
		if (existe) {
			var pos:Number = Array2.devolverId(a1, elem)
			if (a1.length == 1) {
				if (loop) {
					siguiente = elem
				}else {
					siguiente = null
				}
			}else if (pos == 0) {
				if (loop) {
					siguiente = Array2.getUltimo(a1)
				}else {
					siguiente = null
				}
			}else if (pos == a1.length - 1) {
				siguiente = a1[pos-1]
			}else {
				siguiente = a1[pos-1]
			}
		}else {
			trace ("(Array2.get_siguiente) ATENCION: Se pide el siguiente elem a: "+elem+" en: "+a1+" PERO NO EXISTE!!")
			siguiente = null
		}
		return siguiente
	}
	// NUEVO: 21/01/2009 17:55
	static function getPagina(a1:Array, itemsPagina:Number, pagina:Number):Array {
		// Dado un array lo pagina en páginas con tantos items como "itemsPagina"
		//...y devulve un array de la página solicitada.
		// La página 0 es la primera.
		var arrayAux:Array = new Array();
		var inicio:Number = itemsPagina*pagina;
		var fin:Number = inicio+(itemsPagina-1);
		if (fin>(a1.length-1)) {
			fin = a1.length-1;
		}
		trace("   inicio: "+inicio)
		trace("   fin: "+fin)
		for (var i = inicio; i<=fin; i++) {
			arrayAux.push(a1[i])
		}
		return arrayAux
	}
	// NUEVO: 21/01/2009 17:55
	static function getNumPaginas(a1:Array, itemsPagina:Number):Number {
		return (Math.ceil(a1.length/itemsPagina))
	}
	// NUEVO: 13/03/2009 18:23
	static function getEnQuePagina(a1:Array, itemsPagina:Number, itemId:String):Number {
		// dado un array de items, los items por página y un item devuelve
		// en que página está dicho item (la primera página es la 0)
		var posItem:Number = devolverId(a1, itemId)
		var paginaNum:Number = Math.floor(posItem / itemsPagina)
		return paginaNum
	}
	// NUEVO 22/01/2009 17:30
	static function ordenarSegunIndice(arrayIndice:Array, arrayAOrdenar:Array):Array {
		// Dado un array que actua como indice y dado otro a ordenar
		// devuelve un 3er array con la intersección entre a1 y a2 y ordenado segun a1
		var arrayTemp:Array = new Array()
		for (var i = 0; i<arrayIndice.length; i++) {
			var itemIndice = arrayIndice[i];
			var aOrdenar:Boolean = Array2.estaEnElArray(arrayAOrdenar, itemIndice)
			if(aOrdenar){
				arrayTemp.push(itemIndice)
			}
		}
		return arrayTemp
	}
	// NUEVO 07/05/2009 10:30
	static function ordenarAlfabeticamente(array:Array):Array {
		// Dado un array lo ordena alfabeticamente
		var arrayAux:Array = new Array();
		var arrayOrdenado:Array = new Array();
		for (var i = 0; i<array.length; i++) {
			var objTemp:Object = new Object();
			//objTemp.index = i;
			objTemp.name = array[i];
			arrayAux.push(objTemp);
		}
		arrayAux.sortOn("name",Array.ASCENDING | Array.CASEINSENSITIVE);
		for (var j = 0; j<arrayAux.length; j++) {
			arrayOrdenado.push(arrayAux[j].name)
		}
		return arrayOrdenado
	}
}
