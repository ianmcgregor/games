package me.ianmcgregor.template.spatials.gfx {
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDGfx extends Sprite {
		/**
		 * _text 
		 */
		private var _text : String;
		/**
		 * _textField 
		 */
		private var _textField : TextField;
		/**
		 * HUDGfx 
		 */
		public function HUDGfx(w : Number, h : Number) {
			super();
			
			w, h;
			
			/**
			 * gfx 
			 */
			 
			
			addChild(_textField = new TextField(600, 40, "HUD", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			_textField.scaleX = _textField.scaleY = 2;
			
			_textField.x = (w - _textField.width) * 0.5;
//			text.y = (h - text.height) * 0.5;
			_textField.y = 10;
			 
			flatten();
			touchable = false;
		}

		/**
		 * @private
		 */
		public function set text(newText : String) : void {
			if(newText == _text) return;
			_text = newText;
			unflatten();
			_textField.text = _text;
			flatten();
		}
	}
}
