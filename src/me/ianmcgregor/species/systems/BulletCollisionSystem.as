package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.species.components.CollisionRect;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityGroup;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.utils.IImmutableBag;

	import flash.geom.Rectangle;

	/**
	 * BulletCollisionSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class BulletCollisionSystem extends EntitySystem {
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;
		/**
		 * _healthMapper 
		 */
		private var _healthMapper : ComponentMapper;
		/**
		 * _rectMapper 
		 */
		private var _rectMapper : ComponentMapper;

		/**
		 * BulletCollisionSystem 
		 */
		public function BulletCollisionSystem() {
			super([TransformComponent]);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
			_rectMapper = new ComponentMapper(CollisionRect, _world);
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
			
			var bullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BULLETS);
			var enemyBullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMY_BULLETS);
			var enemies : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMIES);
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);

			if (bullets != null && enemies != null) {
				enemyLoop:
				for (var a : int = 0; enemies.size() > a; a++) {
					var enemy : Entity = enemies.get(a);
					for (var b : int = 0; bullets.size() > b; b++) {
						var bullet : Entity = bullets.get(b);

						if (collisionExists(bullet, enemy)) {
							var bulletTransformComponent : TransformComponent = _transformMapper.get(bullet);
							EntityFactory.createExplosion(_world, bulletTransformComponent.x, bulletTransformComponent.y).refresh();
							
//							trace('world.deleteEntity(bullet);: ');
							_world.deleteEntity(bullet);

							var health : HealthComponent = _healthMapper.get(enemy);
							health.addDamage(4);

							if (!health.isAlive()) {
								var transform : TransformComponent = _transformMapper.get(enemy);

								EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();

//								trace('world.deleteEntity(ship);: ');
								_world.deleteEntity(enemy);
								continue enemyLoop;
							}
						}
					}
				}
			}
			
			if (enemyBullets != null) {
				for (var j : int = 0; enemyBullets.size() > j; j++) {
					var enemyBullet : Entity = enemyBullets.get(j);
	
					if(collisionExists(enemyBullet, hero)) {
						trace('hero shot!');
						
						var heroHealthComponent : HealthComponent = _healthMapper.get(hero);
						heroHealthComponent.addDamage(4);
						
						if (!heroHealthComponent.isAlive()) {
							var t : TransformComponent = _transformMapper.get(hero);
							EntityFactory.createExplosion(_world, t.x, t.y).refresh();
							_world.deleteEntity(hero);
						}
					}
				}
			}
		}

		private const _tempRect1: Rectangle = new Rectangle();
		private const _tempRect2: Rectangle = new Rectangle();
		
		/**
		 * collisionExists 
		 * 
		 * @param e1 
		 * @param e2 
		 * 
		 * @return 
		 */
		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			var t1 : TransformComponent = _transformMapper.get(e1);
			var t2 : TransformComponent = _transformMapper.get(e2);
			var r1 : CollisionRect = _rectMapper.get(e1);
			var r2 : CollisionRect = _rectMapper.get(e2);
			
			_tempRect1.x = r1.rect.x + t1.x;
			_tempRect1.y = r1.rect.y + t1.y;
			_tempRect1.width = r1.rect.width;
			_tempRect1.height = r1.rect.height;
			
			_tempRect2.x = r2.rect.x + t2.x;
			_tempRect2.y = r2.rect.y + t2.y;
			_tempRect2.width = r2.rect.width;
			_tempRect2.height = r2.rect.height;
			
			return _tempRect1.intersects(_tempRect2);
		}

		/**
		 * checkProcessing 
		 * 
		 * @return 
		 */
		override protected function checkProcessing() : Boolean {
			return true;
		}
	}
}