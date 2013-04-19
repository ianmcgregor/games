package me.ianmcgregor.racer.spatials.gfx {
	import starling.text.BitmapFont;
	import starling.text.TextField;

	/**
	 * @author ianmcgregor
	 */
	public class RacerText extends TextField {

		/**
		 * RacerText 
		 * 
		 * @param text 
		 * 
		 * @return 
		 */
		public function RacerText(text : String) {
			super(100, 20, text, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true);
			
			scaleX = scaleY = 3;
			touchable = false;
		}
	}
}
