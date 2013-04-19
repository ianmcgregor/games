package me.ianmcgregor.racer.spatials.gfx {
	import me.ianmcgregor.racer.assets.Assets;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public final class StartLightsGfx extends Sprite {
		/**
		 * _animation 
		 */
		private var _animation: MovieClip;
		/**
		 * StartLightsGfx 
		 */
		public function StartLightsGfx() {
			super();
			
			addChild(_animation = new MovieClip( getTextures(Assets.LIGHTS_OFF, Assets.LIGHTS_RED, Assets.LIGHTS_AMBER, Assets.LIGHTS_GREEN), 1.5 ));
			_animation.stop();
		}
		
		/**
		 * getTextures 
		 * 
		 * @param ...imageClasses 
		 * 
		 * @return 
		 */
		private function getTextures(...imageClasses:*) : Vector.<Texture> {
			/**
			 * textures 
			 */
			var textures: Vector.<Texture> = new Vector.<Texture>();
			/**
			 * ImageClass 
			 */
			for each (var ImageClass : Class in imageClasses) {
				textures[textures.length] = Texture.fromBitmap(new ImageClass());
			}
			return textures;
		}
		
		/**
		 * go 
		 * 
		 * @return 
		 */
		public function go(): void {
			Starling.current.juggler.add(_animation);
			_animation.addEventListener(Event.COMPLETE, onComplete);
			_animation.stop();
			_animation.play();
		}
		
		/**
		 * onComplete 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onComplete(event: Event) : void {
			event;
			_animation.stop();
			Starling.current.juggler.remove(_animation);
			_animation.removeEventListener(Event.COMPLETE, onComplete);
			dispatchEventWith(Event.COMPLETE);
		}
	}
}
