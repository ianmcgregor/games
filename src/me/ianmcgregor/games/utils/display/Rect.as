package me.ianmcgregor.games.utils.display {
	import me.ianmcgregor.games.utils.collections.ObjectPool;
	import me.ianmcgregor.games.utils.math.MathUtils;

	import flash.geom.Rectangle;

	/**
	 * @author ianmcgregor
	 */
	public final class Rect extends Rectangle {
		public function Rect(x : Number = 0, y : Number = 0, width : Number = 0, height : Number = 0) {
			super(x, y, width, height);
		}
		
		public static function get(x : Number = 0, y : Number = 0, width : Number = 0, height : Number = 0) : Rect {
			var r: Rect = ObjectPool.get(Rect);
			r.x = x;
			r.y = y;
			r.width = width;
			r.height = height;
			return r;
		}
		
		public function dispose(): void {
			ObjectPool.dispose(this);
		}
		
		public function getIntersectionArea(b: Rectangle): Number {
			var x11 : Number = this.left;
            var y11 : Number = this.top;
            var x12 : Number = this.left + this.width;
            var y12 : Number = this.top + this.height;
            var x21 : Number = b.left;
            var y21 : Number = b.top;
            var x22 : Number = b.left + b.width;
            var y22 : Number = b.top + b.height;
			var overlapX: Number = MathUtils.max(0, MathUtils.min(x12,x22) - MathUtils.max(x11,x21));
           	var overlapY: Number = MathUtils.max(0, MathUtils.min(y12,y22) - MathUtils.max(y11,y21));
			return overlapX * overlapY;
		}
		
		public function getIntersectionPercent(b: Rectangle): Number {
			return getIntersectionArea(b) / ( width * height );
		}
	}
}
