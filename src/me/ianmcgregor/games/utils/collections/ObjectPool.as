package me.ianmcgregor.games.utils.collections {
	import flash.utils.Dictionary;

	/**
	 * @author ian
	 */
	public final class ObjectPool {
		/**
		 * ObjectPool - generic pool of object pools that handles different class types 
		 */
		
		/**
		 * _pools 
		 */
		private static var _pools : Dictionary = new Dictionary();
		
		/**
		 * getPool - return existing pool or create a new one 
		 * 
		 * @param clazz 
		 * 
		 * @return 
		 */
		private static function getPool(clazz : Class) : Array {
			return clazz in _pools ? _pools[clazz] : _pools[clazz] = [];
		}
		
		/**
		 * get - get an object from the pool or create a new one
		 * 
		 * @param clazz 
		 * 
		 * @return 
		 */
		public static function get(clazz : Class) : * {
			
			/**
			 * pool 
			 */
			var pool : Array = getPool(clazz);
			if ( pool.length > 0 ) {
				return pool.pop();
			} else {
				return new clazz();
			}
		}
		
		public static function getWithArgs(clazz : Class, ...arg) : * {
			
			/**
			 * pool 
			 */
			var pool : Array = getPool(clazz);
			if ( pool.length > 0 ) {
				return pool.pop();
			} else {
				switch (arg.length) {
					case 1:
						return new clazz(arg[0]);
					case 2:
						return new clazz(arg[0], arg[1]);
					case 3:
						return new clazz(arg[0], arg[1], arg[2]);
					case 4:
						return new clazz(arg[0], arg[1], arg[2], arg[3]);
					case 0:
						return new clazz();
					default:
						throw new Error('Too many arguments');
				}
			}
		}
		
		/**
		 * dispose - put it back for reuse
		 * 
		 * @param object 
		 * 
		 * @return 
		 */
		public static function dispose(object : Object) : void {
			/**
			 * type 
			 */
			var type : Class = object.constructor as Class;
			/**
			 * pool 
			 */
			var pool : Array = getPool(type);
			pool[pool.length] = object;
		}
		
		/**
		 * fill - pre-fill the object pool with instances
		 * 
		 * @param clazz 
		 * @param count 
		 * 
		 * @return 
		 */
		public static function fill(clazz : Class, count: uint) : void {
			/**
			 * pool 
			 */
			var pool : Array = getPool(clazz);
			while ( pool.length < count ) {
				pool[pool.length] = new clazz();
			}
		}
		
		/**
		 * empty - discard all the pools
		 * 
		 * @return 
		 */
		public static function empty() : void {
			_pools = new Dictionary();
		}
		
		/**
		 * pools - get the pools dict - only used to monitor pools in debug tool 
		 */
		public static function get pools() : Dictionary {
			return _pools;
		}
	}
}