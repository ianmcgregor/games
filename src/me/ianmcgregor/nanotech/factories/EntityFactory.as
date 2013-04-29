package me.ianmcgregor.nanotech.factories {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.nanotech.components.BulletComponent;
	import me.ianmcgregor.nanotech.components.DebugComponent;
	import me.ianmcgregor.nanotech.components.EnemyComponent;
	import me.ianmcgregor.nanotech.components.FriendComponent;
	import me.ianmcgregor.nanotech.components.GameConfigComponent;
	import me.ianmcgregor.nanotech.components.GameOverComponent;
	import me.ianmcgregor.nanotech.components.HUDComponent;
	import me.ianmcgregor.nanotech.components.HeroComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.components.SoundComponent;
	import me.ianmcgregor.nanotech.components.TitlesComponent;
	import me.ianmcgregor.nanotech.components.VelocityComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.constants.EntityGroup;
	import me.ianmcgregor.nanotech.constants.EntityTag;
	import me.ianmcgregor.nanotech.spatials.BulletSpatial;
	import me.ianmcgregor.nanotech.spatials.DebugSpatial;
	import me.ianmcgregor.nanotech.spatials.EnemySpatial;
	import me.ianmcgregor.nanotech.spatials.FriendSpatial;
	import me.ianmcgregor.nanotech.spatials.GameOverSpatial;
	import me.ianmcgregor.nanotech.spatials.HUDSpatial;
	import me.ianmcgregor.nanotech.spatials.HeroSpatial;
	import me.ianmcgregor.nanotech.spatials.TitlesSpatial;
	import me.ianmcgregor.nanotech.spatials.gfx.SiONSounds;

	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * EntityFactory 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class EntityFactory {
		/**
		 * createDebug 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createDebug(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(EntityTag.DEBUG);
			e.addComponent(new SpatialFormComponent(DebugSpatial));
			e.addComponent(new TransformComponent(0, 0));
//			e.addComponent(new DebugComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createGameConfig 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createGameConfig(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(EntityTag.GAME_CONFIG);
			e.addComponent(new GameConfigComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createEntity 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createEntity(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(EntityTag.NULL);
			e.setGroup(EntityGroup.NULL);
			e.addComponent(new SpatialFormComponent(EnemySpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.refresh();

			return e;
		}
		
		/**
		 * createTitles 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createTitles(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(TitlesSpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new TitlesComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createGameOver 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createGameOver(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(GameOverSpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new GameOverComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createHUD 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createHUD(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(EntityTag.HUD);
			e.addComponent(new HUDComponent());
			e.addComponent(new SpatialFormComponent(HUDSpatial));
			e.addComponent(new TransformComponent(0, 0));
//			e.addComponent(new SoundComponent());
			e.refresh();
			
			return e;
		}

		/**
		 * createWall 
		 * 
		 * @param _world 
		 * @param player 
		 * 
		 * @return 
		 */
		public static function createWall(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
//			e.addComponent(new SpatialFormComponent(WallSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.WALL, BodyFactory.createWall(x, y, width, height)));
			e.refresh();

			return e;
		}

		/**
		 * createPlayer 
		 * 
		 * @param _world 
		 * @param player 
		 * 
		 * @return 
		 */
		public static function createPlayer(_world : World, player: int) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag( ( player == 1 ? EntityTag.PLAYER_1 : EntityTag.PLAYER_2 ) );
			e.setGroup(EntityGroup.HERO);
			e.addComponent(new HeroComponent(player));
			e.addComponent(new SpatialFormComponent(HeroSpatial));
			e.addComponent(new TransformComponent(350 * player, 220));
			e.addComponent(new SoundComponent(SiONSounds.HERO));
			e.addComponent(new PhysicsComponent(Constants.HERO, BodyFactory.createHero()));
			e.addComponent(new WeaponComponent());
			e.addComponent(new HealthComponent(1));
			e.refresh();

			return e;
		}

		/**
		 * createFriend 
		 * 
		 * @param _world 
		 * @param type 
		 * 
		 * @return 
		 */
		public static function createFriend(_world : World, x: Number, y: Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(FriendSpatial));
			e.addComponent(new TransformComponent(x, y));
			e.addComponent(new PhysicsComponent(Constants.FRIEND, BodyFactory.createFriend()));
			e.addComponent(new HealthComponent(1));
			e.addComponent(new FriendComponent());
			e.addComponent(new SoundComponent(SiONSounds.FRIEND_DAMAGE, null, SiONSounds.FRIEND_KILL));
			e.refresh();

			return e;
		}

		/**
		 * createEnemy 
		 * 
		 * @param _world 
		 * @param type 
		 * 
		 * @return 
		 */
		public static function createEnemy(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.ENEMY);
			e.addComponent(new SpatialFormComponent(EnemySpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new PhysicsComponent(Constants.ENEMY, BodyFactory.createEnemy()));
			e.addComponent(new EnemyComponent());
			e.addComponent(new SoundComponent(SiONSounds.ENEMY, SiONSounds.ENEMY));
			e.addComponent(new HealthComponent(1));
			e.addComponent(new DebugComponent(Constants.ENEMY));
			e.refresh();

			return e;
		}
		
		/**
		 * createBullet 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBullet(_world : World, owner: Entity) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.BULLET);
			e.addComponent(new SpatialFormComponent(BulletSpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new PhysicsComponent(Constants.BULLET, BodyFactory.createBullet()));
//			e.addComponent(new BulletComponent(owner));
			e.addComponent(new BulletComponent(owner));
			e.addComponent(new SoundComponent(SiONSounds.BULLET, SiONSounds.BULLET));
			e.addComponent(new VelocityComponent());
			e.addComponent(new ExpiresComponent(1));
			e.addComponent(new DebugComponent(Constants.BULLET));
			e.refresh();

			return e;
		}
	}
}