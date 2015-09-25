
/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 07/07/2008 9:27
*/
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.PuntoUtils;
import com.ionewmedia.utils.geom.vectores.Vector;
import com.ionewmedia.utils.geom.trigonometria.MathUtil
import com.ionewmedia.utils.geom.vectores.VectorPenner;
class com.ionewmedia.utils.geom.vectores.VectorUtils {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// ESTATICAS:
	public static function sumarVectores(vector1:Vector, vector2:Vector):Vector {
		// Suma 2 vectores:
		var puntoOrigen:Punto=new Punto(0, 0)
		var puntoResultante:Punto = PuntoUtils.sumarPuntos(vector1.puntoFinal, vector2.puntoFinal)
		var componente:Number = PuntoUtils.distancia(puntoOrigen, puntoResultante)
		var anguloDeg:Number = MathUtil.fixAngle(MathUtil.angleOfLinePts(puntoOrigen, puntoResultante))
		//--
		var vectorResultante:Vector = new Vector(componente, anguloDeg)
		return vectorResultante
	}
	public static function getVectorPorComponentes(x:Number, y:Number):Vector {
		var vectorAux:VectorPenner = new VectorPenner(x, y)
		var vectorResultado:Vector = new Vector(vectorAux.getLength(), vectorAux.getAngle())
		return vectorResultado
	}
}