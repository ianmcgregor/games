package me.ianmcgregor.games.debug {
	/**
	 * @author ianmcgregor
	 */
	public class Logger {
		
		/**
		 * _debug 
		 */
		private static var _debug : DebugDisplay;
		
		/**
		 * log 
		 * 
		 * @param ...args 
		 * 
		 * @return 
		 */
		static public function log(...args : *): void {
			_debug.log(args.join(" "));
		}
		
		/**
		 * clear 
		 * 
		 * @return 
		 */
		static public function clear(): void {
			_debug.clearLog();
		}

		/**
		 * @private
		 */
		internal static function set debug(debug : DebugDisplay) : void {
			_debug = debug;
		}
	}
}
