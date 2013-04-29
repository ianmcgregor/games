package me.ianmcgregor.chicks.spatials.gfx {
	import me.ianmcgregor.chicks.constants.KeyConstants;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

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
		public function TitlesGfx(texture: Texture) {
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
				dispatchEventWith(Event.TRIGGERED, false, KeyConstants.ONE_PLAYER);
			}
		}
	}
}
