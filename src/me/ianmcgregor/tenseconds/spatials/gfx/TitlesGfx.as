package me.ianmcgregor.tenseconds.spatials.gfx {
	import me.ianmcgregor.games.ui.TextButton;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.tenseconds.constants.KeyConstants;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	/**
	 * @author ianmcgregor
	 */
	public final class TitlesGfx extends Sprite {
		/**
		 * TitlesGfx 
		 */
		private const TITLE_TEXT : String = "TEMPLATE GAME"; 
		private const ONE_PLAYER : String = "ONE PLAYER";
		private const TWO_PLAYER : String = "TWO PLAYER";
		private const INFO_TEXT_1 : String = "WASD + F + G"; 
		private const INFO_TEXT_2 : String = "ARROWS + K + L"; 
		
		/**
		 * TitlesGfx 
		 * 
		 * @param w 
		 * @param h 
		 * 
		 * @return 
		 */
		public function TitlesGfx(w: Number, h: Number) {
			super();
			w, h;
			/**
			 * gfx 
			 */
			var gfx: Quad = new Quad(w, h);
			gfx.color = 0x000000;
			addChild(gfx);
			
			/**
			 * title 
			 */
			var title : TextField;
			addChild(title = new TextField(100, 20, TITLE_TEXT, Constants.FONT, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			title.scaleX = title.scaleY = 8;
			
			title.x = (w - title.width) * 0.5;
			title.y = 80;
			
			/*
			 * button
			 */
			var buttonY : Number = title.y + title.height + 140;
			var buttonScale : int = 5;
			
			var button1 : TextButton;
			addChild(button1 = new TextButton(ONE_PLAYER, buttonScale));
			button1.addEventListener(Event.TRIGGERED, onOnePlayer);
			
			button1.x = w * 0.5 - button1.width - 50;
			button1.y = buttonY;

			var button2 : TextButton;
			addChild(button2 = new TextButton(TWO_PLAYER, buttonScale));
			button2.addEventListener(Event.TRIGGERED, onTwoPlayer);
			
			button2.x = w * 0.5 + 50;
			button2.y = buttonY;
			
			
			/**
			 * info 
			 */
			var info1 : TextField;
			addChild(info1 = new TextField(200, 70, INFO_TEXT_1, Constants.FONT, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			info1.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			info1.scaleX = info1.scaleY = 2;
			
			info1.x = MathUtils.round(button1.x + (button1.width - info1.width) * 0.5);
			info1.y =  MathUtils.round(button1.y + button1.height + 20);
			
			var info2 : TextField;
			addChild(info2 = new TextField(200, 70, INFO_TEXT_2, Constants.FONT, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			info2.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			info2.scaleX = info2.scaleY = 2;
			
			info2.x = MathUtils.round(button2.x + (button2.width - info2.width) * 0.5);
			info2.y = info1.y;
			
//			flatten();
			touchable = true;
		}
		
		private function onOnePlayer(event : Event) : void {
			event;
			clear();
			dispatchEventWith(Event.TRIGGERED, false, KeyConstants.ONE_PLAYER);
		}

		private function onTwoPlayer(event : Event) : void {
			event;
			clear();
			dispatchEventWith(Event.TRIGGERED, false, KeyConstants.TWO_PLAYER);
		}
		
		public function clear(): void {
		}
	}
}
