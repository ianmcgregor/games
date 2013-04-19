package me.ianmcgregor.rogue.spatials.gfx {
	import flash.geom.Rectangle;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	/**
	 * @author ianmcgregor
	 */
	public final class MessageGfx extends Sprite {
		/**
		 * MessageGfx 
		 */
		public function MessageGfx(text : String = "") {
			super();
			/**
			 * text 
			 */
			var _text : TextField;
			addChild(_text = new TextField(100, 10, text, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, false));
			var bounds : Rectangle = _text.textBounds;
//			_text.scaleX = _text.scaleY = 8;
//			_text.x = (bg.width - _text.width) * 0.5;
//			_text.y = (bg.height - _text.height) * 0.5;
			
			/**
			 * bg 
			 */

			var bg : Quad = new Quad(bounds.width + 4, bounds.height + 4);
			bg.color = 0x000000;
			addChildAt(bg,0);
			bg.x = bounds.x - 2;
			bg.y = bounds.y - 2;
			
//			pivotX = width * 0.5;
//			pivotY = height * 0.5;
			
			flatten();
			touchable = false;
		}
	}
}
