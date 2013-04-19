package me.ianmcgregor.species.systems {
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public class SoundSystem extends EntityProcessingSystem {
		/**
		 * SoundSystem 
		 * 
		 * @param requiredType 
		 * @param otherTypes 
		 * 
		 * @return 
		 */
		public function SoundSystem(requiredType : Class, otherTypes : Array) {
			super(requiredType, otherTypes);
		}
	}
}
