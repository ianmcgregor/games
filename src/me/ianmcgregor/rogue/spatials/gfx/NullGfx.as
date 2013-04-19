package me.ianmcgregor.rogue.spatials.gfx {
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author ianmcgregor
	 */
	public final class NullGfx extends Sprite {
		/**
		 * NullGfx 
		 */
		public function NullGfx(texture: Texture = null) {
			super();
			
			/**
			 * gfx 
			 */
			if(texture) {
				addChild(new Image(texture));
			} else {
				var gfx: Quad = new Quad(100, 100);
				gfx.color = 0xFF0000;
				addChild(gfx);
			}
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			flatten();
			touchable = false;
		}
	}
}
