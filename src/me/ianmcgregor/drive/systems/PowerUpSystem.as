package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.components.PowerUpComponent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * ExpirationSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class PowerUpSystem extends EntityProcessingSystem {
		/**
		 * _expiresMapper 
		 */
		private var _mapper : ComponentMapper;

		/**
		 * ExpirationSystem 
		 */
		public function PowerUpSystem() {
			super(PowerUpComponent,  []);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_mapper = new ComponentMapper(PowerUpComponent, _world);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var powerUp : PowerUpComponent = _mapper.get(e);
			powerUp.reduceLifeTime(_world.getDelta());

			if (powerUp.isExpired()) {
				//_world.deleteEntity(e);
			}
		}
	}
}