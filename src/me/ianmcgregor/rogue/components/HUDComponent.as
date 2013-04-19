package me.ianmcgregor.rogue.components {
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
import me.ianmcgregor.rogue.components.InventoryComponent;
internal class PlayerVO {
	public var health : Number = 0;
	public var score : int;
	public var inventory : InventoryComponent;
	
	public function toString(): String {
		return "HEALTH: " + (health * 100).toFixed(0) + "%  SCORE: " + (score).toString(); 
	}
}
