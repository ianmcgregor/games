package me.ianmcgregor.games.debug {
	import starling.core.Starling;

	/**
	 * @author ian
	 */
	public final class DriverInfoDisplay extends AbstractDebugPanel {
		// show information about rendering method (hardware/software)
		/**
		 * DriverInfoDisplay 
		 */
		public function DriverInfoDisplay() {
			/**
			 * driverInfo 
			 */
			var driverInfo : String = Starling.context.driverInfo;

			super(driverInfo.toUpperCase());
		}
	}
}
