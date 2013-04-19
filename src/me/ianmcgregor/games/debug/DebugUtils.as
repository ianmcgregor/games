package me.ianmcgregor.games.debug {
	import flash.net.LocalConnection;
	import flash.system.System;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;


	/**
	 * @author ianmcgregor
	 */
	public final class DebugUtils {
		/**
		 * enumerateProperties 
		 * 
		 * @param ob 
		 * 
		 * @return 
		 */
		public static function enumerateProperties(ob: *): void {
			/**
			 * xml 
			 */
			var xml: XML = describeType(ob);
			/**
			 * iable").attribute("name") 
			 */
			var names: XMLList = xml.descendants("variable").attribute("name");
			/**
			 * s 
			 */
			var s: String = '';
			s += '------ '+ ob +' properties ------\n';
			/**
			 * name 
			 */
			for each (var name : XML in names) {
					s += '\t' + name + ' = ' + ob[name];
					s += '\n';
			}
			s += '-------------------------------------\n';
			trace(s);
		}
		
		/**
		 * traceObject 
		 * 
		 * @param ob 
		 * @param prefix 
		 * 
		 * @return 
		 */
		public static function traceObject(ob : Object, prefix: String = "") : void {
			prefix == "" ? prefix = "-" : prefix += "-";
			/**
			 * i 
			 */
			for (var i : Object in ob) {
				trace(prefix + " " + i + " : " + ob[i]);
				if (ob[i] is Object) {
					traceObject(ob[i], prefix);
				}
			}
		}
		
		/**
		 * forceGC 
		 * 
		 * @return 
		 */
		public static function forceGC() : void {
			System.gc();
			try {
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			} catch (e : Error) {
			}
		}
		
		/**
		 * getClassName 
		 * 
		 * @param instance 
		 * 
		 * @return 
		 */
		public static function getClassName(instance : *): String {
			/**
			 * fullName 
			 */
			var fullName: String = getQualifiedClassName(instance);
			return fullName.substr(fullName.lastIndexOf(":") + 1);
		}
	}
}
