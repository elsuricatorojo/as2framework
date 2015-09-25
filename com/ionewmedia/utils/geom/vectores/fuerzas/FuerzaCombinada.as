/*
DOCUMENTACION:
* io newmedia S.L. - http://www.zona-io.com  
* Roberto Ferrero - roberto@zona-io.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 2008
*/
import com.ionewmedia.utils.geom.vectores.Vector
import com.ionewmedia.utils.geom.vectores.VectorUtils
import com.ionewmedia.utils.geom.Punto;
import com.ionewmedia.utils.geom.vectores.Fuerza;
import tv.zarate.Utils.Trace;
import com.ionewmedia.utils.eventos.EmisorExtendido
import com.ionewmedia.utils.estaticas.Object2
import com.ionewmedia.utils.data.Datos
class com.ionewmedia.utils.geom.vectores.fuerzas.FuerzaCombinada implements Fuerza {
	//--------------------
	// DOCUMENTACION:
	//--------------------
	// PARAMETROS:
	public var activo:Boolean=true
	private var contadorFuerzas:Number=0
	private var data:Datos
	//--------------------
	// CONSTRUCTORA:
	function FuerzaCombinada(){
		trace("(FuerzaCombinada.CONSTRUCTORA)!")
		data = new Datos("conjunto_fuerzas")
	}
	//--------------------
	// METODOS PUBLICOS:
	public function nuevaFuerza(fuerza:Fuerza, fuerzaId:String):String {
		if (fuerzaId == undefined || fuerzaId == null) {
			fuerzaId= "fuerza_" + contadorFuerzas
		}
		contadorFuerzas++
		data.nuevoItem(fuerzaId, fuerza)
		return fuerzaId
	}
	public function quitarFuerzaId (fuerzaId:String):Void {
		data.quitarItem(fuerzaId)
	}
	//--
	public function sumarFuerza(vector:Vector):Vector {
		if (vector == undefined || vector == null) {
			vector= new Vector(0, 0)
		}
		var vectorResultante:Vector
		//--
		if(activo){
			vectorResultante= new Vector(vector.componente, vector.anguloDeg)
			for (var i = 0; i < data.array_items.length; i++ ) {
				var itemId:String = data.array_items[i]
				var fuerza:Object = data.getItem(itemId)
				vectorResultante = fuerza.sumarFuerza(vectorResultante)
			}
			//trace("   vectorResultante: "+vectorResultante.toString())
		}else {
			vectorResultante = vector
		}
		return vectorResultante
	}
	public function getFuerza():Vector {
		var vectorFuerza:Vector = new Vector(0, 0)
		for (var i = 0; i < data.array_items.length; i++ ) {
			var itemId:String = data.array_items[i]
			var fuerza:Object = data.getItem(itemId)
			var vectorFuerzaItem:Vector = fuerza.getFuerza()
			vectorFuerza= VectorUtils.sumarVectores(vectorFuerza, vectorFuerzaItem)
		}
		return vectorFuerza
	}
	public function modifarParametroFuerza(fuerzaId:String, parametro:String, valor:Number) {
		var fuerza:Object = data.getItem(fuerzaId)
		fuerza[parametro]=valor
	}
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	public function addListener(ref:Object) {
		// NADA
	}
	public function addEventListener(evento:String, ref:Object) {
		// NADA
	}
	public function removeListener(ref:Object) {
		// NADA
	}
	public function removeEventListener(evento:String, ref:Object) {
		// NADA
	}
	//--------------------
	// SNIPPETS:
}