import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.PuntoUtils;
import com.ionewmedia.utils.geom.Linea;
import com.ionewmedia.utils.geom.LineaUtils;
import com.ionewmedia.utils.geom.Tangente;
import com.ionewmedia.utils.geom.bezier.v1.Bezier;
class com.ionewmedia.utils.geom.bezier.v1.BezierUtils {
	public static function interpolar(curva:Bezier, t:Number):Punto {
		// t: Valores de 0 -> 1
		var ax, bx, cx:Number;
		var ay, by, cy:Number;
		var tsquared:Number;
		var tCubed:Number;
		// calculate the polynomial coefficients
		cx = 3.0*(curva.c1.x-curva.p1.x);
		bx = 3.0*(curva.c2.x-curva.c1.x)-cx;
		ax = curva.p2.x-curva.p1.x-cx-bx;
		//
		cy = 3.0*(curva.c1.y-curva.p1.y);
		by = 3.0*(curva.c2.y-curva.c1.y)-cy;
		ay = curva.p2.y-curva.p1.y-cy-by;
		////
		//calculate the curve point at parameter value t
		tsquared = t*t;
		tCubed = tsquared*t;
		//
		var posX:Number = (ax*tCubed)+(bx*tsquared)+(cx*t)+curva.p1.x;
		var posY:Number = (ay*tCubed)+(by*tsquared)+(cy*t)+curva.p1.y;
		//trace("(BezierUtils.puntoCubicBezier): "+t+"   "+result.x+","+result.y);
		var puntoInterpolado = new Punto(posX, posY);
		//
		return puntoInterpolado;
	}
	//--
	//
	//
	//--
	public static function getCubicDerivative(c0, c1, c2, c3, t):Number {
		var g = 3*(c1-c0);
		var b = (3*(c2-c1))-g;
		var a = c3-c0-b-g;
		return (3*a*t*t+2*b*t+g);
	}
	//--
	//
	//
	//--
	public static function get_tangente(curva:Bezier, t:Number):Tangente {
		//trace("(BezierUtils.get_tangente)!");
		// calculates the position of the cubic bezier at t
		var puntoInterpolado:Punto = BezierUtils.interpolar(curva, t);
		//trace(puntoInterpolado.toString());
		// calculates the tangent values of the cubic bezier at t
		var vector = new Object();
		vector.x = BezierUtils.getCubicDerivative(curva.p1.x, curva.c1.x, curva.c2.x, curva.p2.x, t);
		vector.y = BezierUtils.getCubicDerivative(curva.p1.y, curva.c1.y, curva.c2.y, curva.p2.y, t);
		//trace("vector.x: "+vector.x);
		//trace("vector.y: "+vector.y);
		//trace("---");
		// calculates the line equation for the tangent at t
		var linea:Linea = LineaUtils.getLine2(puntoInterpolado, vector);
		// return the Point/Tangent object 
		var puntoTemp:Punto = new Punto(vector.x, vector.y);
		var puntoVector:Punto = PuntoUtils.sumarPuntos(puntoInterpolado, puntoTemp);
		var tangente:Tangente = new Tangente(puntoInterpolado, linea, puntoVector);
		return tangente;
	}
}
