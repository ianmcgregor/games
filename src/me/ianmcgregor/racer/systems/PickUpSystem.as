package me.ianmcgregor.racer.systems {
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public class PickUpSystem extends EntityProcessingSystem {
		
		/**
		 * TODO: animate picking up car and putting back onto track
		 */
		
		/**
		 * PickUpSystem 
		 * 
		 * @param requiredType 
		 * @param otherTypes 
		 * 
		 * @return 
		 */
		public function PickUpSystem(requiredType : Class, otherTypes : Array) {
			super(requiredType, otherTypes);
		}
	}
}
