package me.ianmcgregor.games.debug {
	import starling.core.Starling;

	import flash.system.Capabilities;
	import flash.ui.Multitouch;

	/**
	 * @author ian
	 */
	public final class DeviceInfoDisplay extends AbstractDebugPanel {
		// show information about device
		/**
		 * DeviceInfoDisplay 
		 */
		public function DeviceInfoDisplay() {
			/**
			 * text 
			 */
			var text: String = '';
			text += 'MAX TOUCH POINTS: ' + (Multitouch.maxTouchPoints) + '\n';
			text += 'CONTENT SCALE FACTOR: ' + (Starling.current.contentScaleFactor) + '\n';
			text += 'PLAYER TYPE: ' + (Capabilities.playerType) + '\n';
			text += 'OS: ' + (Capabilities.os) + '\n';
			text += 'VERSION: ' + (Capabilities.version) + '\n';
			
			super(text);
		}
	}
}
