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
	public final class GameOverGfx extends Sprite {
		/**
		 * GameOverGfx 
		 * 
		 * @param g
		 * 
		 * @return 
		 */
		public function GameOverGfx(g: GameContainer, win: Boolean) {
			super();
			
			/**
			 * title 
			 */
			var title : Image;
			var tex: String = 'gameover'; 
			if(win) tex = 'youwon';
			addChild(title = new Image(g.assets.getTexture(tex)));
			
			title.x = int( (g.getWidth() - title.width) * 0.5 );
			title.y = 52;
			
			/*
			 * button
			 */
			
			var button : Button;
			addChild(button = new Button(g.assets.getTexture('playagain')));
			button.addEventListener(Event.TRIGGERED, onPlayAgain);
			
			button.x = int( (g.getWidth() - button.width) * 0.5 );
			button.y = 546;

//			flatten();
			touchable = true;
		}

		private function onPlayAgain(event : Event) : void {
			event;
			dispatchEventWith(Event.TRIGGERED, false, KeyConstants.PLAY_AGAIN);
		}
	}
}
