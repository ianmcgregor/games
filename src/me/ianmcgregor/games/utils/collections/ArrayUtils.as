package me.ianmcgregor.games.utils.collections {
	/**
	 * @author sam rad
	 */
	public class ArrayUtils {
		
		/**
		 * sortRandom 
		 * 
		 * @param array 
		 * 
		 * @return 
		 */
		public static function sortRandom(array:Object):Object
		{
			return array["sort"](randomSort);
		}
		
		/**
		 * randomSort 
		 * 
		 * @param a 
		 * @param b 
		 * 
		 * @return 
		 */
		private static function randomSort(a : *, b : *) : Number {
		    a, b;
		    return Math.random() < 0.5 ? -1 : 1;
		}
		
		/**
		 * getRandomElement 
		 * 
		 * @param array 
		 * 
		 * @return 
		 */
		public static function getRandomElement(array:Object):* {
			return array[ Math.floor(array.length * Math.random()) ];
		}
		
		/**
		 * getElementAtPercent - between 0 and 1 
		 * 
		 * @param array 
		 * 
		 * @return 
		 */
		public static function getElementAtPercent(array:Object, percent: Number):* {
			if(isNaN(percent)) percent = 0;
			if(percent < 0) percent = 0;
			if(percent >= 1) percent = 0.99999999;
			return array[ Math.floor(array.length * percent) ];
		}
		
		/**
		 * objectToArray 
		 * 
		 * @param object 
		 * 
		 * @return 
		 */
		public static function objectToArray(object: Object): Array {
			/**
			 * array 
			 */
			var array: Array = [];
			/**
			 * i 
			 */
			for (var i : Object in object) {
				array.push(object[i]);
			}
			return array;
		}
		
		
	}
}
