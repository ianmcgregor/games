package me.ianmcgregor.games.artemis.components {
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

		/**
		 * SpatialFormComponent 
		 * 
		 * @param spatialClass 
		 * 
		 * @return 
		 */
		public function SpatialFormComponent(spatialClass : Class) {
			_spatialClass = spatialClass;
		}

		/**
		 * getSpatialFormFile 
		 * 
		 * @return 
		 */
		public function getSpatialFormFile() : Class {
			return _spatialClass;
		}
	}
}