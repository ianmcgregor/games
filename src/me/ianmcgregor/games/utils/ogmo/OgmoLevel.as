package me.ianmcgregor.games.utils.ogmo {
	import flash.geom.Point;
	import me.ianmcgregor.games.utils.astar.Grid;
	/**
	 * @author ianmcgregor
	 */
	public final class OgmoLevel {
		public var name : String;
		public var width : uint;
		public var height : uint;
		public var camera : Point;
		public var grid : Vector.<Vector.<Boolean>>;
		public var tiles : Vector.<Vector.<uint>>;
		public var nodes : Grid;
		public var entities : OgmoEntityMap;
		public var entities2 : OgmoEntityMap;

		public function OgmoLevel(name : String) {
			this.name = name;
		}

		/**
		 * Utils
		 */
		public function gridString(array : Vector.<Vector.<Boolean>>) : String {
			var s : String = "";
			var l : int = array.length;
			for (var i : int = 0; i < l; ++i) {
				if (s != "") s += "\n";
				var len : int = array[i].length;
				for (var j : int = 0; j < len; ++j) {
					s += array[i][j] == true ? "1" : "0";
				}
			}
			return s;
		}

		public function toString() : String {
			return "--------- OgmoLevel --------- \nname:" + name + "\n\ngrid:\n" + gridString(grid) + "\n\nentities:\n" + entities.toString() + "\n";
		}
	}
}