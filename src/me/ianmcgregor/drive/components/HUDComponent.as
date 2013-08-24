package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDComponent extends Component {
		/**
		 * player
		 */
		public var player : Vector.<PlayerVO>;
		public var badGuy : Vector.<BadyGuyVO>;
		/**
		 * HUDComponent 
		 */
		public function HUDComponent() {
			player = new Vector.<PlayerVO>(3, true);
			player[1] = new PlayerVO();
			player[2] = new PlayerVO();
			
			badGuy = new Vector.<BadyGuyVO>(3, true);
			badGuy[1] = new BadyGuyVO();
			badGuy[2] = new BadyGuyVO();
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
internal class BadyGuyVO {
	public var active : Boolean;
	public var health : Number = 0;
	public var score : int;
	public var name : String = "BAD GUY";
	
	public function toString(): String {
		return "HEALTH: " + (health * 100).toFixed(0) + "%  SCORE: " + (score).toString(); 
	}
}