package me.ianmcgregor.games.utils.math {
	/**
	 * @author ian
	 */
	public final class Random {
		/**
		 * _array 
		 */
		private var _array : Vector.<Number>;
		/**
		 * _index 
		 */
		private var _index : int = -1;
		/**
		 * _count 
		 */
		private var _count : uint;	
		
		/**
		 * Random 
		 * 
		 * @param count 
		 * @param min 
		 * @param max 
		 * 
		 * @return 
		 */
		public function Random(count: uint = 1000, min: Number = 0, max: Number = 1) {
			_count = count;
			_array = new Vector.<Number>(_count);
			/**
			 * i 
			 */
			var i: uint = 0;
			while (i++ < _count) {
				_array[i] = min + Math.random() * (max - min);
			}
			_array.fixed = true;
		}
		
		/**
		 * get 
		 * 
		 * @return 
		 */
		public function get(): Number {
			_index ++;
			if(_index > _count - 1) _index = 0;
			return _array[_index];
		}
	}
}
