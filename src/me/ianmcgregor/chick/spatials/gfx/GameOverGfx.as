package me.ianmcgregor.chick.spatials.gfx {
	import me.ianmcgregor.chick.constants.KeyConstants;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public final class GameOverGfx extends Sprite {
		
		/**
		 * GameOverGfx 
		 * 
		 * @param w 
		 * @param h 
		 * 
		 * @return 
		 */
		public function GameOverGfx(texture: Texture) {
			super();
			var gfx: Image = new Image(texture);
			addChild(gfx);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			flatten();
			touchable = true;
		}

		private function onTouch(event : TouchEvent) : void {
			if (event.getTouch(this) && event.getTouch(this).phase == TouchPhase.BEGAN){
				removeEventListener(TouchEvent.TOUCH, onTouch);
				dispatchEventWith(Event.TRIGGERED, false, KeyConstants.PLAY_AGAIN);
			}
		}
	}
}
