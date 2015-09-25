/*
DOCUMENTACION:
*Creada el 20051212.
*Basada en "localToGlobal"
*	Dado un movieclip y una cordenada 'A' dentro del mismo
*	la clase devuelve en una cordenada 'B' la proyección de la coordenada 'A'
*	sobre el _parent del moviclip dado.
*	Util para hayar las codenadas de un punto en un movieclip que
*	pueda tener trnasformaciones de escala y/o rotación, mc con guia de movimiento.
*
*
* io newmedia S.L. - http://www.zona-io.com  || 
* roberto@zona-io.com		(Roberto Ferrero)
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/	
*/
class com.ionewmedia.utils.movieclip_utils.TrackPoint {
	//-------------------------------------------------
	// PARAMETROS:
	private var dondeCont:MovieClip;
	private var dondeMc:MovieClip;
	private var point_x:Number;
	private var point_y:Number;
	private var point_gx:Number;
	private var point_gy:Number;
	private var mc_gx:Number;
	private var mc_gy:Number;
	//-------------------------------------------------
	// PARAMETROS:
	function TrackPoint(mc:MovieClip, px:Number, py:Number) {
		trace("(TrackPoint.CONSTRUCTORA)!");
		dondeMc = mc;
		point_x = px;
		point_y = py;
	}
	//-------------------------------------------------
	// PUBLICOS:
	public function get_pos():Object {
		//trace("(TrackPoint.get_pos)!");
		update();
		var inc_x = point_gx-mc_gx;
		var inc_y = point_gy-mc_gy;
		var objPoint = new Object();
		objPoint.x = dondeMc._x+inc_x;
		objPoint.y = dondeMc._y+inc_y;
		return objPoint;
	}
	//----------------------------
	// PRIVADAS:
	private function update() {
		update_mc();
		update_point();
	}
	private function update_mc() {
		var objPoint = new Object();
		objPoint.x = dondeMc._x;
		objPoint.y = dondeMc._y;
		dondeMc._parent.localToGlobal(objPoint);
		mc_gx = objPoint.x;
		mc_gy = objPoint.y;
	}
	private function update_point() {
		var objPoint = new Object();
		objPoint.x = point_x;
		objPoint.y = point_y;
		dondeMc.localToGlobal(objPoint);
		point_gx = objPoint.x;
		point_gy = objPoint.y;
	}
}
