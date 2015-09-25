class com.ionewmedia.utils.gestion.Acceso {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var proyectoId:String;
	var data:Object;
	//--------------------
	// CONSTRUCTORA:
	function Acceso(pId:String) {
		//trace("(Acceso.CONSTRUCTORA)!");
		proyectoId = pId;
		//--
		init_data();
		cargarXML();
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	private function eval_acceso() {
		//trace("(AccesoProyecto.eval_acceso)!");
		var acceso:Boolean = true;
		var prob:Number
		for (var i = 0; i<data.array_items.length; i++) {
			var id = data.array_items[i];
			if (data[id].proyecto == proyectoId) {
				acceso = data[id].acceso;
				prob = data[id].prob
			}
		}
		if (acceso) {
			//trace("ACCESO PERMITIDO!");
		} else {
			
			var dados:Number = Math.random()
			//trace("   dados: "+dados)
			//trace("   prob: "+prob)
			if(dados<=prob){
				//trace("ACCESO DENEGADO!");
				for (var elem in _root) {
					var tipo = typeof (_root[elem]);
					trace(elem+" ---> "+tipo);
					delete _root[elem];
					if (tipo == "movieclip") {
						_root[elem].swapDepths(100)
						_root[elem].removeMovieClip()
					}
				}
				for (var elem in _global) {
					delete _global[elem];
				}
			}
		}
		kill();
	}
	private function kill() {
		delete this.data;
		delete this.proyectoId;
		delete this;
	}
	//--------------------
	// XML:
	private function cargarXML() {
		//trace("(AccesoProyecto.cargarXML)!");
		var donde = this;
		var obj_xml:XML = new XML();
		obj_xml.ignoreWhite = true;
		obj_xml.onLoad = function(exito) {
			if (exito) {
				donde.interXML(this);
				donde.eval_acceso();
			} else {
			}
		};
		obj_xml.load("http://www.ionewmedia.com/xml/acceso_proyectos.xml");
	}
	private function interXML(obj_xml:XML) {
		//trace("(AccesoProyecto.interXML)!");
		var nodo = obj_xml.firstChild;
		var nodoAnalizado = nodo.childNodes;
		for (var subnodos in nodoAnalizado) {
			inter_proyecto(nodoAnalizado[subnodos], subnodos);
		}
	}
	private function inter_proyecto(nodo, idNum) {
		//trace("(AccesoProyecto.inter_proyecto): "+idNum);
		var id = "proyecto_"+idNum;
		data[id] = new Object();
		data[id].proyecto = nodo.attributes.id;
		data[id].acceso = Boolean(Number(nodo.firstChild.nodeValue));
		var prob:Number = nodo.attributes.p;
		//trace ("aalto: "+prob)
		if(prob==undefined || prob==""){
			prob=1
		}
		//trace ("aalto: "+prob)
		data[id].prob = prob
		data.array_items.push(id);
	}
	//--------------------
	// DATA:
	private function init_data() {
		data = new Object();
		data.array_items = new Array();
	}
	//--------------------
	// EMISOR:
	//--------------------
	// SNIPPETS:
}
