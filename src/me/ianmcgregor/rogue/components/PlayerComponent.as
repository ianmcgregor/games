package me.ianmcgregor.rogue.components {
	import me.ianmcgregor.rogue.constants.Constants;

	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerComponent extends Component {
		/**
		 * playerNum 
		 */
		public var playerNum : int;
		public var attack : int = Constants.ATTACK_READY;
		public var dead : int = Constants.DEATH_NONE;

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
