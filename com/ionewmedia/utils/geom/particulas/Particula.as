/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 2008
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
import com.ionewmedia.utils.estaticas.Number2
import com.ionewmedia.utils.timers.frameBased.Tempo
//--
import com.ionewmedia.utils.geom.vectores.Fuerza
import com.ionewmedia.utils.geom.Punto
import com.ionewmedia.utils.geom.PuntoUtils
import com.ionewmedia.utils.geom.vectores.Vector
import com.ionewmedia.utils.geom.vectores.fuerzas.FuerzaCombinada
//--
class com.ionewmedia.utils.geom.particulas.Particula {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var tempo:Tempo
	private var emisor:EmisorExtendido;
	public var fuerzas:FuerzaCombinada
	//--
	public var id:String=null
	public var punto:Punto
	public var vector:Vector
	public var vectorDeseado:Vector
	public var mcRef:MovieClip
	//--
	public var existePosInicial:Boolean = false
	public var enDrag:Boolean = false
	private var puntoIman:Punto = null
	private var imanActivado:Boolean=false
	//--------------------
	// CONSTRUCTORA:
	function Particula(_id:String){
		trace("(Particula.CONSTRUCTORA): "+_id)
		//--
		if (_id != null && _id != undefined) {
			id=_id
		}
		//--
		emisor=new EmisorExtendido()
		tempo = Tempo.getInstance()
		tempo.addListener(this)
		punto = new Punto(0, 0)
		fuerzas = new FuerzaCombinada()
		vector = new Vector(0, 0)
		vectorDeseado= new Vector(0, 0)
		//--
		
	}
	public function init():Void {
		trace("(Particula.init): "+id)
		var obj:Object = new Object()
		obj.type = "onInitView"
		obj.particula = this
		emisor.emitir_objeto(obj)
	}
	public function initKill() {
		tempo.removeListener(this)
		tempo = null
		emisor.removeAllListeners()
		emisor = null
		fuerzas = null
	}
	//--------------------
	// METODOS PUBLICOS:
	//public function set_posicion(x:Number, y:Number) {
		//punto.x = x
		//punto.y = y
	//}
	public function set_posInicial(x:Number, y:Number) {
		//trace("(Particula.set_posInicial): "+id+" x: "+x+"  y: "+y)
		existePosInicial=true
		punto.x = x
		punto.y = y
	}
	public function set_mcRef(ref:MovieClip) {
		trace("(Particula.set_mcRef): "+id)
		mcRef = ref
		this.addEventListener("onInitView", mcRef)
		this.addEventListener("onActualizarView", mcRef)
		this.addEventListener("onEmpezarDrag", mcRef)
		this.addEventListener("onPararDrag", mcRef)
	}
	public function nuevaFuerza(fuerza:Fuerza, fuerzaId:String):String {
		trace("(Particula.nuevaFuerza): "+id+"   fuerzaId: "+fuerzaId)
		var fuerzaIdFinal:String = fuerzas.nuevaFuerza(fuerza, fuerzaId)
		return fuerzaIdFinal
	}
	// DRAG:
	public function empezarDrag() {
		enDrag = true
		var obj:Object = new Object()
		obj.type = "onEmpezarDrag"
		obj.particula = this
		emisor.emitir_objeto(obj)
	}
	public function pararDrag() {
		enDrag = false
		var obj:Object = new Object()
		obj.type = "onPararDrag"
		obj.particula = this
		emisor.emitir_objeto(obj)
	}
	//--------------------
	// METODOS PRIVADOS:
	private function actualizar() {
		if (enDrag) {
			actualizarView()
			punto.x = mcRef._x
			punto.y = mcRef._y
			//trace(punto)
		}else {
			actualizarDatos()
			actualizarView()
		}
	}
	private function actualizarDatos() {
		vectorDeseado = new Vector(0, 0)
		vectorDeseado = fuerzas.sumarFuerza(vectorDeseado)
		var componenteInterpolado:Number=Number2.interpolar(vector.componente, vectorDeseado.componente, 0.2)
		vector =  new Vector(componenteInterpolado, vectorDeseado.anguloDeg)
		//trace("   vector ("+id+"): "+vector.toString())
		var puntoTemp:Punto = PuntoUtils.sumarPuntos(punto, PuntoUtils.polar(vector.componente, vector.anguloRad))
		actualizarPunto(puntoTemp)

	}
	private function actualizarView():Void {
		var obj:Object = new Object()
		obj.type = "onActualizarView"
		obj.particula = this
		obj.imanActivado = imanActivado
		obj.puntoIman = puntoIman
		emisor.emitir_objeto(obj)
	}
	private function actualizarPunto(puntoAux:Punto):Void {
		punto.x = puntoAux.x
		punto.y = puntoAux.y
	}
	//--------------------
	// EVENTOS:
	public function onTempo() {
		actualizar()
	}
	//--------------------
	// EVENTOS:
	public function onActivarIman(obj:Object) {
		imanActivado=true
		puntoIman=obj.punto
	}
	public function onDesactivarIman(obj:Object) {
		imanActivado=false
		puntoIman=null
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onInitView", ref);
		emisor.addEventListener("onActualizarView", ref);
		emisor.addEventListener("onEmpezarDrag", ref);
		emisor.addEventListener("onPararDrag", ref);
		
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
	public function removeAllListeners() {
		emisor.removeAllListeners()
	}
	//--------------------
	// SNIPPETS:
}