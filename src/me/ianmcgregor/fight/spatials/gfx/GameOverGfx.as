package me.ianmcgregor.fight.spatials.gfx {
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.KeyConstants;
	import me.ianmcgregor.games.ui.TextButton;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	/**
	 * @author ianmcgregor
	 */
	public final class GameOverGfx extends Sprite {
		/**
		 * GameOverGfx 
		 */
		private const GAME_OVER : String = "GAME OVER";
		private const PLAY_AGAIN : String = "PLAY AGAIN";
		
		/**
		 * GameOverGfx 
		 * 
		 * @param w 
		 * @param h 
		 * 
		 * @return 
		 */
		public function GameOverGfx(w : Number, h : Number, atlas : TextureAtlas) {
			super();
			w, h, atlas;
			/**
			 * gfx 
			 */
//			var gfx: Quad = new Quad(w, h);
//			gfx.color = 0x000000;
//			addChild(gfx);
			
			/**
			 * title 
			 */
			var title : TextField;
			addChild(title = new TextField(600, 100, GAME_OVER, Constants.FIGHT_FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF));
//			addChild(title = new TextField(400, 100, TITLE_TEXT, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF));
			title.scaleX = title.scaleY = 2;
			
			
			title.x = (w - title.width) * 0.5;
			title.y = 50;

			/*
			 * button
			 */
			var buttonY : Number = title.y + title.height + 300;
			var buttonScale : int = 1;
			
			var button1 : TextButton;
			addChild(button1 = new TextButton(PLAY_AGAIN, buttonScale, 0xFFFFFF, Constants.FIGHT_FONT));
			button1.addEventListener(Event.TRIGGERED, onOnePlayer);
			
			button1.x = (w - button1.width) * 0.5;
			button1.y = buttonY;

//			flatten();
			touchable = true;
		}
		
		private function onOnePlayer(event : Event) : void {
			event;
			clear();
			dispatchEventWith(Event.TRIGGERED, false, KeyConstants.PLAY_AGAIN);
		}

		public function clear(): void {
		}
	}
}
