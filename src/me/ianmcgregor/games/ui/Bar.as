package me.ianmcgregor.games.ui {
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author ianmcgregor
	 */
	public class Bar extends Sprite {
		private var _back : Quad;
		private var _front : Quad;
		public function Bar(width: Number = 60, height: Number = 12, colorBack: uint = 0x000000, colorFront: uint = 0xFF2222) {
			super();
			
			addChild(_back = new Quad(width, height));
			_back.color = colorBack;
			
			addChild(_front = new Quad(width - 2, height - 2));
			_front.color = colorFront;
			_front.x = _front.y = 1;
		}
		
		public function setPercent(percent: Number): void {
			if(percent > 1) percent = 1;
			if(percent < 0) percent = 0;
			_front.scaleX = percent;
		}
	}
}
