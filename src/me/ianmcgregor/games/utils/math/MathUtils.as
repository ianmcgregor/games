package me.ianmcgregor.games.utils.math {
	import flash.geom.Rectangle;
	import flash.geom.Point;

	/**
	 * @author thomas
	 */
	public final class MathUtils {
		/**
		 * abs 
		 * 
		 * @param input 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function abs(input : Number) : Number {
			return input < 0 ? -input : input;
		}

		/**
		 * round 
		 * 
		 * @param input 
		 * 
		 * @return int
		 */
		[Inline]
		public static function round(input : Number) : int {
			return input > 0 ? int(input + 0.5) : int(input - 0.5);
		}

		/**
		 * ceil 
		 * 
		 * @param input 
		 * 
		 * @return int
		 */
		[Inline]
		public static function ceil(input : Number) : int {
			return int(input + 1);
		}

		/**
		 * floor 
		 * 
		 * @param input 
		 * 
		 * @return int
		 */
		[Inline]
		public static function floor(input : Number) : int {
			return int(input);
		}

		/**
		 * min 
		 * 
		 * @param a 
		 * @param b 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function min(a : Number, b : Number) : Number {
			return a < b ? a : b;
		}

		/**
		 * min 
		 * 
		 * @param a 
		 * @param b 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function max(a : Number, b : Number) : Number {
			return a > b ? a : b;
		}

		/**
		 * difference 
		 * 
		 * @param number1 
		 * @param number2 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function difference(number1 : Number, number2 : Number) : Number {
			return abs(number1 - number2);
		}

		/**
		 * distance (euclidean)
		 * 
		 * @param x1 
		 * @param y1 
		 * @param x2 
		 * @param y2 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function distance(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			var dx : Number = x1 - x2;
			var dy : Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}

		/**
		 * random 
		 * 
		 * @param min 
		 * @param max 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function random(min : Number, max : Number = NaN) : Number {
			if ( isNaN(max) ) {
				max = min;
				min = 0;
			}
			return min + Math.random() * (max - min);
		}

		/**
		 * randomInt 
		 * 
		 * @param min 
		 * @param max 
		 * 
		 * @return int
		 */
		[Inline]
		public static function randomInt(min : int = 0, max : int = 100) : int {
			return min + Math.random() * (max - min);
		}

		/**
		 * coinToss 
		 * 
		 * @return Boolean
		 */
		[Inline]
		public static function coinToss() : Boolean {
			return Math.random() > 0.5;
		}

		/**
		 * interpolate 
		 * 
		 * @param min 
		 * @param max 
		 * @param percent 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function interpolate(min : Number, max : Number, percent : Number) : Number {
			return min + (max - min) * percent;
		}

		/**
		 * angle 
		 * 
		 * @param x1 
		 * @param y1 
		 * @param x2 
		 * @param y2 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function angle(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			var dx : Number = x2 - x1;
			var dy : Number = y2 - y1;
			return Math.atan2(dy, dx);
		}

		public static const DEG : Number = 180 / Math.PI;

		/**
		 * degrees 
		 * 
		 * @param radians 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function degrees(radians : Number) : Number {
			return radians * DEG;
		}

		public static const RAD : Number = Math.PI / 180;

		/**
		 * radians 
		 * 
		 * @param degrees 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function radians(degrees : Number) : Number {
			return degrees * RAD;
		}

		/**
		 * lerp 
		 * 
		 * @param from 
		 * @param to 
		 * @param percent 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function lerp(from : Number, to : Number, percent : Number) : Number {
			return from + ( to - from ) * percent;
		}

		/**
		 * clamp 
		 * 
		 * @param value 
		 * @param min 
		 * @param max 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function clamp(value : Number, min : Number = 0, max : Number = 1) : Number {
			return (value >= max) ? max : ((value <= min) ? min : value);
		}

		/**
		 * map - map one range to another
		 * 
		 * e.g.: map(stage.mouseX, 0, stage.stageWidth, 0, 1) will map the stage.mouseX from 0 to stage.stageWidth to 0 to 1
		 * 
		 * @param v - initial value
		 * @param a - initial value min
		 * @param b - initial value max
		 * @param x - map value min 
		 * @param y - map value max
		 * 
		 * @return Number
		 */
		[Inline]
		public static function map(v : Number, a : Number, b : Number, x : Number = 0, y : Number = 1) : Number {
			return (v == a) ? x : (v - a) * (y - x) / (b - a) + x;
		}

		/**
		 * roundToNearest 
		 * 
		 * @param input 
		 * @param amount 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function roundToNearest(input : Number, amount : Number = 10) : Number {
			return round(input / amount) * amount;
		}

		/**
		 * nearestNumber 
		 * 
		 * @param numberTolookFor 
		 * @param numbersToSearch 
		 * 
		 * @return Number
		 */
		[Inline]
		public static function nearestNumber(numberTolookFor : Number, numbersToSearch : Array) : Number {
			var nearest : Number = numbersToSearch[0];
			var diff : Number = abs(nearest - numberTolookFor);
			var l : uint = numbersToSearch.length;
			for (var i : int = 1; i < l; ++i) {
				var newDiff : Number = abs(numbersToSearch[i] - numberTolookFor);
				if (newDiff < diff) {
					nearest = numbersToSearch[i];
					diff = newDiff;
				}
			}
			return nearest;
		}

		/**
		 * getCirclePoints 
		 * 
		 * @param origin 
		 * @param radius 
		 * @param increment 
		 * 
		 * @return Vector.<Point>
		 */
		[Inline]
		public static function getCirclePoints(origin : Point, radius : Number, increment : Number = 1) : Vector.<Point> {
			var points : Vector.<Point> = new Vector.<Point>();
			for (var degrees : int = 0; degrees < 360; degrees += increment) {
				var radians : Number = degrees * RAD;
				var xPos : Number = origin.x + radius * Math.cos(radians);
				var yPos : Number = origin.y + radius * Math.sin(radians);
				points[ points.length ] = new Point(xPos, yPos);
			}
			return points;
		}

		/**
		 * getIntersection
		 * 
		 * @param a
		 * @param b
		 * 
		 * @return Number
		 */
		[Inline]
		public static function getIntersectionArea(a : Rectangle, b : Rectangle) : Number {
			var x11 : Number = a.left;
			var y11 : Number = a.top;
			var x12 : Number = a.left + a.width;
			var y12 : Number = a.top + a.height;
			var x21 : Number = b.left;
			var y21 : Number = b.top;
			var x22 : Number = b.left + b.width;
			var y22 : Number = b.top + b.height;
			var overlapX : Number = max(0, min(x12, x22) - max(x11, x21));
			var overlapY : Number = max(0, min(y12, y22) - max(y11, y21));
			return overlapX * overlapY;
		}
	}
}
