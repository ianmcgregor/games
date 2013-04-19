package me.ianmcgregor.games.utils.app {
	import flash.events.IEventDispatcher;
	import flash.utils.getDefinitionByName;
	/**
	 * @author ianmcgregor
	 */
	public final class AirApp {
		// system idle mode (flash.desktop.SystemIdleMode)
		public static const NORMAL : String = "normal";
		public static const KEEP_AWAKE : String = "keepAwake";
		
		/**
		 * _app 
		 */
		private static var _app : IEventDispatcher;
		
		/**
		 * app 
		 */
		public static function get app(): IEventDispatcher {
			if(!_app){
				try{
					var c: Object = getDefinitionByName("flash.desktop.NativeApplication");
					if( c ) {
						_app = c["nativeApplication"];
					}
				}catch(error:Error){
					_app = null;						
				}
			}
			return _app;
		}
		
		/**
		 * addEventListener 
		 * 
		 * @param type 
		 * @param listener 
		 * 
		 * @return 
		 */
		public static function addEventListener(type : String, listener : Function) : void {
			if (app) app.addEventListener(type, listener, false, 0, true);
		}

		/**
		 * removeEventListener 
		 * 
		 * @param type 
		 * @param listener 
		 * 
		 * @return 
		 */
		public static function removeEventListener(type : String, listener : Function) : void {
			if(app) app.removeEventListener(type, listener, false);
		}

		/**
		 * keepAwake 
		 * 
		 * @param b 
		 * 
		 * @return 
		 */
		public static function keepAwake(b : Boolean) : void {
			if(app) app["systemIdleMode"] = ( b ? KEEP_AWAKE : NORMAL );
		}
		
		/**
		 * exit 
		 * 
		 * @return 
		 */
		public static function exit() : void {
			if(app) app["exit"]();
		}
	}
}
