package me.ianmcgregor.racer.spatials.gfx {
	import starling.display.Button;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.RenderTexture;

	/**
	 * @author ianmcgregor
	 */
	public final class RacerButton extends Button {
		/**
		 * _buttonTexture 
		 */
		private var _buttonTexture : RenderTexture;
		/**
		 * _text 
		 */
		private var _text : TextField;
		/**
		 * RacerButton 
		 * 
		 * @param text 
		 * 
		 * @return 
		 */
		public function RacerButton(text : String) {
			
			_text = new TextField(100, 20, text, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true);
			_text.scaleX = _text.scaleY = 6;
			_buttonTexture = new RenderTexture(_text.width, _text.height, true);
			_buttonTexture.draw(_text);
			super(_buttonTexture);
		}
	}
}
