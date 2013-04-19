package me.ianmcgregor.nanotech.components {
	import me.ianmcgregor.nanotech.constants.Constants;

	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDComponent extends Component {
		public var player : Vector.<PlayerVO>;
		public var friendsHealth : Number = 0;
		/**
		 * HUDComponent 
		 */
		public function HUDComponent() {
			player = new Vector.<PlayerVO>(3, true);
			player[1] = new PlayerVO();
			player[2] = new PlayerVO();
		}
		
		public function getFriendHealthPercent(): Number {
			return friendsHealth / Constants.TOTAL_FRIENDS;
		}
	}
}
internal class PlayerVO {
	public var health : Number = 0;
	public var score : int;
	
	public function toString(): String {
//		return "HEALTH: " + (health * 100).toFixed(0) + "%  SCORE: " + (score).toString(); 
		return "KILLS: " + (score).toString(); 
	}
}
