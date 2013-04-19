package me.ianmcgregor.nanotech.spatials.gfx {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public final class EnemyGfx extends Sprite {
		/**
		 * EnemyGfx 
		 */
		public function EnemyGfx(texture: Texture) {
			super();
			
			/**
			 * gfx 
			 */
			var gfx: Image = new Image(texture);
			addChild(gfx);
			pivotX = width * 0.5;
			pivotY = height * 0.5;
		}
	}
}
