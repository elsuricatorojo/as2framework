/*
DOCUMENTACION:
* Roberto Ferrero - hola@robertoferrero.es
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 02/05/2013 13:20
*/
//import tv.zarate.Utils.Trace;
//import com.ionewmedia.utils.eventos.EmisorExtendido;
class com.ionewmedia.utils.core.datos.DatosOpcionMenuBasico {
	// import com.ionewmedia.utils.core.datos.DatosOpcionMenuBasico
	//--------------------
	// DOCUMENTACION:
	/*
	 <menu>
		<item id="01_librerias" color="FF0000">
			<nombre><![CDATA[Ya en las<br>librerías]]></nombre>
			<texto2><![CDATA[Texto 2]]></texto2>
			<external_path>http://www.elpais.es</external_path>
			<imagen1_path>data/menu/01_librerias.png</imagen1_path>
			<imagen2_path>data/menu/01_librerias.png</imagen2_path>
		</item>
	</menu>
	 */
	//--------------------
	// PARAMETROS:
	public var opcionId:String
	public var nombre:String
	public var texto2:String
	public var colorString:String
	public var colorHex:Number
	public var external_path:String
	public var imagen1_path:String
	public var imagen2_path:String
	//--------------------
	// CONSTRUCTORA:
	public function DatosOpcionMenuBasico() {
		trace("DatosOpcionMenuBasico.CONSTRUCTORA)!")
	}
	//--------------------
	// METODOS PUBLICOS:
	// Getters:
	public function getObject():Object {
		var obj:Object = new Object()
		obj.opcionId = opcionId
		obj.nombre = nombre
		obj.texto2 = texto2
		obj.colorString = colorString
		obj.colorHex = colorHex
		obj.external_path = external_path
		obj.imagen1_path = imagen1_path
		obj.imagen2_path = imagen2_path
		return obj
	}
	// Setters:
	//--------------------
	// METODOS PRIVADOS:
	//--------------------
	// EMISOR:
	//--------------------
	// EVENTOS:
	//--------------------
	// SNIPPETS:
}