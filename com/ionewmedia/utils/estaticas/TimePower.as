/*
DOCUMENTACION:
- coversorMilisegundos(valor:Number):Array
    Pasado un valor en milisegundos, el método devuelve un Array con la conversión [año,mes,hora,minuto,segundo]
- coversorSegundos(valor:Numbery):Array
     Pasado un valor en segundos, el método devuelve un Array con la conversión [hora,minuto,segundo]

* io newmedia S.L. - http://www.zona-io.com  
* Nacho - nacho@ionewmedia.com		
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
* Creada: 20070524
*/

//class com.ionewmedia.utils.estaticas.TimePower {
class com.ionewmedia.utils.estaticas.TimePower
{
	// NUEVO 31/08/2010 13:14
	// Se crean dos accesos corregidos a las dos funciones estaticas con el error ortografico ("coversor")
	static function conversorMilisegundos( valor:Number):Array {
		return coversorMilisegundos(valor)
	}
	static function conversorSegundos(valor:Number):Array {
		return coversorSegundos(valor)
	}
	// NUEVO 31/03/2011 22:52
	static function conversorMilisegundos2( valor:Number):Object {
		var obj:Object = new Object()
		var my_date:Date = new Date(valor);
		//--
		obj.ano=my_date.getFullYear()
		obj.mes=my_date.getMonth()
		obj.horas=my_date.getHours()
		obj.minutos=my_date.getMinutes()
		obj.segundos = my_date.getSeconds()
		//--
		obj.minutosFiltrado=filtro( obj.minutos )
		obj.segundosFiltrado = filtro( obj.segundos )
		//--
		return obj
	}
	
	// NUEVO 31/08/2010 13:14//
	static function coversorMilisegundos( valor:Number):Array
	{
		 
		var my_date:Date = new Date(valor);
		
		var ano:Number=my_date.getFullYear()
		var mes:Number=my_date.getMonth()
		var horas:Number=my_date.getHours()
		var minutos:Number=my_date.getMinutes()
		var segundos:Number=my_date.getSeconds()
					
		//var minutosFiltrado:String=filtro( minutos )
		var segundosFiltrado:String=filtro( segundos )
		
		
		
		var resultado:Array = Array();
		resultado.push(mes);
		resultado.push(horas-1);
		resultado.push(minutos);
		resultado.push(segundosFiltrado);
		
		
		return resultado
		
	}
	
	static function coversorSegundos( valor:Number ):Array
	{
		
		var horas:Number = Math.floor(valor / 24);
		var minutos:Number = Math.floor(valor / 60);
		var segundos = Math.floor(valor % 60);
		
		if (segundos < 10)
		{
			segundos = "0" + segundos;
		}
		
		
		var resultado:Array = Array();
		resultado.push(horas);
		resultado.push(minutos);
		resultado.push(segundos);
		
		return resultado
	}
	
	static function filtro( dato:Number ):String
	{
		var retorno:String;
		
		if(dato>9)
		{
			retorno=String(dato)
		}else
		{
			retorno=String("0"+dato)
		}
				
		return retorno
	}
}