package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.components.Enemy;
	import me.ianmcgregor.species.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntitySystem;
	import com.artemis.utils.IImmutableBag;


	/**
	 * EnemySpawnSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class EnemySpawnSystem extends IntervalEntitySystem {
		/**
		 * _weaponMapper 
		 */
		private var _weaponMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _container 
		 */
		private var _container : GameContainer;

		/**
		 * EnemySpawnSystem 
		 * 
		 * @param interval 
		 * @param container 
		 * 
		 * @return 
		 */
		public function EnemySpawnSystem(interval : Number, container : GameContainer) {
			super(interval, [TransformComponent, WeaponComponent, Enemy]);
			_container = container;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_weaponMapper = new ComponentMapper(WeaponComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
		}

		/**
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
		//	trace("EnemySpawnSystem.processEntities(",entities,")");
			
			var e : Entity = EntityFactory.createWeaponisedEnemy(_world);
			
			var x: int = _container.getWidth() * Math.random();
			var y: int = 260 * Math.random() + 30;
//			var b: Boolean = Math.random() > 0.5;

			TransformComponent(e.getComponent(TransformComponent)).setLocation(x, y);
//			Velocity(e.getComponent(Velocity)).setVelocity(0.05);
//			Velocity(e.getComponent(Velocity)).setAngle(b ? 0 : 180);

			e.refresh();
		}
	}
}