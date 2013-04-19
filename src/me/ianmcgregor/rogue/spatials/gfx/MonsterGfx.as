package me.ianmcgregor.rogue.spatials.gfx {
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author ianmcgregor
	 */
	public final class MonsterGfx extends Sprite {
		/**
		 * MonsterGfx 
		 */
		public function MonsterGfx() {
			super();
			
			/**
			 * gfx 
			 */
			var gfx: Quad = new Quad(10, 10);
			gfx.color = 0xFF00FF;
			addChild(gfx);
			
//			pivotX = width * 0.5;
//			pivotY = height * 0.5;
			
			flatten();
			touchable = false;
		}
	}
}
