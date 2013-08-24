package me.ianmcgregor.template.spatials.gfx.template {
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public final class ImageGfx extends Image {
		/**
		 * TextureGfx 
		 */
		public function ImageGfx(texture: Texture = null) {
			if(!texture) {
				texture = Texture.fromColor(64, 64, 0xFFFF0000);
			}
			super(texture);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			touchable = false;
		}
	}
}
