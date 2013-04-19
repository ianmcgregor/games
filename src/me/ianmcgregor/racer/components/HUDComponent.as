package me.ianmcgregor.racer.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDComponent extends Component {
		/**
		 * TODO: add all HUD props
		 */
		
		/**
		 * debug 
		 */
		public var debug : String;
		/**
		 * info 
		 */
		public var info : String;
		/**
		 * trackName 
		 */
		public var trackName : String;
		/**
		 * trackLaps 
		 */
		public var trackLaps : uint;
		
		/**
		 * speed1 
		 */
		public var speed1 : Number;
		/**
		 * lap1 
		 */
		public var lap1 : uint;
		/**
		 * nextLap1 
		 */
		public var nextLap1 : uint;
		/**
		 * winTotal1 
		 */
		public var winTotal1 : uint;
		/**
		 * lives1 
		 */
		public var lives1 : uint;
		/**
		 * type1 
		 */
		public var type1: String;
		/**
		 * lapTime1 
		 */
		public var lapTime1 : Number;
		
		/**
		 * speed2 
		 */
		public var speed2 : Number;
		/**
		 * lap2 
		 */
		public var lap2 : uint;
		/**
		 * nextLap2 
		 */
		public var nextLap2 : uint;
		/**
		 * winTotal2 
		 */
		public var winTotal2 : uint;
		/**
		 * lives2 
		 */
		public var lives2 : uint;
		/**
		 * type2 
		 */
		public var type2: String;
		/**
		 * lapTime2 
		 */
		public var lapTime2 : Number;

		/**
		 * lastWinner 
		 */
		public var lastWinner : uint;
//		public var lightsTimer : uint;
		
		/**
		 * HUDComponent 
		 */
		public function HUDComponent() {
		}

		/**
		 * getSpeed 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function getSpeed(id : uint) : Number {
			return this["speed" + id];
		}

		/**
		 * setSpeed 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setSpeed(id : uint, value: Number) : void {
			this["speed" + id] = value;
		}

		/**
		 * getLap 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function getLap(id : uint) : uint {
			return this["lap" + id];
		}

		/**
		 * setLap 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setLap(id : uint, value: uint) : void {
			this["lap" + id] = value;
		}

		/**
		 * setNextLap 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setNextLap(id : uint, value: uint) : void {
			this["nextLap" + id] = value;
		}

		/**
		 * getWinTotal 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function getWinTotal(id : uint) : uint {
			return this["winTotal" + id];
		}

		/**
		 * setWinTotal 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setWinTotal(id : uint, value: uint) : void {
			this["winTotal" + id] = value;
		}

		/**
		 * getLives 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function getLives(id : uint) : uint {
			return this["lives" + id];
		}

		/**
		 * setLives 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setLives(id : uint, value: uint) : void {
			this["lives" + id] = value;
		}
		
		/**
		 * getType 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function getType(id : uint) : String {
			return this["type" + id];
		}

		/**
		 * setType 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setType(id : uint, value: String) : void {
			this["type" + id] = value;
		}
		
		/**
		 * getLapTime 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function getLapTime(id : uint) : Number {
			return this["lapTime" + id];
		}

		/**
		 * setLapTime 
		 * 
		 * @param id 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setLapTime(id : uint, value: Number) : void {
			this["lapTime" + id] = value;
		}
	}
}
