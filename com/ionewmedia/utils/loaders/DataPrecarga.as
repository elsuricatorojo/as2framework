import com.ionewmedia.utils.eventos.gestoreventos.GestorEventos
class com.ionewmedia.utils.loaders.DataPrecarga extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	private var emisor:GestorEventos;
	//--
	var destino_mc:MovieClip;
	var callBack:Object;
	var eventoUpdate:String;
	var eventoFinalCarga:String;
	var quantos:Number;
	var contador:Number;
	//--------------------
	// CONSTRUCTORA:
	function DataPrecarga() {
		trace("(DataPrecarga.CONSTRUCTORA)!");
		//--
	}
	//--------------------
	// METODOS PUBLICOS:
	public function init(dmc:MovieClip, cB:Object, eUD:String, eFC:String, q:Number) {
		//(destino_mc, dondeCallBack, eventoUpdate, eventoFinalCarga, limitacion)
		trace("(DataPrecarga.init)!");
		destino_mc = dmc;
		callBack = cB;
		eventoUpdate = eUD;
		eventoFinalCarga = eFC;
		trace("   destino_mc: "+destino_mc);
		trace("   callBack: "+callBack);
		trace("   eventoUpdate: "+eventoUpdate);
		trace("   eventoFinalCarga: "+eventoFinalCarga);
		if (q == undefined || q == null) {
			quantos = 100;
		} else {
			quantos = q;
		}
		trace("   quantos: "+quantos);
		contador = 0;
		//--
		init_emisor();
		//--
		go();
	}
	//--------------------
	// METODOS PRIVADOS:
	private function go() {
		//trace("(DataPrecarga.go)!");
		this.onEnterFrame = function() {
			update();
			contador++;
		};
	}
	private function update() {
		//trace("(DataPrecarga.update)!");
		var totales = destino_mc.getBytesTotal();
		var cargados = destino_mc.getBytesLoaded();
		var porcentaje = Math.floor((cargados/totales)*100);
		// Limitador
		if (porcentaje>(contador*quantos)) {
			porcentaje = contador*quantos;
		}
		var objEvento = new Object();
		objEvento.type = eventoUpdate;
		objEvento.porcentaje = porcentaje;
		emisor.emitir_objeto(objEvento);
		if (porcentaje == 100) {
			emisor.emitir_evento(eventoFinalCarga);
			kill();
		}
	}
	private function kill() {
		delete this.onEnterFrame;
		this.removeMovieClip();
	}
	//--------------------
	// METODOS NOTIFYs:
	//--------------------
	// EMISOR:
	private function init_emisor() {
		emisor = new GestorEventos();
		emisor.registrar(eventoFinalCarga, callBack);
		emisor.registrar(eventoUpdate, callBack);
	}
	//--------------------
	// SNIPPETS:
}
