class com.ionewmedia.utils.forms.FondoCampo extends MovieClip {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	var campo:String;
	//--------------------
	// CONSTRUCTORA:
	function FondoCampo() {
		trace("(FondoCampo.CONSTRUCTORA)! "+this._name);
		var arrayName = this._name.split("_");
		campo = arrayName[0];
		trace("   campo: "+campo);
	}
	//--------------------
	// METODOS PUBLICOS:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EVENTOS:
	public function onCampoOK(objEvento:Object):Void {
		//trace("(FondoCampo.onCampoOK)! "+this._name);
		var campoEvento = objEvento.campo;
		if (campoEvento == campo) {
			this.gotoAndStop("OK");
		}
	}
	public function onCampoKO(objEvento:Object):Void {
		//trace("(FondoCampo.onCampoKO)! "+this._name);
		var campoEvento = objEvento.campo;
		if (campoEvento == campo) {
			this.gotoAndStop("KO");
		}
	}
	//--------------------
	// SNIPPETS:
}
