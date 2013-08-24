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
	public final class TitlesGfx extends Sprite {
		/**
		 * TitlesGfx 
		 */
		private const ONE_PLAYER : String = "ONE PLAYER";
		private const TWO_PLAYER : String = "TWO PLAYER";
		private const INFO_TEXT_1 : String = "PLAYER ONE:\nWASD + F + G"; 
		private const INFO_TEXT_2 : String = "PLAYER TWO:\nARROWS + K + L"; 
		
		/**
		 * TitlesGfx 
		 * 
		 * @param w 
		 * @param h 
		 * 
		 * @return 
		 */
		public function TitlesGfx(w : Number, h : Number, atlas : TextureAtlas) {
			super();
			w, h;
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
			addChild(title = new TextField(600, 100, Constants.TITLE_TEXT, Constants.FIGHT_FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF));
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
			addChild(button1 = new TextButton(ONE_PLAYER, buttonScale, 0xFFFFFF, Constants.FIGHT_FONT));
			button1.addEventListener(Event.TRIGGERED, onOnePlayer);
			
			button1.x = w * 0.5 - button1.width - 50;
			button1.y = buttonY;

			var button2 : TextButton;
			addChild(button2 = new TextButton(TWO_PLAYER, buttonScale, 0xFFFFFF, Constants.FIGHT_FONT));
			button2.addEventListener(Event.TRIGGERED, onTwoPlayer);
			
			button2.x = w * 0.5 + 50;
			button2.y = buttonY;
			
			/**
			 * info 
			 */
			var info1 : TextField;
			addChild(info1 = new TextField(200, 70, INFO_TEXT_1, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
//			info1.scaleX = info1.scaleY = 2;
			
			info1.x = button1.x + (button1.width - info1.width) * 0.5;
			info1.y = button1.y + button1.height - 25;
			
			var info2 : TextField;
			addChild(info2 = new TextField(200, 70, INFO_TEXT_2, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
//			info2.scaleX = info2.scaleY = 2;
			
			info2.x = button2.x + (button2.width - info2.width) * 0.5;
			info2.y = info1.y;
			
			/**
			 * characters
			 */
			
			var character1: SelectCharacter;
			addChild(character1 = new SelectCharacter(atlas, 1));
			character1.x = info1.x + (info1.width - character1.width) * 0.5;
			character1.y = title.y + title.height + 172;
			
			var character2: SelectCharacter;
			addChild(character2 = new SelectCharacter(atlas, 2));
			character2.x = info2.x + (info2.width - character2.width) * 0.5;
			character2.y = character1.y;
			
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
