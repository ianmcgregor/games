package me.ianmcgregor.template.spatials.gfx {
	import me.ianmcgregor.games.ui.TextButton;
	import me.ianmcgregor.template.constants.KeyConstants;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;

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
		private const INFO_TEXT_1 : String = "PLAYER ONE:\nCONTROLS"; 
		private const INFO_TEXT_2 : String = "PLAYER TWO:\nCONTROLS"; 
		
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
			addChild(title = new TextField(100, 20, TITLE_TEXT, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			title.scaleX = title.scaleY = 8;
			
			title.x = (w - title.width) * 0.5;
			title.y = 80;
			
			/*
			 * button
			 */
			var buttonY : Number = title.y + title.height + 140;
			var buttonScale : int = 5;
			
			var button : TextButton;
			addChild(button = new TextButton(ONE_PLAYER, buttonScale));
			button.addEventListener(Event.TRIGGERED, onOnePlayer);
			
			button.x = w * 0.5 - button.width - 10;
			button.y = buttonY;

			addChild(button = new TextButton(TWO_PLAYER, buttonScale));
			button.addEventListener(Event.TRIGGERED, onTwoPlayer);
			
			button.x = w * 0.5 + 10;
			button.y = buttonY;
			
			
			/**
			 * info 
			 */
			var info1 : TextField;
			addChild(info1 = new TextField(200, 70, INFO_TEXT_1, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			info1.scaleX = info1.scaleY = 2;
			
			info1.x = w * 0.5 - info1.width - 60;
			info1.y = button.y + button.height + 20;
			
			var info2 : TextField;
			addChild(info2 = new TextField(200, 70, INFO_TEXT_2, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			info2.scaleX = info2.scaleY = 2;
			
			info2.x = w * 0.5 + 60;
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
