package me.ianmcgregor.tenseconds.spatials.gfx {
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerGfx extends Sprite {
		/**
		 * PlayerGfx 
		 */
		public function PlayerGfx(playerNum: int, texture: Texture = null) {
			super();
			
			/**
			 * gfx 
			 */
			if(texture) {
				addChild(new Image(texture));
			} else {
				var gfx: Quad = new Quad(64, 10);
				gfx.color = playerNum == 1 ? 0xFF0000 : 0x00FF00;
				addChild(gfx);
			}
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			flatten();
			touchable = false;
		}
	}
}
