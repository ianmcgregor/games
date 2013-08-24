package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerComponent extends Component {
		/**
		 * playerNum 
		 */
		public var playerNum : int;
		public var score : uint;

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
