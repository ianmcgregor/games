package me.ianmcgregor.games.debug {

	/**
	 * @author ian
	 */
	public final class LogDisplay extends AbstractDebugPanel {
		private const TITLE : String = 'LOG:';
		private const MAX_HEIGHT : Number = 60;
		/**
		 * LogDisplay 
		 */
		public function LogDisplay() {
			super(TITLE, false);
		}
		
		/**
		 * appendText 
		 * 
		 * @param value 
		 * 
		 * @return 
		 */
		override public function appendText( value: String ) : void {
			var prevText : String = _textField.text;
			if(backgroundHeight > MAX_HEIGHT) {
				prevText = prevText.substr(prevText.indexOf('\n') + 2);
				prevText = TITLE + prevText.substr(prevText.indexOf('\n'));
			}
			if(prevText != "") prevText = prevText + "\n";
			text = prevText + value;
		}
	}
}
