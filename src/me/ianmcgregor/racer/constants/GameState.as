package me.ianmcgregor.racer.constants {
	/**
	 * @author ianmcgregor
	 */
	public class GameState {
		public static const TITLES : int = 0;
		public static const CREATING_TRACK : int = 10;
		public static const READY : int = 20;
		public static const START_LIGHTS : int = 30;
		public static const DRIVING : int = 40;
		public static const TRACK_COMPLETE : int = 50;
		public static const GAME_OVER : int = 60;
		public static const BUILDING_TRACK : int = 70;
		
		/**
		 * getStateName 
		 * 
		 * @param state 
		 * 
		 * @return 
		 */
		public static function getStateName(state: int): String {
			/**
			 * name 
			 */
			var name: String;
			switch(state){
				case TITLES:
					name = "TITLES";
					break;
				case CREATING_TRACK:
					name = "CREATING_TRACK";
					break;
				case READY:
					name = "READY";
					break;
				case DRIVING:
					name = "DRIVING";
					break;
				case TRACK_COMPLETE:
					name = "TRACK_COMPLETE";
					break;
				case GAME_OVER:
					name = "GAME_OVER";
					break;
				case BUILDING_TRACK:
					name = "BUILDING_TRACK";
					break;
				default:
			}
			return name;
		}
	}
}
