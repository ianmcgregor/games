package me.ianmcgregor.games.debug {
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author ian
	 */
	public class AbstractDebugPanel extends Sprite {
		private const WIDTH : int = 160;
		/**
		 * _background 
		 */
		protected var _background : Quad;
		/**
		 * _textField 
		 */
		protected var _textField : TextField;
		/**
		 * _flattened 
		 */
		protected var _flattened : Boolean;

		/**
		 * AbstractDebugPanel 
		 * 
		 * @param text 
		 * @param flattened 
		 * 
		 * @return 
		 */
		public function AbstractDebugPanel( text : String = null, flattened : Boolean = true ) {
			_flattened = flattened;
			_textField = new TextField(WIDTH, 100, String(text || ""), BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xffffff);
			_background = new Quad(backgroundWidth, backgroundHeight, 0x0);
			_textField.x = 4;
			_textField.y = 1;
			_textField.hAlign = HAlign.LEFT;
			_textField.vAlign = VAlign.TOP;

			addChild(_background);
			addChild(_textField);

			blendMode = BlendMode.NONE;
			touchable = false;
			
			scaleX = scaleY = Starling.current.contentScaleFactor;

			if(_flattened) flatten();
		}
		
		/**
		 * @private
		 */
		public function set text(value: String): void {
			if(_flattened) unflatten();
			_textField.text = value;
			
			/**
			 * changed 
			 */
			var changed : Boolean = backgroundHeight != _background.height || backgroundWidth != _background.width;
			_background.width = backgroundWidth;
			_background.height = backgroundHeight;
			
			if(_flattened) flatten();
			
			if(changed) dispatchEventWith(Event.RESIZE);
		}

		/**
		 * appendText 
		 * 
		 * @param value 
		 * 
		 * @return 
		 */
		public function appendText( value: String ) : void {
			text = _textField.text + '\n' + value;
		}
		
		/**
		 * width 
		 */
		override public function get width() : Number {
			return _background.width * scaleX;
		}
		
		/**
		 * height 
		 */
		override public function get height() : Number {
			return _background.height * scaleY;
		}
		
		/**
		 * backgroundWidth 
		 */
		protected function get backgroundWidth(): Number {
			/**
			 * w 
			 */
			var w : uint = uint(_textField.textBounds.width);
			return Math.max(w + 6, WIDTH);
		}
		
		/**
		 * backgroundHeight 
		 */
		protected function get backgroundHeight(): Number {
			/**
			 * h 
			 */
			var h : uint = uint(_textField.textBounds.height);
			return h + 5;
		}
	}
}
