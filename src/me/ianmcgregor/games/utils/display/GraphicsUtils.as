package me.ianmcgregor.games.utils.display {
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;

	/**
	 * @author ian
	 */
	public class GraphicsUtils {
		
		/**
		 * drawRectangle 
		 * 
		 * @param graphics 
		 * @param width 
		 * @param height 
		 * @param color 
		 * @param alpha 
		 * 
		 * @return 
		 */
		public static function drawRectangle(graphics : Graphics, width: Number, height: Number, color: uint = 0xFF0000, alpha: Number = 1): void {
			graphics.beginFill(color, alpha);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		/**
		 * drawWedge 
		 * 
		 * @param graphics 
		 * @param centerX 
		 * @param centerY 
		 * @param radius 
		 * @param arc 
		 * @param startAngle 
		 * 
		 * @return 
		 */
		public static function drawWedge(graphics : Graphics, centerX : Number, centerY : Number, radius : Number, arc : Number, startAngle : Number = 0) : void {
			/**
			 * segAngle 
			 */
			var segAngle : Number;
			/**
			 * angle 
			 */
			var angle : Number;
			/**
			 * angleMid 
			 */
			var angleMid : Number;
			/**
			 * numOfSegs 
			 */
			var numOfSegs : Number;
			/**
			 * ax 
			 */
			var ax : Number;
			/**
			 * ay 
			 */
			var ay : Number;
			/**
			 * bx 
			 */
			var bx : Number;
			/**
			 * by 
			 */
			var by : Number;
			/**
			 * cx 
			 */
			var cx : Number;
			/**
			 * cy 
			 */
			var cy : Number;
                
			// Move the pen
			graphics.moveTo(centerX, centerY);
                
			// No need to draw more than 360
			if (Math.abs(arc) > 360) {
				arc = 360;
			}
                
			numOfSegs = Math.ceil(Math.abs(arc) / 45);
			segAngle = arc / numOfSegs;
			segAngle = (segAngle / 180) * Math.PI;
			angle = (startAngle / 180) * Math.PI;
                
			// Calculate the start point
			ax = centerX + Math.cos(angle) * radius;
			ay = centerY + Math.sin(-angle) * radius;
                
			// Draw the first line
			graphics.lineTo(ax, ay);

			/**
			 * i 
			 */
			for (var i : int = 0;i < numOfSegs;i++) {
				angle += segAngle;
				angleMid = angle - (segAngle / 2);
				bx = centerX + Math.cos(angle) * radius;
				by = centerY + Math.sin(angle) * radius;
				cx = centerX + Math.cos(angleMid) * (radius / Math.cos(segAngle / 2));
				cy = centerY + Math.sin(angleMid) * (radius / Math.cos(segAngle / 2));
				graphics.curveTo(cx, cy, bx, by);
			}
                
			// Close the wedge
			graphics.lineTo(centerX, centerY);
		}
		
		/**
		 * drawVerticalGradientFill 
		 * 
		 * @param graphics 
		 * @param width 
		 * @param height 
		 * @param colors 
		 * @param alphas 
		 * @param ratios 
		 * 
		 * @return 
		 */
		public static function drawVerticalGradientFill(graphics : Graphics, width: Number, height: Number, colors: Array, alphas: Array, ratios: Array): void {
			/**
			 * matrix 
			 */
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, (Math.PI/180)*90, 0, 00); // vertical gradient
			graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
//			graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000,0xFF0000,0xFF0000,0xFF0000], [0,1,1,0], [0,5,250,255], matrix); // eg a vertical gradient mask with soft top and bottom edges
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
	}
}
