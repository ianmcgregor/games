package me.ianmcgregor.template.spatials.gfx {
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author ianmcgregor
	 */
	public final class NullGfx extends Sprite {
		/**
		 * NullGfx 
		 */
		public function NullGfx() {
			super();
			
			/**
			 * gfx 
			 */
			var gfx: Quad = new Quad(100, 100);
			gfx.color = 0xFF0000;
			addChild(gfx);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			flatten();
			touchable = false;
		}
	}
}
