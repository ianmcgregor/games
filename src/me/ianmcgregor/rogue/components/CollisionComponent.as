package me.ianmcgregor.rogue.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class CollisionComponent extends Component {
		public var x : Number;
		public var y : Number;
		public var width : Number;
		public var height : Number;

		public function CollisionComponent(x: Number, y: Number, width : Number, height : Number) {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
	}
}
