package me.ianmcgregor.species.factories {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.species.components.Bomb;
	import me.ianmcgregor.species.components.CollisionRect;
	import me.ianmcgregor.species.components.Enemy;
	import me.ianmcgregor.species.components.EnemyShip;
	import me.ianmcgregor.species.components.Friend;
	import me.ianmcgregor.species.components.Hero;
	import me.ianmcgregor.species.components.Level;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityGroup;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.spatials.BombGfx;
	import me.ianmcgregor.species.spatials.BulletGfx;
	import me.ianmcgregor.species.spatials.EnemyGfx;
	import me.ianmcgregor.species.spatials.EnemyShipGfx;
	import me.ianmcgregor.species.spatials.ExplosionGfx;
	import me.ianmcgregor.species.spatials.FirePitGfx;
	import me.ianmcgregor.species.spatials.FriendGfx;
	import me.ianmcgregor.species.spatials.HealthBarGfx;
	import me.ianmcgregor.species.spatials.HeroGfx;
	import me.ianmcgregor.species.spatials.LevelGfx;
	import me.ianmcgregor.species.spatials.WallGfx;

	import com.artemis.Entity;
	import com.artemis.World;

	import flash.geom.Rectangle;

	/**
	 * EntityFactory 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class EntityFactory {
		
		/**
		 * createLevel 
		 * 
		 * @param world 
		 * @param num 
		 * 
		 * @return 
		 */
		public static function createLevel(world : World, num: int) : Entity {
			var e : Entity;
			e = world.createEntity();
			e.setTag(EntityTag.LEVEL);
			e.addComponent(new Level(num));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new SpatialFormComponent(LevelGfx));
			e.refresh();

			return e;
		}
		
		/**
		 * createHero 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createHero(world : World) : Entity {
			var heroHealthComponent: Number = 200;
			
			var e : Entity;
			e = world.createEntity();
			e.setTag(EntityTag.HERO);
			e.addComponent(new Velocity());
			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(HeroGfx));
			e.addComponent(new CollisionRect(5, 4, 22, 28));
			e.addComponent(new HealthComponent(heroHealthComponent));
			e.addComponent(new Hero());
			e.addComponent(new WeaponComponent());
			e.refresh();
			
			e = world.createEntity();
			e.setTag(EntityTag.HEALTH_BAR);
			e.addComponent(new SpatialFormComponent(HealthBarGfx));
			e.addComponent(new HealthComponent(heroHealthComponent));
			e.addComponent(new TransformComponent(120, 10));
			e.refresh();

			return e;
		}
		
		/**
		 * createBullet 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createBullet(world : World) : Entity {
			SoundFactory.shoot();
			
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.BULLETS);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(BulletGfx));
			e.addComponent(new Velocity());
			e.addComponent(new ExpiresComponent(1));
			e.addComponent(new CollisionRect(0, 0, 2, 2));

			return e;
		}
		
		/**
		 * createEnemyBullet 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createEnemyBullet(world : World) : Entity {
			SoundFactory.shoot();
			
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMY_BULLETS);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(BulletGfx));
			e.addComponent(new Velocity());
			e.addComponent(new ExpiresComponent(1));
			e.addComponent(new CollisionRect(0, 0, 2, 2));

			return e;
		}

		/**
		 * createWeaponComponentisedEnemy 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createWeaponisedEnemy(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMIES);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(EnemyGfx));
			e.addComponent(new HealthComponent(50));
			e.addComponent(new WeaponComponent());
			e.addComponent(new Enemy());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(10, 0, 22, 32));

			return e;
		}
		
		/**
		 * createMoustachedEnemy 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createMoustachedEnemy(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.ENEMIES);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(EnemyGfx));
			e.addComponent(new HealthComponent(50));
			e.addComponent(new Enemy());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(10, 0, 22, 32));

			return e;
		}
		
		/**
		 * createEnemyShip 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createEnemyShip(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setTag(EntityTag.ENEMY_SHIP);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(EnemyShipGfx));
			e.addComponent(new EnemyShip());
			e.addComponent(new Velocity(800));
			e.addComponent(new WeaponComponent());
			e.addComponent(new CollisionRect(0, 0, 64, 48));

			return e;
		}

		/**
		 * createExplosion 
		 * 
		 * @param world 
		 * @param x 
		 * @param y 
		 * 
		 * @return 
		 */
		public static function createExplosion(world : World, x : Number, y : Number) : Entity {
			SoundFactory.explode();
			
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.EFFECTS);

			e.addComponent(new TransformComponent(x, y));
			e.addComponent(new SpatialFormComponent(ExplosionGfx));
			e.addComponent(new ExpiresComponent(1));

			return e;
		}
		
		/**
		 * createBomb 
		 * 
		 * @param world 
		 * @param x 
		 * @param y 
		 * 
		 * @return 
		 */
		public static function createBomb(world : World, x : Number, y : Number) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.BOMBS);

			e.addComponent(new TransformComponent(x, y));
			e.addComponent(new Velocity());
			e.addComponent(new SpatialFormComponent(BombGfx));
			e.addComponent(new ExpiresComponent(2));
			e.addComponent(new CollisionRect(4, 4, 20, 20));
			e.addComponent(new Bomb());

			return e;
		}
		
		/**
		 * createFirePit 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createFirePit(world : World) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.FIRES);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(FirePitGfx));
			e.addComponent(new CollisionRect(4, 4, 16, 16));

			return e;
		}
		
		/**
		 * createWall 
		 * 
		 * @param world 
		 * @param rect 
		 * 
		 * @return 
		 */
		public static function createWall(world : World, rect: Rectangle) : Entity {
			var e : Entity = world.createEntity();

			e.setTag(EntityTag.WALL);

			e.addComponent(new TransformComponent(rect.x, rect.y));
			e.addComponent(new SpatialFormComponent(WallGfx));
			e.addComponent(new CollisionRect(0, 0, rect.width, rect.height));

			return e;
		}

		/**
		 * createFriend 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public static function createFriend(world : World) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.FRIENDS);

			e.addComponent(new TransformComponent());
			e.addComponent(new SpatialFormComponent(FriendGfx));
			e.addComponent(new Friend());
			e.addComponent(new Velocity());
			e.addComponent(new CollisionRect(0, 0, 32, 32));

			return e;
		}
	}
}