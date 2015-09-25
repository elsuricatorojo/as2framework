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
import com.ionewmedia.utils.estaticas.Array2;
//--
import com.ionewmedia.utils.componentes.arbolLogico.ArbolLogico;
class com.ionewmedia.utils.componentes.arbolLogico.RamaLogica {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:EmisorExtendido;
	//---
	private var ramaId:String;
	private var arbol:ArbolLogico;
	private var padre:RamaLogica;
	private var ramas:Object;
	private var generacion:Number;
	private var profundidad:Number;
	private var zRelativo:Number;
	private var minRelativo:Number = 0;
	private var maxRelativo:Number = 0;
	//--
	public var array_genealogico:Array;
	//--------------------
	// CONSTRUCTORA:
	function RamaLogica(_ramaId:String, _arbol:ArbolLogico, _padre:RamaLogica, _generacion:Number, _zRelativo:Number) {
		// ramaId, arbol, padre, generacion, zRelativo
		trace("-------------");
		trace("(RamaLogica.CONSTRUCTORA): "+_ramaId);
		ramaId = _ramaId;
		arbol = _arbol;
		padre = _padre;
		generacion = _generacion;
		zRelativo = _zRelativo;
		init_ramas();
		//--
		arbol.addEventListener("onNuevoOrden",this);
		//--
		if (generacion>0) {
			array_genealogico = Array2.copiaDeEsteArray(padre.array_genealogico);
		} else {
			array_genealogico = new Array();
		}
		array_genealogico.push(ramaId);
		trace("   array_genealogico: "+array_genealogico);
	}
	function init() {
		arbol.actualizar();
	}
	//--------------------
	// METODOS PUBLICOS:
	public function add_rama(plano:String) {
		trace("(RamaLogica.add_rama): "+plano);
		var autoNum:Number = arbol.get_autonumerico();
		var nueva_ramaId:String = "rama_"+autoNum;
		trace("   nueva_ramaId: "+nueva_ramaId)
		var nueva_generacion = generacion+1;
		if (plano == "back") {
			minRelativo = minRelativo-1;
			var nuevo_zRelativo:Number = minRelativo;
			ramas.array_zRelativos = Array2.pull(ramas.array_zRelativos, nuevo_zRelativo);
			ramas.array_items = Array2.pull(ramas.array_items, nueva_ramaId);
		} else {
			maxRelativo = maxRelativo+1;
			var nuevo_zRelativo:Number = maxRelativo;
			ramas.array_zRelativos.push(nuevo_zRelativo);
			ramas.array_items.push(nueva_ramaId);
		}
		ramas[nueva_ramaId] = new RamaLogica(nueva_ramaId, arbol, this, nueva_generacion, nuevo_zRelativo);
		ramas[nueva_ramaId].init();
	}
	public function get_descendencia():Number {
		var descendencia:Number = 1;
		for (var i = 0; i<ramas.array_items.length; i++) {
			var subramaId:String = ramas.array_items[i];
			var numSubramas:Number = ramas[subramaId].get_descendencia();
			descendencia += numSubramas;
		}
		return (descendencia);
	}
	//--------------------
	// GETTERS:
	public function get_dataRama ():Object {
		var dataRama:Object=new Object()
		dataRama.ramaId=ramaId
		dataRama.arbol=arbol
		dataRama.padre=padre
		dataRama.ramas=ramas
		dataRama.generacion=generacion
		dataRama.profundidad=profundidad
		dataRama.zRelativo=zRelativo
		dataRama.minRelativo=minRelativo
		dataRama.maxRelativo=maxRelativo
		return (dataRama);
	}
	public function get_ramasOrdenadas():Array {
		//trace("(RamaLogica.get_ramasOrdenadas): "+ramaId);
		var ramasOrdenadas:Array = new Array();
		var sumado:Boolean = false;
		var arrayTemp_items:Array = new Array();
		var arrayTemp_zRelativos:Array = new Array();
		if (ramas.array_items.length>0) {
			//trace("   ramas.array_items: "+ramas.array_items);
			//trace("   ramas.array_zRelativos: "+ramas.array_zRelativos);
			for (var i = 0; i<ramas.array_items.length; i++) {
				var nueva_ramaId:String = ramas.array_items[i];
				var nuevo_zRelativo:Number = ramas.array_zRelativos[i];
				//trace("     nueva_ramaId: "+nueva_ramaId);
				//trace("     nuevo_zRelativo: "+nuevo_zRelativo);
				if (nuevo_zRelativo<0) {
					// Para las ramas "negativas"
					arrayTemp_items.push(nueva_ramaId);
					arrayTemp_zRelativos.push(nuevo_zRelativo);
					//.lo dejo aqui.
					
				} else {
					if (!sumado) {
						sumado = true;
						ramasOrdenadas.push(ramaId);
					}
					var array_subramas:Array = ramas[nueva_ramaId].get_ramasOrdenadas();
					ramasOrdenadas = Array2.sumarArrays(ramasOrdenadas, array_subramas);
				}

			}
			if (arrayTemp_items.length>0) {
				arrayTemp_items.reverse();
				arrayTemp_zRelativos.reverse();
				for (var i = 0; i<arrayTemp_items.length; i++) {
					var nueva_ramaId:String = arrayTemp_items[i];
					var nuevo_zRelativo:Number = arrayTemp_zRelativos[i];
					var array_subramas:Array = ramas[nueva_ramaId].get_ramasOrdenadas();
					ramasOrdenadas = Array2.sumarArrays(array_subramas, ramasOrdenadas);
				}
			}
		} else {
			ramasOrdenadas.push(ramaId);
		}
		//trace("   ramasOrdenadas: "+ramasOrdenadas);
		return (ramasOrdenadas);
	}
	public function get_subrama(subramaId:String):RamaLogica {
		var existe:Boolean = Array2.estaEnElArray(ramas.array_items, subramaId);
		if (existe) {
			return (ramas[subramaId]);
		} else {
			return (null);
		}
	}
	//--------------------
	// METODOS PRIVADOS:
	function init_ramas() {
		ramas = new Object();
		ramas.array_items = new Array();
		ramas.array_zRelativos = new Array();
	}
	//--------------------
	// EVENTOS:
	public function onNuevoOrden(obj:Object) {
		//trace("(RamaLogica.onNuevoOrden): "+ramaId);
		var profundidadId:Number = obj.objProfundidad[ramaId].profundidad;
		var nuevaProfundidad:Number;
		if (obj.profundidadPar) {
			nuevaProfundidad = 10*profundidadId;
		} else {
			nuevaProfundidad = (10*profundidadId)+1;
		}
		if (nuevaProfundidad != profundidad) {
			profundidad = nuevaProfundidad;
			var obj:Object = new Object();
			obj.type = "onNuevaProfundidad";
			obj.profundidad = profundidad;
			emisor.emitir_objeto(obj);
		}
	}
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		emisor.addEventListener("onNuevaProfundidad",ref);
	}
	public function addEventListener(evento:String, ref:Object) {
		emisor.addEventListener(evento,ref);
	}
	public function removeListener(ref:Object) {
		emisor.removeListener(ref);
	}
	public function removeEventListener(evento:String, ref:Object) {
		emisor.removeEventListener(evento,ref);
	}
	//--------------------
	// SNIPPETS:
}