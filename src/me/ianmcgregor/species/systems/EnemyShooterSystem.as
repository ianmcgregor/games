package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.species.components.Enemy;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.utils.getTimer;

	/**
	 * EnemyShooterSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class EnemyShooterSystem extends EntityProcessingSystem {
		/**
		 * _weaponMapper 
		 */
		private var _weaponMapper : ComponentMapper;
		/**
		 * _now 
		 */
		private var _now : int;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;

		/**
		 * EnemyShooterSystem 
		 */
		public function EnemyShooterSystem() {
			super(TransformComponent, [WeaponComponent, Enemy]);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_weaponMapper = new ComponentMapper(WeaponComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_now = getTimer();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var weapon : WeaponComponent = _weaponMapper.get(e);
			if (weapon.getShotAt() + 120 < _now) {
				var transform : TransformComponent = _transformMapper.get(e);
				var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
				var heroTransformComponent : TransformComponent = _transformMapper.get(hero);
				if( Math.abs(transform.y - heroTransformComponent.y) < 50){
					var velocity : Velocity = _velocityMapper.get(e);
					
					var direction : int = velocity.velocityX > 0 ? 1 : -1;
					var bulletX: int = direction > 0 ? transform.x + 36 : transform.x - 4;
					var bullet : Entity = EntityFactory.createEnemyBullet(_world);
					TransformComponent(bullet.getComponent(TransformComponent)).setLocation( bulletX, transform.y + 18);
					Velocity(bullet.getComponent(Velocity)).velocityX = 20 * direction;
	//				Velocity(missile.getComponent(Velocity)).setAngle(270);
					bullet.refresh();
				}
				weapon.setShotAt(_now);
			}
		}
	}
}