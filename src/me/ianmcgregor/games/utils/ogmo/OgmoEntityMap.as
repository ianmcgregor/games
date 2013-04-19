package me.ianmcgregor.games.utils.ogmo {
	/**
	 * @author ianmcgregor
	 */
	internal dynamic class OgmoEntityMap {
		public function has(type: String) : Boolean {
			return this[type] != null;
		}
		
		public function get(type : String) : Vector.<OgmoEntity> {
			return this[type];
		}
	
		public function put(entity : OgmoEntity) : void {
			if (!this[entity.type]) {
				this[entity.type] = new Vector.<OgmoEntity>();
			}
			var array : Vector.<OgmoEntity> = this[entity.type];
			array[array.length] = entity;
		}
	
		public function getEntity(type : String) : OgmoEntity {
			return this[type][0];
		}
		
		public function getAll(): Vector.<OgmoEntity> {
			var result:Vector.<OgmoEntity> = new Vector.<OgmoEntity>();
			for each (var array : Vector.<OgmoEntity> in this) {
        		result = result.concat(array);
			}
			return result;
		}
		
		public function toString(): String {
			var s : String = "";
			for each (var array : Vector.<OgmoEntity> in this) {
				var l : int = array.length;
				for (var i : int = 0; i < l; ++i) {
					if (s != "") s += "\n";
					s += array[i].toString();
				}
			}
			return s;
		}
	}
}
