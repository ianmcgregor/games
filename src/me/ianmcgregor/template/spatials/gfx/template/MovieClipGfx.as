package me.ianmcgregor.template.spatials.gfx.template {
	import starling.display.MovieClip;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public class MovieClipGfx extends MovieClip {
		public function MovieClipGfx(textures : Vector.<Texture>, fps : Number = 12) {
			if(!textures) {
				textures = new <Texture>[Texture.fromColor(100, 100, 0xFF00FF00)];
			}
			super(textures, fps);
		}
	}
}
