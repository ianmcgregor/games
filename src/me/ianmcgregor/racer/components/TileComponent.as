package me.ianmcgregor.racer.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public class TileComponent extends Component {
		/**
		 * id 
		 */
		public var id : uint;
		/**
		 * index 
		 */
		public var index : int;
		/**
		 * texture 
		 */
		public var texture : String;
		/**
		 * type 
		 */
		public var type : String;
		/**
		 * direction 
		 */
		public var direction : int;
		/**
		 * curveTo 
		 */
		public var curveTo : Number;
		/**
		 * cornerA 
		 */
		public var cornerA : Number;
		/**
		 * cornerB 
		 */
		public var cornerB : Number;
		/**
		 * climb 
		 */
		public var climb : int;
		
		/**
		 * row 
		 */
		public var row : Number;
		/**
		 * col 
		 */
		public var col : Number;
		/**
		 * z 
		 */
		public var z : Number;
		
		/**
		 * TileComponent 
		 */
		public function TileComponent() {
		}
		
		/**
		 * toString 
		 * 
		 * @return 
		 */
		public function toString() : String {
			return "[TileComponent] id:" + id + ", index:" + index + ", texture:" + texture + ", type:" + type + ", row:" + row + ", col:" + col;
		}
	}
}
