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
	public final class GameOverGfx extends Sprite {
		/**
		 * GameOverGfx 
		 */
		private const TITLE_TEXT : String = "GAME OVER"; 
		private const PLAY_AGAIN : String = "PLAY AGAIN";
		
		/**
		 * GameOverGfx 
		 * 
		 * @param w 
		 * @param h 
		 * 
		 * @return 
		 */
		public function GameOverGfx(w : Number, h : Number) {
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
			addChild(title = new TextField(100, 40, TITLE_TEXT, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			title.scaleX = title.scaleY = 8;
			
			title.x = (w - title.width) * 0.5;
			title.y = 80;
			
			/**
			 * button
			 */
			var buttonY : Number = title.y + title.height + 80;
			var buttonScale : int = 5;
			
			var button : TextButton;
			addChild(button = new TextButton(PLAY_AGAIN, buttonScale));
			button.addEventListener(Event.TRIGGERED, onPlayAgain);
			
			button.x = (w - button.width) * 0.5;
			button.y = buttonY;
			
			//flatten();
			touchable = true;
		}

		private function onPlayAgain(event : Event) : void {
			event;
			dispatchEventWith(Event.TRIGGERED, false, KeyConstants.PLAY_AGAIN);
		}
	}
}
