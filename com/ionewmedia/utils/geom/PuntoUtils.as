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
//import com.ionewmedia.utils.geom.Linea;
class com.ionewmedia.utils.geom.PuntoUtils {
	public static function interpolar(p1:Punto, p2:Punto, f:Number):Punto {
		// f: 0->1
		return new Punto(f*p1.x+(1-f)*p2.x, f*p1.y+(1-f)*p2.y);
	}
	public static function distancia(p1:Punto, p2:Punto):Number {
		var dx:Number = p2.x-p1.x;
		var dy:Number = p2.y-p1.y;
		return Math.sqrt(dx*dx+dy*dy);
	}
	public static function polar(len:Number, angleRad:Number):Punto {
		return new Punto(len*Math.cos(angleRad), len*Math.sin(angleRad));
	}
	public static function sumarPuntos(p1:Punto, p2:Punto):Punto {
		// Sobre el punto p1 se suman los valores del punto p2.
		var p3 = new Punto((p1.x + p2.x), (p1.y + p2.y));
		return p3;
	}
	public static function restarPuntos(p1:Punto, p2:Punto):Punto {
		// Sobre el punto p1 se restan los valores del punto p2.
		var p3 = new Punto((p1.x - p2.x), (p1.y - p2.y));
		return p3;
	}
	public static function puntoMedio(p1:Punto, p2:Punto):Punto {
		var pMedio:Punto = new Punto(((p1.x+p2.x)/2), ((p1.y+p2.y)/2));
		return pMedio;
	}
}
