package me.ianmcgregor.games.artemis.components {
	import com.artemis.Entity;
	import com.artemis.World;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.utils.collections.ObjectPool;

	import com.artemis.Component;

	/**
	 * SpatialFormComponent 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class SpatialFormComponent extends Component {
		/**
		 * _spatialClass 
		 */
		private var _spatialClass : Class;
		public var useObjectPool : Boolean;

		/**
		 * SpatialFormComponent 
		 * 
		 * @param spatialClass 
		 * 
		 * @return 
		 */
		public function SpatialFormComponent(spatialClass : Class, useObjectPool : Boolean = false) {
			_spatialClass = spatialClass;
			this.useObjectPool = useObjectPool;
		}

		/**
		 * getSpatialFormFile 
		 * 
		 * @return 
		 */
		public function getSpatialFormFile() : Class {
			return _spatialClass;
		}
		
		/**
		 * getSpatialFormFile 
		 * 
		 * @return 
		 */
		public function getFromObjectPool(world: World, e : Entity): Spatial {
			var inst: Spatial = ObjectPool.getWithArgs(_spatialClass, world, e);
			inst.reuse(world, e);
			return inst;
		}
	}
}