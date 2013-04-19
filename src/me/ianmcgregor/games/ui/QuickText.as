package me.ianmcgregor.games.ui {
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	/**
	 * @author McFamily
	 */
	public class QuickText extends Sprite {
		/**
		 * _background 
		 */
		private var _background : Quad;
		/**
		 * _textField 
		 */
		private var _textField : TextField;
		/**
		 * QuickText 
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
		public function QuickText(width: int, height: int, text: String = "", scale: Number = 1, bgColor: uint = 0x000000, textColor: uint = 0xFFFFFF) {
			super();
			
			addChild( _background = new Quad(width, height, bgColor) );
			addChild( _textField = new TextField(width, height, text, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, textColor, true) );
//			_textField.hAlign = HAlign.LEFT;
			blendMode = BlendMode.AUTO;
			scaleX = scaleY = scale;
			touchable = false;
		}
		
		/**
		 * @private
		 */
		public function set text(value : String): void {
			_textField.text = value;
		}

		/**
		 * textField 
		 */
		public function get textField() : TextField {
			return _textField;
		}
	}
}
