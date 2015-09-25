/*
DOCUMENTACION:
- get_randomBoolean():Boolean
     Devuelve true o false con un ratio de probabilidad de 0.5
- valorPar(valor:Number):Boolean
*
* io newmedia S.L. - http://www.zona-io.com  
* roberto@zona-io.com
* This code is under a Creative Commons Attribution License
* http://creativecommons.org/licenses/by/2.5/
*/
class com.ionewmedia.utils.estaticas.Boolean2 {
	static function get_randomBoolean():Boolean {
		var valor:Boolean;
		var dado:Number = Math.random();
		if (dado < 0.5) {
			valor = true;
		} else {
			valor = false;
		}
		return (valor);
	}
}