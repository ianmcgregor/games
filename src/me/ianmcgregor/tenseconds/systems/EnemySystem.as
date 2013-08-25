package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.tenseconds.components.EnemyComponent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public class EnemySystem extends EntityProcessingSystem {
		/**
		 * mappers 
		 */
		private var _transformMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;

		/**
		 * PlaySystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function EnemySystem() {
			super(EnemyComponent, null);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var h: HealthComponent = _healthMapper.get(e);
			if (!h.isAlive()) {
				_world.deleteEntity(e);
			} else {
				var t: TransformComponent = _transformMapper.get(e);
				t.y += 20 * _world.getDelta();
			}
		}
	}
}
