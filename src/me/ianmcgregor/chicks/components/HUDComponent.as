package me.ianmcgregor.chicks.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDComponent extends Component {
		/**
		 * player
		 */
		public var player : Vector.<PlayerVO>;
		/**
		 * HUDComponent 
		 */
		public function HUDComponent() {
			player = new Vector.<PlayerVO>(3, true);
			player[1] = new PlayerVO();
			player[2] = new PlayerVO();
		}
	}
}
internal class PlayerVO {
	public var health : Number = 0;
	public var score : int;
	
	public function toString(): String {
		return "HEALTH: " + (health * 100).toFixed(0) + "%  SCORE: " + (score).toString(); 
	}
}
