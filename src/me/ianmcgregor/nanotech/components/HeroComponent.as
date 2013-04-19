package me.ianmcgregor.nanotech.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class HeroComponent extends Component {
		/**
		 * player 
		 */
		public var player : int;
		private var _score : int;

		/**
		 * HeroComponent 
		 * 
		 * @param player 
		 * 
		 * @return 
		 */
		public function HeroComponent(player : int) {
			this.player = player;
		}

		public function addScore(i : int) : void {
			_score += i;
		}
		
		public function getScore() : int {
			return _score;
		}
	}
}
