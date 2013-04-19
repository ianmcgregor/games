package me.ianmcgregor.racer.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class GameComponent extends Component {
		
		/**
		 * type 
		 */
		public var type : String;
		/**
		 * _state 
		 */
		private var _state : int;
		
		/**
		 * GameComponent 
		 */
		public function GameComponent() {
		}

		/**
		 * state 
		 */
		public function get state() : int {
			return _state;
		}

		/**
		 * @private
		 */
		public function set state(state : int) : void {
			_state = state;
		}
	}
}
