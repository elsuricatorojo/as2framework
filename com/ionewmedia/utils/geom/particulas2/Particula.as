/*
DOCUMENTACION:
* Roberto Ferrero - roberto@ionewmedia.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 01/03/2010 22:58
*/
//import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.estaticas.Number2;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.vectores.Vector;
import com.ionewmedia.utils.timers.frameBased.Tempo
import com.ionewmedia.utils.geom.trigonometria.MathUtil 
//--
class com.ionewmedia.utils.geom.particulas2.Particula {
	// import com.ionewmedia.utils.geom.particulas2.Particula
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var id:String = null
	//--
	private var emisor:EmisorExtendido;
	private var tempo:Tempo
	//--
	public var punto:Punto // Posicion de la particula
	public var velocidad:Vector // Vector de velocidad
	public var aceleracion:Vector // Vector de aceleracion de la particula. Considerese como un motor de la misma.
	public var inerciaMod:Number = 0.1// Resistencia al cambio {0 -> 1}
	//--------------------
	// CONSTRUCTORA:
	public function Particula(posX:Number, posY:Number, _velocidad:Vector, _aceleracion:Vector) {
		//trace("(Particula.CONSTRUCTORA): "+posX)
		emisor = new EmisorExtendido()
		tempo = Tempo.getInstance()
		tempo.addListener(this)
		//--
		posX = filtrarValor(posX, 0)
		posY = filtrarValor(posY, 0)
		punto = new Punto(posX, posY)
		//--
		var vector0:Vector = new Vector(0, 0)
		if (_velocidad!=undefined && _velocidad!=null) {
			velocidad =_velocidad 
		}else {
			velocidad = vector0.clone()
		}
		if (_aceleracion!=undefined && _aceleracion!=null) {
			aceleracion =_aceleracion 
		}else {
			aceleracion = vector0.clone()
		}
		//--
		//trace("   punto: "+punto)
		//trace("   velocidad: "+velocidad)
		//trace("   aceleracion: "+aceleracion)
		
	}
	//--------------------
	// METODOS PUBLICOS:
	public function actualizar() {
		//trace("(Particula.actualizar)!")
		var aceleracionAplicable:Vector = aceleracion.clone()
		var inercia:Vector = get_inercia()
		aceleracionAplicable.sumarVector(inercia)
		//trace("   inercia: "+inercia)
		//trace("   aceleracionAplicable: "+aceleracionAplicable)
		//--
		var vectorMovimiento:Vector = velocidad.clone()
		vectorMovimiento.sumarVector(aceleracionAplicable)
		//--
		punto.sumar(vectorMovimiento.puntoFinal)
		velocidad = vectorMovimiento
		//--
		emisor.emitir("onActualizarParticula")
	}
	public function initKill() {
		tempo.removeListener(this)
		this.removeAllListeners()
	}
	// Getters:
	public function get_inercia():Vector {
		// El vector inecria es opuesto al de aceleracion y es una fracción de su componente definido por el param inerciaMod
		var anguloOpuesto:Number = aceleracion.anguloDeg + 180
		anguloOpuesto = MathUtil.fixAngle(anguloOpuesto)
		var componente:Number = Number2.interpolar(0, aceleracion.componente, inerciaMod)
		var inercia:Vector = new Vector(componente, anguloOpuesto)
		return inercia
	}
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	
	//--
	private function filtrarValor(valor, valorPorDefecto) {
		var valorFiltrado
		if (valor != undefined && valor != null) {
			valorFiltrado = valor
		}else {
			valorFiltrado = valorPorDefecto
		}
		return valorFiltrado
	}
	//--------------------
	// EMISOR:
	
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
	// EVENTOS:
	// de Tempo:
	private function onTempo() {
		//trace("(Particula.onTempo)!")
		actualizar()
	}
	//--------------------
	// SNIPPETS:
}