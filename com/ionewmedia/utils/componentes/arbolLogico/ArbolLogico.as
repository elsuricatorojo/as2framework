/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070611
*/
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido;
import com.ionewmedia.utils.estaticas.Object2;
import com.ionewmedia.utils.numeros.Autonumerico;
//--
import com.ionewmedia.utils.componentes.arbolLogico.RamaLogica;
class com.ionewmedia.utils.componentes.arbolLogico.ArbolLogico {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	private var autonumerico:Autonumerico;
	private var gestionarProfundidad:Boolean = false;
	private var zSalto:Number = 10;
	private var profundidadPar:Boolean = true;
	private var raiz:RamaLogica;
	private var ramasTotales:Number = 0;
	private var data:Object;
	//--------------------
	// CONSTRUCTORA:
	function ArbolLogico() {
		trace("(ArbolLogico.CONSTRUCTORA)!");
		autonumerico = new Autonumerico(1);
		emisor=new EmisorExtendido()
	}
	public function init() {
		ramasTotales = 1;
		raiz = new RamaLogica("root", this, null, 0, 0);
		raiz.init()
	}
	public function actualizar() {
		trace("(ArbolLogico.actualizar)!");
		var ramasOrdenadas:Array = raiz.get_ramasOrdenadas();
		trace("   ramasOrdenadas: "+ramasOrdenadas);
		ramasTotales = ramasOrdenadas.length;
		//--
		if (gestionarProfundidad) {
			var objProfundidad:Object = new Object();
			for (var i = 0; i<ramasOrdenadas.length; i++) {
				var ramaId:String = ramasOrdenadas[i];
				objProfundidad[ramaId] = new Object();
				objProfundidad[ramaId].profundidad = i;
			}
			//--
			switch_profundidadPar();
			var obj:Object = new Object();
			obj.type = "onNuevoOrden";
			obj.ramasOrdenadas = ramasOrdenadas;
			obj.objProfundidad = objProfundidad;
			obj.profundidadPar = profundidadPar;
			emisor.emitir_objeto(obj);
		}
	}
	//------------
	// PRIVADAS:
	private function switch_profundidadPar() {
		if (profundidadPar) {
			profundidadPar = false;
		} else {
			profundidadPar = true;
		}
	}
	//------------
	// GETTERS:
	public function get_raiz():RamaLogica {
		return (raiz);
	}
	public function get_gestionarProfundidad():Boolean {
		return (gestionarProfundidad);
	}
	public function get_profundidadPar():Boolean {
		return profundidadPar;
	}
	public function get_autonumerico():Number {
		return (autonumerico.get());
	}
	//------------
	// SETTERS:
	public function set_gestionarProfundidad(valor:Boolean):Void {
		gestionarProfundidad = valor;
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onNuevoOrden", ref);
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
