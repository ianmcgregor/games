package me.ianmcgregor.games.utils.ogmo {
	/**
	 * @author ianmcgregor
	 */
	public final class OgmoEntity {
		public var type : String;
		public var id : String;
		public var x : Number;
		public var y : Number;
		public var width : Number;
		public var height : Number;
		public var angle : Number;

		public function OgmoEntity(type : String) {
			this.type = type;
		}

		public function toString() : String {
			return "OgmoEntity type=" + type + ", id=" + id + ", x=" + x + ", y=" + y + ", width=" + width + ", height=" + height;
		}
	}
}
