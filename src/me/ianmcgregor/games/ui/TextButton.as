package me.ianmcgregor.games.ui {
	import starling.display.Button;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.RenderTexture;

	/**
	 * @author McFamily
	 */
	public class TextButton extends Button {
		/**
		 * _buttonTexture 
		 */
		private var _buttonTexture : RenderTexture;
		/**
		 * _text 
		 */
		private var _text : TextField;
		/**
		 * TextButton 
		 * 
		 * @param text 
		 * @param scale 
		 * @param color 
		 * 
		 * @return 
		 */
		public function TextButton(text : String = "", scale : Number = 1, color : uint = 0xFFFF00) {
			_text = new TextField(100, 20, text, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, color, true);
			_text.scaleX = _text.scaleY = scale;
			_buttonTexture = new RenderTexture(_text.width, _text.height, true);
			_buttonTexture.draw(_text);
			super(_buttonTexture);
			scaleWhenDown = 1;
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
