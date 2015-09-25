import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.vectores.Vector
interface com.ionewmedia.utils.geom.vectores.Fuerza {
	public function sumarFuerza(vector:Vector):Vector;
	public function getFuerza():Vector
	//--
	public function addListener(ref:Object) 
	public function addEventListener(evento:String, ref:Object) 
	public function removeListener(ref:Object) 
	public function removeEventListener(evento:String, ref:Object) 
}