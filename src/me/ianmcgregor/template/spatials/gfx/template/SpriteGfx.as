package me.ianmcgregor.template.spatials.gfx.template {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public final class SpriteGfx extends Sprite {
		private var _img : Image;
		/**
		 * SpriteGfx 
		 */
		public function SpriteGfx(texture : Texture = null) {
			if(!texture) {
				texture = Texture.fromColor(64, 64, 0xFFFF0000);
			}
			addChild(_img = new Image(texture));
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			touchable = false;
		}
	}
}
