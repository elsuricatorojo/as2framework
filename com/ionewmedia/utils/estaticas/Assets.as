class com.ionewmedia.utils.estaticas.Assets {
	public static function generateExcludeXML():Void {
		// Marta Sanchez de DMSTK
		trace("<excludeAssets>");
		var showClasses:Function = function (nameSpace:Object, packageName:String):Void {
			for (var i in nameSpace) {
				if (typeof (nameSpace[i]) == "function") {
					trace('\t<asset name="'+packageName+i+'"/>');
				} else {
					showClasses(nameSpace[i], packageName+i+".");
				}
			}
		};
		showClasses(_global, "");
		trace("</excludeAssets>");
	}
	public static function listarClases():Void {
		// Basado en Marta Sanchez de DMSTK
		trace("<usedAssets>------------------------------");
		var showClasses:Function = function (nameSpace:Object, packageName:String):Void {
			for (var i in nameSpace) {
				if (typeof (nameSpace[i]) == "function") {
					trace(packageName+i);
				} else {
					showClasses(nameSpace[i], packageName+i+".");
				}
			}
		};
		showClasses(_global, "");
		trace("</usedAssets>------------------------------");
	}
}
