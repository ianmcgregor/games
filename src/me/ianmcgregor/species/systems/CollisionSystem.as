package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.species.components.Bomb;
	import me.ianmcgregor.species.components.CollisionRect;
	import me.ianmcgregor.species.components.Hero;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityGroup;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.geom.Rectangle;

	/**
	 * @author McFamily
	 */
	public class CollisionSystem extends EntityProcessingSystem {
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;
		/**
		 * _rectMapper 
		 */
		private var _rectMapper : ComponentMapper;
		/**
		 * _healthMapper 
		 */
		private var _healthMapper : ComponentMapper;

		/**
		 * CollisionSystem 
		 */
		public function CollisionSystem() {
			super(TransformComponent, [CollisionRect]);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_healthMapper = new ComponentMapper(HealthComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
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

			/**
			 * hero 
			 */
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			if (hero != null) {
				var transform : TransformComponent = _transformMapper.get(hero);
				var health : HealthComponent = _healthMapper.get(hero);
				var enemies : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMIES);

				if (enemies != null) {
//					enemyLoop:
					for (var a : int = 0; enemies.size() > a; a++) {
						var enemy : Entity = enemies.get(a);

						if (collisionExists(hero, enemy)) {
							health.addDamage(4);
//							// SoundFactory.grapple();
//
//							if (!health.isAlive()) {
//								EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();
//
//								_world.deleteEntity(hero);
//								continue enemyLoop;
//							}
						}
						
						var enemyHealthComponent : HealthComponent = _healthMapper.get(enemy);
						if( checkBombCollision(enemy) ) {
							enemyHealthComponent.addDamage(10);
						}
						if( checkFireCollision(enemy) ) {
							enemyHealthComponent.addDamage(2);
						}
						if (!enemyHealthComponent.isAlive()) {
							var enemyTransformComponent : TransformComponent = _transformMapper.get(enemy);
							EntityFactory.createExplosion(_world, enemyTransformComponent.x, enemyTransformComponent.y).refresh();
							_world.deleteEntity(enemy);
						}
					}
				}
					
					
				if( checkBombCollision(hero) ) {
					health.addDamage(20);
				}
				if( checkFireCollision(hero) ) {
					health.addDamage(2);

				}
				if (!health.isAlive()) {
					EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();

					_world.deleteEntity(hero);
				}
					
//				var bombs : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BOMBS);
//				if (bombs != null) {
//					bombsLoop:
//					for (var b : int = 0; bombs.size() > b; b++) {
//						var bomb : Entity = bombs.get(b);
//	
//						if (collisionExists(hero, bomb)) {
//							health.addDamage(50);
//
//							if (!health.isAlive()) {
//								EntityFactory.createExplosion(_world, transform.x, transform.y).refresh();
//
//								_world.deleteEntity(hero);
//								continue bombsLoop;
//							}
//						}
//					}
//				}
				var friends : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.FRIENDS);
				if (friends != null) {
					for (var f : int = 0; friends.size() > f; f++) {
						var friend : Entity = friends.get(f);

						if (collisionExists(hero, friend)) {
							var heroComponent : Hero = Hero(hero.getComponent(Hero));
							heroComponent.won = true;
						}
					}
				}
			}
		}

		/**
		 * checkBombCollision 
		 * 
		 * @param entity 
		 * 
		 * @return 
		 */
		private function checkBombCollision(entity : Entity) : Boolean {
			/**
			 * bombs 
			 */
			var bombs : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BOMBS);
			if (bombs != null) {
				for (var b : int = 0; bombs.size() > b; b++) {
					var bomb : Entity = bombs.get(b);
					var bombComponent : Bomb = bomb.getComponent(Bomb) as Bomb;
					if (bombComponent.active && collisionExists(entity, bomb)) {
						bombComponent.active = false;
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * checkFireCollision 
		 * 
		 * @param entity 
		 * 
		 * @return 
		 */
		private function checkFireCollision(entity : Entity) : Boolean {
			/**
			 * fires 
			 */
			var fires : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.FIRES);
			if (fires != null) {
				for (var b : int = 0; fires.size() > b; b++) {
					var fire : Entity = fires.get(b);

					if (collisionExists(entity, fire)) {
						return true;
					}
				}
			}
			return false;
		}

		private const _tempRect1 : Rectangle = new Rectangle();
		private const _tempRect2 : Rectangle = new Rectangle();

		/**
		 * collisionExists 
		 * 
		 * @param e1 
		 * @param e2 
		 * 
		 * @return 
		 */
		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			/**
			 * t1 
			 */
			var t1 : TransformComponent = _transformMapper.get(e1);
			/**
			 * t2 
			 */
			var t2 : TransformComponent = _transformMapper.get(e2);
			/**
			 * r1 
			 */
			var r1 : CollisionRect = _rectMapper.get(e1);
			/**
			 * r2 
			 */
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
	}
}
