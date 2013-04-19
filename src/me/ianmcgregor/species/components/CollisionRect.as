package me.ianmcgregor.species.components {
	import flash.geom.Rectangle;
	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public class CollisionRect extends Component {
		/**
		 * _rect 
		 */
		private var _rect : Rectangle;
		/**
		 * CollisionRect 
		 * 
		 * @param x 
		 * @param y 
		 * @param width 
		 * @param height 
		 * 
		 * @return 
		 */
		public function CollisionRect(x: int, y: int, width: int, height: int) {
			_rect = new Rectangle(x, y, width, height);
		}

		/**
		 * rect 
		 */
		public function get rect() : Rectangle {
			return _rect;
		}
		
	}
}
