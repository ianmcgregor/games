package me.ianmcgregor.games.utils.app {
	import flash.system.Capabilities;

	/**
	 * @author ianmcgregor
	 */
	public class Environment {
		/**
		 * device 
		 */
		public static function get device() : String {
			return Capabilities.version.substr(0, 3);
		}

		/**
		 * isAndroid 
		 */
		public static function get isAndroid() : Boolean {
			return device == "AND";
		}

		/**
		 * isIOS 
		 */
		public static function get isIOS() : Boolean {
			return device == "IOS";
		}

		/**
		 * isMobile 
		 */
		public static function get isMobile() : Boolean {
			return isAndroid || isIOS;
		}

		/**
		 * isAir 
		 */
		public static function get isAir() : Boolean {
			return Capabilities.playerType == "Desktop";
		}

		/**
		 * isWindows 
		 */
		public static function get isWindows() : Boolean {
			return device == "WIN";
		}

		/**
		 * isOSX 
		 */
		public static function get isOSX() : Boolean {
			return device == "MAC";
		}
	}
}
