package me.ianmcgregor.nanotech.spatials.gfx {
	import me.ianmcgregor.games.ui.TextButton;
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	import flash.ui.Keyboard;

	/**
	 * @author ianmcgregor
	 */
	public final class TitlesGfx extends Sprite {
		/**
		 * TitlesGfx 
		 */
		private const TITLE_TEXT : String = "NANOTECH DEFENDERS"; 
		private const ONE_PLAYER : String = "ONE PLAYER";
		private const TWO_PLAYER : String = "TWO PLAYER";
		private const INFO_TEXT_1 : String = "PLAYER ONE:\nTHRUST: W\nROTATE: A/D\nSHOOT: SPACE"; 
		private const INFO_TEXT_2 : String = "PLAYER TWO:\nTHRUST: UP\nROTATE: LEFT/RIGHT\nSHOOT: ALT or CTRL"; 
		private var good : ParticleGfx;
		private var bad : ParticleGfx;
		
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
//			var gfx: Quad = new Quad(w, h);
//			gfx.color = 0xFF00FF;
//			addChild(gfx);
			
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
			
			var defend : TextField;
			addChild(defend = new TextField(120, 20, "DEFEND THESE GUYS", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			defend.scaleX = defend.scaleY = 2;
			
			addChild(good = new ParticleGfx(ParticleAssets.PARTICLE_PEX2, ParticleAssets.PARTICLE_TEX2));

			var against : TextField;
			addChild(against = new TextField(120, 20, "AGAINST THESE GUYS", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true));
			against.scaleX = against.scaleY = 2;
			
			addChild(bad = new ParticleGfx(ParticleAssets.ENEMY_PEX, ParticleAssets.ENEMY_TEX));
			
			defend.x = 220;
			good.x = defend.x + defend.width + 20;
			against.x = good.x + good.width + 30;
			bad.x = against.x + against.width + 20;
			defend.y = against.y = title.y + title.height + 60;
			good.y = bad.y = defend.y + 20;
			
//			flatten();
			touchable = true;
		}
		
		private function onOnePlayer(event : Event) : void {
			event;
			clear();
			dispatchEventWith(Event.TRIGGERED, false, Keyboard.NUMBER_1);
		}

		private function onTwoPlayer(event : Event) : void {
			event;
			clear();
			dispatchEventWith(Event.TRIGGERED, false, Keyboard.NUMBER_2);
		}
		
		public function clear(): void {
			good.stop();
			bad.stop();
		}
	}
}
