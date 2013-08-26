package me.ianmcgregor.tenseconds.spatials.gfx {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.tenseconds.constants.KeyConstants;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author ianmcgregor
	 */
	public final class TitlesGfx extends Sprite {
		/**
		 * TitlesGfx 
		 * 
		 * @param w 
		 * @param h 
		 * 
		 * @return 
		 */
		public function TitlesGfx(g: GameContainer) {
			super();
			
			/**
			 * title 
			 */
			var title : Image;
			addChild(title = new Image(g.assets.getTexture('title')));
			
			title.x = int( (g.getWidth() - title.width) * 0.5 );
			title.y = 62;
			
			/*
			 * button
			 */
			var buttonY : Number = 364;
			
			var button1 : Button;
			addChild(button1 = new Button(g.assets.getTexture('oneplayer')));
			button1.addEventListener(Event.TRIGGERED, onOnePlayer);
			
			button1.x = title.x;
			button1.y = buttonY;

			var button2 : Button;
			addChild(button2 = new Button(g.assets.getTexture('twoplayer')));
			button2.addEventListener(Event.TRIGGERED, onTwoPlayer);
			
			button2.x =  title.x + title.width - button2.width;
			button2.y = buttonY;
			
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
