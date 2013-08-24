package me.ianmcgregor.games.ui {
	import starling.text.TextFieldAutoSize;
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
		public function TextButton(text : String = "", scale : Number = 1, color : uint = 0xFFFF00, font: String = null, autoSize: String = TextFieldAutoSize.BOTH_DIRECTIONS) {
			if(!font) font = BitmapFont.MINI;
			_text = new TextField(400, 50, text, font, BitmapFont.NATIVE_SIZE, color, true);
			_text.autoSize = autoSize;
			_text.batchable = text.length < 16;
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
