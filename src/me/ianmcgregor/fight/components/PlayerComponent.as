package me.ianmcgregor.fight.components {
	import com.artemis.Entity;
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerComponent extends Component {
		/**
		 * playerNum 
		 */
		public var playerNum : int;
		public var opponent : Entity;
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
