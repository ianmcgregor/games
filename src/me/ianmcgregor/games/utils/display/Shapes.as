package me.ianmcgregor.games.utils.display {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.BitmapData;

	/**
	 * @author ianmcgregor
	 */
	public class Shapes {
		private static const _shape : Shape = new Shape();

		/**
		 * circle 
		 * 
		 * @param radius 
		 * @param color 
		 * 
		 * @return 
		 */
		static public function circle(radius : Number, color : uint = 0x000000) : BitmapData {
			/**
			 * g 
			 */
			var g : Graphics = _shape.graphics;
			g.clear();
			g.beginFill(color);
			g.drawCircle(radius, radius, radius);
			g.endFill();
			/**
			 * b 
			 */
			var b : BitmapData = new BitmapData(int(_shape.width + 0.5), int(_shape.height + 0.5), true, 0x00FFFFFF);
			b.draw(_shape);
			return b;
		}

		/**
		 * triangle 
		 * 
		 * @param width 
		 * @param height 
		 * @param color 
		 * 
		 * @return 
		 */
		static public function triangle(width : Number, height : Number, color : uint = 0x000000) : BitmapData {
			/**
			 * g 
			 */
			var g : Graphics = _shape.graphics;
			g.clear();
			g.lineStyle(0, 0, 0);
			g.beginFill(color);
			g.moveTo(0, height);
			g.lineTo(width * 0.5, 0);
			g.lineTo(width, height);
			g.lineTo(0, height);
			g.endFill();
			/**
			 * b 
			 */
			var b : BitmapData = new BitmapData(int(_shape.width + 0.5), int(_shape.height + 0.5), true, 0x00FFFFFF);
			b.draw(_shape);
			return b;
		}

		/**
		 * rectangle 
		 * 
		 * @param width 
		 * @param height 
		 * @param color 
		 * 
		 * @return 
		 */
		static public function rectangle(width : Number, height : Number, color : uint = 0x000000) : BitmapData {
			return new BitmapData(int(width + 0.5), int(height + 0.5), true, color);
		}
	}
}
