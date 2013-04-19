package me.ianmcgregor.games.artemis.systems {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;

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
	public final class ExpirationSystem extends EntityProcessingSystem {
		/**
		 * _expiresMapper 
		 */
		private var _expiresMapper : ComponentMapper;

		/**
		 * ExpirationSystem 
		 */
		public function ExpirationSystem() {
			super(ExpiresComponent,  []);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_expiresMapper = new ComponentMapper(ExpiresComponent, _world);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var expires : ExpiresComponent = _expiresMapper.get(e);
			expires.reduceLifeTime(_world.getDelta());

			if (expires.isExpired()) {
				_world.deleteEntity(e);
			}
		}
	}
}