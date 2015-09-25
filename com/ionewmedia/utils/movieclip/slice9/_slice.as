//-------------------
// INCLUDES:
// Se incluye en los Slices de "90 AreaEscalable"
//-------------------
// PARAMETROS:
// Recibe en obClipEvent:
var sliceId:Number;
var logica:MovieClip;
//-------------------
// ACCIONES:
init();
//-------------------
// FUNCIONES:
function init() {
	logica = _parent;
	logica.notify_slice(this, sliceId);
}
//-------------
// 'Publicas':
//-------------
// 'Privadas':
function reposicionar(objData:Object) {
	//trace("(Slice"+sliceId+".reposicionar)!");
	this._x = objData.array_x[sliceId];
	this._y = objData.array_y[sliceId];
	this._width = objData.array_width[sliceId];
	this._height = objData.array_height[sliceId];
}
function redimensionar(objData:Object) {
	//trace("(Slice"+sliceId+".redimensionar)!");
	var x = objData.array_x[sliceId];
	var y = objData.array_y[sliceId];
	var ancho = objData.array_width[sliceId];
	var alto = objData.array_height[sliceId];
	this.stopTween();
	this.slideTo(x, y, segundos, easeType);
	this.tween("_width", ancho, segundos, easeType);
	this.tween("_height", alto, segundos, easeType);
}
//-------------------
// BOTONES
//-------------------
// EVENTOS:
function onReposicionar(objEvento:Object) {
	//trace("(Slice"+sliceId+".onReposicionar)!");
	reposicionar(objEvento.objData);
}
function onRedimensionar(objEvento:Object) {
	//trace("(Slice"+sliceId+".onRedimensionar)!");
	segundos = objEvento.segundos;
	easeType = objEvento.easeType;
	redimensionar(objEvento.objData);
}
//-------------------
// SNIPPETS
