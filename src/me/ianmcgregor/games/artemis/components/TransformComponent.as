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
		 * _x 
		 */
		private var _x : Number;
		/**
		 * _y 
		 */
		private var _y : Number;
		/**
		 * _rotation 
		 */
		private var _rotation : Number;
		/**
		 * _scale 
		 */
		private var _scale : Number;

		/**
		 * TransformComponent 
		 * 
		 * @param x 
		 * @param y 
		 * @param rotation 
		 * 
		 * @return 
		 */
		public function TransformComponent(x : Number = 0, y : Number = 0, rotation : Number = 0, scale: Number = 1) {
			_x = x;
			_y = y;
			_rotation = rotation;
			_scale = scale;
		}

		/**
		 * addX 
		 * 
		 * @param x 
		 * 
		 * @return 
		 */
		public function addX(x : Number) : void {
			_x += x;
		}

		/**
		 * addY 
		 * 
		 * @param y 
		 * 
		 * @return 
		 */
		public function addY(y : Number) : void {
			_y += y;
		}

		/**
		 * x 
		 */
		public function get x() : Number {
			return _x;
		}

		/**
		 * @private
		 */
		public function set x(x : Number) : void {
			_x = x;
		}

		/**
		 * y 
		 */
		public function get y() : Number {
			return _y;
		}

		/**
		 * @private
		 */
		public function set y(y : Number) : void {
			_y = y;
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
			_x = x;
			_y = y;
		}

		/**
		 * rotation 
		 */
		public function get rotation() : Number {
			return _rotation;
		}

		/**
		 * @private
		 */
		public function set rotation(rotation : Number) : void {
			_rotation = rotation;
		}

		/**
		 * addRotation 
		 * 
		 * @param angle 
		 * 
		 * @return 
		 */
		public function addRotation(angle : Number) : void {
			_rotation = (_rotation + angle) % 360;
		}

		/**
		 * getRotationAsRadians 
		 * 
		 * @return 
		 */
		public function getRotationAsRadians() : Number {
			return Utils.toRadians(_rotation);
		}

		/**
		 * getDistanceTo 
		 * 
		 * @param t 
		 * 
		 * @return 
		 */
		public function getDistanceTo(t : TransformComponent) : Number {
			return Utils.distance(t.x, t.y, _x, _y);
		}

		/**
		 * scale 
		 */
		public function get scale() : Number {
			return _scale;
		}

		/**
		 * set scale
		 * 
		 * @param scale
		 */
		public function set scale(scale: Number) : void {
			_scale = scale;
		}
	}
}