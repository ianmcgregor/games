package me.ianmcgregor.pong.components {
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
		private var _velocityX : int;
		/**
		 * _velocityY 
		 */
		private var _velocityY : Number;

		/**
		 * Velocity 
		 * 
		 * @param velocityX 
		 * @param velocityY 
		 * 
		 * @return 
		 */
		public function Velocity(velocityX : int = 0, velocityY : Number = 0) {
			_velocityX = velocityX;
			_velocityY = velocityY;
		}

		/**
		 * velocityX 
		 */
		public function get velocityX() : int {
			return _velocityX;
		}

		/**
		 * @private
		 */
		public function set velocityX(velocityX : int) : void {
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

	}
}