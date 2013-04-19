package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.components.EnemyShip;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityGroup;
	import me.ianmcgregor.species.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.utils.getTimer;

	/**
	 * @author McFamily
	 */
	public class EnemyShipSystem extends EntityProcessingSystem {
		/**
		 * _container 
		 */
		private var _container : GameContainer;	
		/**
		 * _weaponMapper 
		 */
		private var _weaponMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;
		/**
		 * _now 
		 */
		private var _now : int;
		
		/**
		 * EnemyShipSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function EnemyShipSystem(container: GameContainer) {
			super(EnemyShip, [TransformComponent, Velocity, WeaponComponent]);
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
			/**
			 * weapon 
			 */
			var weapon : WeaponComponent = _weaponMapper.get(e);
			/**
			 * transform 
			 */
			var transform : TransformComponent = _transformMapper.get(e);
			/**
			 * velocity 
			 */
			var velocity : Velocity = _velocityMapper.get(e);
			if (weapon.getShotAt() + 300 < _now) {
				var bombEntity : Entity = EntityFactory.createBomb(_world, transform.x + 32, transform.y + 48);
				Velocity(bombEntity.getComponent(Velocity)).velocityY = 6;
				bombEntity.refresh();
				weapon.setShotAt(_now);
			}
			if(transform.x < 64) {
				velocity.velocityX = 7;
			}
			if (transform.x > _container.getWidth() - 128) {
				velocity.velocityX = -7;
			}
			
			trace('velocity.velocityX: ' + (velocity.velocityX));
			trace('transform.x: ' + (transform.x));
			trace('_container.getWidth() - 128: ' + (_container.getWidth() - 128));
			/**
			 * bombs 
			 */
			var bombs : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BOMBS);
			if (bombs != null) {
				for (var b : int = 0; bombs.size() > b; b++) {
					var bomb : Entity = bombs.get(b);
					var bombTransformComponent : TransformComponent = _transformMapper.get(bomb);
					if (bombTransformComponent.y > _container.getHeight() - 60) {
						EntityFactory.createExplosion(_world, bombTransformComponent.x, bombTransformComponent.y).refresh();
						_world.deleteEntity(bomb);
					}
				}
			}
		}
	}
}
