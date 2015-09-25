/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070802
* Basada en: http://timotheegroleau.com/Flash/articles/cubic_bezier/bezier_lib.as
*/
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.Linea;
class com.ionewmedia.utils.geom.LineaUtils {
	public static function getLine(p0:Punto, p1:Punto):Linea {
		// Pasamos 2 puntos p0 y p1 pertenecientes a la linea
		// Devuelve un objeto con la info para crear una función que determine la línea.
		// Hay 2 casos:
		//    1) La linea es vertical. Se pasa el parametro "c" que actua como constante.
		//    2) La linea no es vertical. Pasamos "a" y "b" para definir la linea mediante
		//       la funcion "y = a*x + b"
		var linea:Linea = new Linea();
		var x0 = p0.x;
		var y0 = p0.y;
		var x1 = p1.x;
		var y1 = p1.y;
		if (x0 == x1) {
			if (y0 == y1) {
				// P0 and P1 are same point, return null
				linea.existe = false;
			} else {
				// Otherwise, the line is a vertical line
				linea.c = x0;
			}
		} else {
			linea.a = (y0-y1)/(x0-x1);
			linea.b = y0-(linea.a*x0);
		}
		// returns the line object
		return linea;
	}
	public static function getLine2(p0:Punto, vector:Object):Linea {
		// Pasamos un punto de la linea y un vector de direccion
		// El vector dirección se define con "x" e "y"
		// Devuelve un objeto con la info para crear una función que determine la línea.
		// Hay 2 casos:
		//    1) La linea es vertical. Se pasa el parametro "c" que actua como constante.
		//    2) La linea no es vertical. Pasamos "a" y "b" para definir la linea mediante
		//       la funcion "y = a*x + b"
		var linea:Linea = new Linea();
		var x0 = p0.x;
		var vx0 = vector.x;
		if (vx0 == 0) {
			// the line is vertical
			linea.c = x0;
		} else {
			linea.a = vector.y/vx0;
			linea.b = p0.y-(linea.a*x0);
		}
		// returns the line object
		//trace(linea.toString());
		return linea;
	}
	public static function getLineCross(linea0:Linea, linea1:Linea):Punto {
		// Devuelve un Punto el cual es la intersección de 2 Lineas
		//--
		// Make sure both lines exists
		if (!linea0.existe || !linea1.existe) {
			return null;
		}
		// define local variables           
		var a0 = linea0.a;
		var b0 = linea0.b;
		var c0 = linea0.c;
		var a1 = linea1.a;
		var b1 = linea1.b;
		var c1 = linea1.c;
		var u;
		// checks whether both lines are vertical
		if ((c0 == null) && (c1 == null)) {
			// lines are not verticals but parallel, intersection does not exist
			if (a0 == a1) {
				return null;
			}
			// calculate common x value.           
			u = (b1-b0)/(a0-a1);
			// return the new Point
			var puntoInterseccion:Punto = new Punto(u, (a0*u+b0));
			return puntoInterseccion;
		} else {
			if (c0 != null) {
				if (c1 != null) {
					// both lines vertical, intersection does not exist
					return null;
				} else {
					// return the point on linea1 with x = c0
					var puntoInterseccion:Punto = new Punto(c0, (a1*c0+b1));
					return puntoInterseccion;
				}
			} else if (c1 != null) {
				// no need to test c0 as it was tested above
				// return the point on linea0 with x = c1
				var puntoInterseccion:Punto = new Punto(c1, (a0*c1+b0));
				return puntoInterseccion;
			}
		}
	}
	public static function distance(p0:Punto, p1:Punto):Number {
		var dx = p0.x-p1.x;
		var dy = p0.y-p1.y;
		return Math.sqrt(dx*dx+dy*dy);
	}
	public static function getMiddle(p0, p1):Punto {
		var puntoMedio:Punto = new Punto(((p0.x+p1.x)/2), ((p0.y+p1.y)/2));
		return puntoMedio;
	}
}
