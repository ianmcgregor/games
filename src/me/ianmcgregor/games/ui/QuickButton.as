package me.ianmcgregor.games.ui {
	import starling.display.Button;
	import starling.textures.RenderTexture;

	/**
	 * @author McFamily
	 */
	public class QuickButton extends Button {
		/**
		 * _buttonTexture 
		 */
		private var _buttonTexture : RenderTexture;
		/**
		 * _text 
		 */
		private var _text : QuickText;
		/**
		 * QuickButton 
		 * 
		 * @param width 
		 * @param height 
		 * @param text 
		 * @param scale 
		 * @param bgColor 
		 * @param textColor 
		 * 
		 * @return 
		 */
		public function QuickButton(width: Number, height: Number, text : String = "", scale: Number = 1, bgColor: uint = 0xFF0000, textColor: uint = 0xFFFFFF) {
			_buttonTexture = new RenderTexture(width, height, true, scale);
			_text = new QuickText(width / scale, height / scale, text, scale, bgColor, textColor);
			_buttonTexture.draw(_text);
			super(_buttonTexture);
		}

		/**
		 * @private
		 */
		override public function set text(value : String) : void {
			_text.text = value;
			_buttonTexture.draw(_text);
		}
	}
}
