package me.ianmcgregor.tenseconds.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerComponent extends Component {
		/**
		 * playerNum 
		 */
		public var playerNum : int;
		public var selectedTower : int;
		public var lastRotation : int;
		public var rotationVelocity : Number = 0.02;

		/**
		 * PlayerComponent 
		 * 
		 * @param playerNum 
		 * 
		 * @return 
		 */
		public function PlayerComponent(playerNum : int) {
			this.playerNum = playerNum;
			selectedTower = playerNum;
		}
	}
}
