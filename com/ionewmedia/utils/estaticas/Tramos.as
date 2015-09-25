/*
DOCUMENTACION:
*
* io newmedia S.L. - http://www.zona-io.com  || 
* roberto@zona-io.com(Roberto Ferrero)
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada el 20061128
*/
import com.ionewmedia.utils.estaticas.Array2;
//--
class com.ionewmedia.utils.estaticas.Tramos {
	// Entendemos por Tramos un espacio lineal A->B con puntos de discontinuidad P1, P2, P3, etc
	// de tal forma que dichos segmentos se definen en un Array (numerico): [A, P1, P2, P3,.. B]
	// TRAMO: Los tramos son los espacios en los puntos de discontinuidad  (el tramo A1 -> P1 es el 1)
	// Los puntos de discontinuidad son inicio de tramo (A es del tramo1 y P2 del tramo3)
	//-------------------------------------
	// METODOS STATICOS:
	static function getTramo(arrayTramos:Array, valor:Number):Number {
		// Devuelve la pos del tramo al que pertenece el valor pasado.
		// Si el valor coincide con un punto de discontinuidad se devolverá el tramo que ABRE dicho punto
		// Si el punto es menor al menos de lso valores [0] el tramo será el 0
		// Si el valor es mayor que mayor de lo valores el tramos coincidirá con el num de elem en el array. 
		var tramo:Number = null;
		if (valor<arrayTramos[0]) {
			tramo = 0;
		} else if (valor>=arrayTramos[arrayTramos.length-1]) {
			tramo = arrayTramos.length;
		} else {
			for (var i = 1; i<arrayTramos.length; i++) {
				var min:Number = arrayTramos[i-1];
				var max:Number = arrayTramos[i];
				if (valor>=min && valor<max) {
					tramo = i;
					break;
				}
			}
		}
		return (tramo);
	}
	static function getNumTramos(arrayTamos:Array):Number {
		// Devuelve el numero de tranos definidos entre los puntos de discontinuidad
		return (arrayTamos.length-1);
	}
	static function getLongitudTramo(arrayTamos:Array, tramo:Number):Number {
		// Dado un tramo devuelve su longitud
		var logintud:Number = null;
		if (tramo>=1 || tramo<=getNumTramos(arrayTamos)) {
			logintud = arrayTamos[tramo]-arrayTamos[tramo-1];
		}
		return (logintud);
	}
	static function getTramoMayor(arrayTamos:Array):Array {
		// Devuelve un array con las ids de tramo que tiene la longitud máxima
		// Se pasa un array por si existe la cisrcunstancia ..
		// ...de que hay 2 tramos con igual longitud y ésta es la máxmia
		var arrayTramosMayores:Array = new Array();
		var numTramos:Number = getNumTramos(arrayTamos);
		var longitudMax:Number = 0;
		for (var i = 1; i<=numTramos; i++) {
			var longitudTramo:Number = getLongitudTramo(arrayTamos, i);
			if (longitudTramo>longitudMax) {
				arrayTramosMayores = new Array();
				arrayTramosMayores.push(i);
			} else if (longitudTramo == longitudMax) {
				arrayTramosMayores.push(i);
			}
		}
		return (arrayTramosMayores);
	}
	static function getLongitudTramoMayor(arrayTamos:Array):Object {
		// Vevuelve un objeto con:
		// obj.longitud -> longitud del tramo mayor
		// obj.arrayTramos -> Array con ids de los tramos con esa longitud
		var obj:Object = new Object();
		obj.arrayTramos = getTramoMayor(arrayTamos);
		obj.longitud = getLongitudTramo(getTramoMayor[0]);
		return (obj);

	}
	static function getLongitudesAdyacentes(arrayTamos:Array, puntoDiscontinuidad:Number):Array {
		// Dado un punto de discontinuidad devuelve un array con...
		// ...la longitud del tramo que cierra y del que abre en este orden.
		// Si el puntoDiscontinuidad no está presente en el arrayTramos, se devuelve null,null
		// Si el puntoDiscontinuidad es el primer puntoDiscontinuidad, de devuelve [null,valor]
		// Si el puntoDiscontinuidad es el último puntoDiscontinuidad, de devuelve [valor,null]
		var arrayAdyacentes:Array = [null, null];
		var pos:Number = Array2.devolverId(arrayTamos, puntoDiscontinuidad);
		if (pos != null) {
			arrayAdyacentes[0] = getLongitudTramo(arrayTamos, pos);
			arrayAdyacentes[1] = getLongitudTramo(arrayTamos, pos+1);
		}
		return (arrayAdyacentes);

	}
	static function getTramoAdyacenteMayor(arrayTamos:Array, puntoDiscontinuidad:Number):Object {
		// Dado un punto de discontinuidad devuelve un objeto con... 
		// obj.longitud -> longitud del tramo mayor
		// obj.arrayTramos -> Array con ids de los tramos con esa longitud
		//   (de esta forma se contempla la posibilidad de que los tramos sean igual de largos)
		var obj:Object = new Object();
		obj.arrayTramos = new Array();
		obj.longitud = null;
		var pos:Number = Array2.devolverId(arrayTamos, puntoDiscontinuidad);
		if (pos != null) {
			var longitudIzq:Number = getLongitudTramo(arrayTamos, pos);
			var longitudDer:Number = getLongitudTramo(arrayTamos, pos+1);
			if (longitudIzq == longitudDer) {
				obj.arrayTramos = [pos, (pos+1)];
				obj.longitud = getLongitudTramo(arrayTamos, pos);
			} else if (longitudIzq>longitudDer) {
				obj.arrayTramos = [pos];
				obj.longitud = getLongitudTramo(arrayTamos, pos);
			} else {
				obj.arrayTramos = [pos+1];
				obj.longitud = getLongitudTramo(arrayTamos, pos+1);
			}
		}else{
				trace("(Tramo.getTramoAdyacenteMayor): EL PUNTO PASADO: "+puntoDiscontinuidad+" NO ES UN PTO DE DISCONTINUIDAD DE: "+arrayTamos)
		}
		return (obj);
	}
	static function getTramoAdyacenteMenor(arrayTamos:Array, puntoDiscontinuidad:Number):Object {
		// Dado un punto de discontinuidad devuelve un objeto con... 
		// obj.longitud -> longitud del tramo menor
		// obj.arrayTramos -> Array con ids de los tramos con esa longitud
		//   (de esta forma se contempla la posibilidad de que los tramos sean igual de largos)
		var obj:Object = new Object();
		obj.arrayTramos = new Array();
		obj.longitud = null;
		var pos:Number = Array2.devolverId(arrayTamos, puntoDiscontinuidad);
		if (pos != null) {
			var longitudIzq:Number = getLongitudTramo(arrayTamos, pos);
			var longitudDer:Number = getLongitudTramo(arrayTamos, pos+1);
			if (longitudIzq == longitudDer) {
				obj.arrayTramos = [pos, (pos+1)];
				obj.longitud = getLongitudTramo(arrayTamos, pos);
			} else if (longitudIzq<longitudDer) {
				obj.arrayTramos = [pos];
				obj.longitud = getLongitudTramo(arrayTamos, pos);
			} else {
				obj.arrayTramos = [pos+1];
				obj.longitud = getLongitudTramo(arrayTamos, pos+1);
			}
		}
		return (obj);
	}
	static function getInicioFinTramo(arrayTamos:Array, tramo:Number):Array {
		// NUEVO: 11/03/2009 12:20
		// Dado un arrayTramos y un tramo de este devuelve loas valores que delimitan el tramo.
		// Ejemplo arrayTramo = [1,5,8,9,14] y tramo = 2 --> devuelve [5,8]
		var inicio:Number = arrayTamos[tramo - 1]
		if (inicio==undefined) {
			inicio = null
		}
		var fin:Number = arrayTamos[tramo]
		if (fin==undefined) {
			fin = null
		}
		var inicioFin:Array = [inicio, fin]
		return inicioFin
	}
}