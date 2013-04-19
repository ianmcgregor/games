package me.ianmcgregor.games.debug {
	import me.ianmcgregor.games.utils.collections.ObjectPool;

	import flash.utils.Dictionary;

	/**
	 * @author McFamily
	 */
	public final class ObjectPoolMonitor extends AbstractDebugPanel implements IUpdateable {
		private const TITLE : String = "OBJECT POOLS:";
		/**
		 * ObjectPoolMonitor 
		 */
		public function ObjectPoolMonitor() {
			super(TITLE);
		}
		
		/**
		 * update 
		 * 
		 * @return 
		 */
		public function update() : void {
			this.text = getInfo();
		}

		/**
		 * getInfo 
		 * 
		 * @return 
		 */
		private function getInfo() : String {
			/**
			 * text 
			 */
			var text : String = TITLE;
			/**
			 * pools 
			 */
			var pools : Dictionary = ObjectPool.pools;
			/**
			 * key 
			 */
			for (var key : Object in pools) {
				/**
				 * array 
				 */
				var array : Array = pools[key];
				text += "\n";
				text += key + ': ' + array.length;
			}
			return text;
		}
	}
}
