package me.ianmcgregor.species.components {
	import com.artemis.Component;

	/**
	 * Velocity 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class Velocity extends Component {
		/**
		 * _velocityX 
		 */
		private var _velocityX : Number;
		/**
		 * _velocityY 
		 */
		private var _velocityY : Number;
		/**
		 * _speed 
		 */
		private var _speed : Number;

		/**
		 * Velocity 
		 * 
		 * @param velocityX 
		 * @param velocityY 
		 * @param speed 
		 * 
		 * @return 
		 */
		public function Velocity(velocityX : Number = 0, velocityY : Number = 0, speed : Number = 0) {
			_velocityX = velocityX;
			_velocityY = velocityY;
			_speed = speed;
		}

		/**
		 * velocityX 
		 */
		public function get velocityX() : Number {
			return _velocityX;
		}

		/**
		 * @private
		 */
		public function set velocityX(velocityX : Number) : void {
			_velocityX = velocityX;
		}

		/**
		 * velocityY 
		 */
		public function get velocityY() : Number {
			return _velocityY;
		}

		/**
		 * @private
		 */
		public function set velocityY(velocityY : Number) : void {
			_velocityY = velocityY;
		}

		/**
		 * speed 
		 */
		public function get speed() : Number {
			return _speed;
		}

		/**
		 * @private
		 */
		public function set speed(speed : Number) : void {
			_speed = speed;
		}

	}
}