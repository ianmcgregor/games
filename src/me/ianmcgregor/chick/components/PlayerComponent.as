package me.ianmcgregor.chick.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerComponent extends Component {
		/**
		 * playerNum 
		 */
		public var playerNum : int;
		
		public var direction: int;

		/**
		 * PlayerComponent 
		 * 
		 * @param playerNum 
		 * 
		 * @return 
		 */
		public function PlayerComponent(playerNum : int) {
			this.playerNum = playerNum;
		}
	}
}
