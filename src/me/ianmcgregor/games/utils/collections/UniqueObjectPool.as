package me.ianmcgregor.games.utils.collections {

	/**
	 * @author ian
	 */
	public final class UniqueObjectPool {
		/**
		 * UniqueObjectPool - object pool that handles one class type 
		 */
		
		/**
		 * _pools 
		 */
		private var _pool : Array = [];
		
		/**
		 * get - get an object from the pool or create a new one
		 * 
		 * @param clazz 
		 * 
		 * @return 
		 */
		public function get(clazz : Class) : * {
			if ( _pool.length > 0 ) {
				return _pool.pop();
			} else {
				return new clazz();
			}
		}
		
		/**
		 * dispose - put it back for reuse
		 * 
		 * @param object 
		 * 
		 * @return 
		 */
		public function dispose(object : Object) : void {
			_pool[_pool.length] = object;
		}
		
		/**
		 * fill - pre-fill the object pool with instances
		 * 
		 * @param clazz 
		 * @param count 
		 * 
		 * @return 
		 */
		public function fill(clazz : Class, count: uint) : void {
			while ( _pool.length < count ) {
				_pool[_pool.length] = new clazz();
			}
		}
		
		/**
		 * empty - discard all the objects
		 * 
		 * @return 
		 */
		public function empty() : void {
			_pool = [];
		}
		
		/**
		 * pool - get the pool array - only used to monitor pools in debug tool 
		 */
		public function get pool() : Array {
			return _pool;
		}
	}
}