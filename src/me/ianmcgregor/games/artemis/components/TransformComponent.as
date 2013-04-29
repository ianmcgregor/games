package me.ianmcgregor.games.artemis.components {
	import com.artemis.Component;
	import com.artemis.utils.Utils;

	/**
	 * TransformComponent 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class TransformComponent extends Component {
		/**
		 * x, y 
		 */
		public var x : Number;
		public var y : Number;
		/**
		 * width, height 
		 */
		public var width : Number;
		public var height : Number;
		/**
		 * _rotation 
		 */
		public var rotation : Number;
		/**
		 * _scale 
		 */
		public var scale : Number;

		/**
		 * TransformComponent 
		 * 
		 * @param x 
		 * @param y 
		 * @param rotation 
		 * 
		 * @return 
		 */

		public function TransformComponent(x : Number = 0, y : Number = 0, width : Number = 0, height : Number = 0, rotation : Number = 0, scale : Number = 1) {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.rotation = rotation;
			this.scale = scale;
		}

		/**
		 * addX 
		 * 
		 * @param x 
		 * 
		 * @return 
		 */
		public function addX(x : Number) : void {
			this.x += x;
		}

		/**
		 * addY 
		 * 
		 * @param y 
		 * 
		 * @return 
		 */
		public function addY(y : Number) : void {
			this.y += y;
		}

		/**
		 * setLocation 
		 * 
		 * @param x 
		 * @param y 
		 * 
		 * @return 
		 */
		public function setLocation(x : Number, y : Number) : void {
			this.x = x;
			this.y = y;
		}

		/**
		 * addRotation 
		 * 
		 * @param angle 
		 * 
		 * @return 
		 */
		public function addRotation(angle : Number) : void {
			this.rotation = (this.rotation + angle) % 360;
		}

		/**
		 * getRotationAsRadians 
		 * 
		 * @return 
		 */
		public function getRotationAsRadians() : Number {
			return Utils.toRadians(this.rotation);
		}

		/**
		 * getDistanceTo 
		 * 
		 * @param t 
		 * 
		 * @return 
		 */
		public function getDistanceTo(t : TransformComponent) : Number {
			return Utils.distance(t.x, t.y, this.x, this.y);
		}
	}
}