package me.ianmcgregor.drive.factories {
	import me.ianmcgregor.drive.assets.Assets;
	import me.ianmcgregor.drive.components.BoidComponent;
	import me.ianmcgregor.drive.components.BombComponent;
	import me.ianmcgregor.drive.components.BulletComponent;
	import me.ianmcgregor.drive.components.CharacterComponent;
	import me.ianmcgregor.drive.components.CyclistComponent;
	import me.ianmcgregor.drive.components.DebugComponent;
	import me.ianmcgregor.drive.components.EnemyComponent;
	import me.ianmcgregor.drive.components.GameConfigComponent;
	import me.ianmcgregor.drive.components.GameOverComponent;
	import me.ianmcgregor.drive.components.HUDComponent;
	import me.ianmcgregor.drive.components.LevelComponent;
	import me.ianmcgregor.drive.components.PedestrianComponent;
	import me.ianmcgregor.drive.components.PhysicsComponent;
	import me.ianmcgregor.drive.components.PlayerComponent;
	import me.ianmcgregor.drive.components.PowerUpComponent;
	import me.ianmcgregor.drive.components.RoadBlockComponent;
	import me.ianmcgregor.drive.components.SlickComponent;
	import me.ianmcgregor.drive.components.TitlesComponent;
	import me.ianmcgregor.drive.components.VelocityComponent;
	import me.ianmcgregor.drive.constants.AvatarList;
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.constants.EntityGroup;
	import me.ianmcgregor.drive.constants.EntityTag;
	import me.ianmcgregor.drive.spatials.BgSpatial;
	import me.ianmcgregor.drive.spatials.BombSpatial;
	import me.ianmcgregor.drive.spatials.BossSpatial;
	import me.ianmcgregor.drive.spatials.BoulderSpatial;
	import me.ianmcgregor.drive.spatials.BulletSpatial;
	import me.ianmcgregor.drive.spatials.ControlsSpatial;
	import me.ianmcgregor.drive.spatials.CyclistSpatial;
	import me.ianmcgregor.drive.spatials.DebugSpatial;
	import me.ianmcgregor.drive.spatials.EnemySpatial;
	import me.ianmcgregor.drive.spatials.ExplosionSpatial;
	import me.ianmcgregor.drive.spatials.GameOverSpatial;
	import me.ianmcgregor.drive.spatials.GroundSpatial;
	import me.ianmcgregor.drive.spatials.HUDSpatial;
	import me.ianmcgregor.drive.spatials.LevelSpatial;
	import me.ianmcgregor.drive.spatials.PedestrianSpatial;
	import me.ianmcgregor.drive.spatials.PlayerSpatial;
	import me.ianmcgregor.drive.spatials.RoadBlockSpatial;
	import me.ianmcgregor.drive.spatials.SlickSpatial;
	import me.ianmcgregor.drive.spatials.TitlesSpatial;
	import me.ianmcgregor.drive.spatials.TreeSpatial;
	import me.ianmcgregor.drive.spatials.TruckSpatial;
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;

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
			e.addComponent(new SpatialFormComponent(DebugSpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new DebugComponent());
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
			e.refresh();
			
			return e;
		}
		
		/**
		 * createPlayer 
		 * 
		 * @param _world 
		 * @param playerNum 
		 * 
		 * @return 
		 */
		public static function createPlayer(_world : World, playerNum: int, x: Number, y: Number, width: Number, height: Number) : Entity {
			var e : Entity;
			trace("EntityFactory.createPlayer(",playerNum, x, y, width, height,")");
			e = _world.createEntity();
			e.setTag( ( playerNum == 1 ? EntityTag.PLAYER_1 : EntityTag.PLAYER_2 ) );
			e.addComponent(new PlayerComponent(playerNum));
			e.addComponent(AvatarList.getHeroAvatarComponent(playerNum));
			e.addComponent(new CharacterComponent());
			e.addComponent(new SpatialFormComponent(PlayerSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
//			e.addComponent(new VelocityComponent(-1000, 1000, -1000, 1000));
			e.addComponent(new WeaponComponent());
			e.addComponent(new PowerUpComponent());
			e.addComponent(new HealthComponent(1));
			e.addComponent(new PhysicsComponent(Constants.HERO, BodyFactory.createHero()));
			e.refresh();

			return e;
		}
		
		/**
		 * createControls 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createControls(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(ControlsSpatial));
			e.addComponent(new TransformComponent());
			e.refresh();
			
			return e;
		}
		
		
		/**
		 * createGround 
		 * 
		 * @param _world 
		 * @param player 
		 * 
		 * @return 
		 */
		public static function createGround(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(GroundSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.GROUND, BodyFactory.createGround(x, y, width, height)));
			e.refresh();

			return e;
		}
		/**
		 * createBoss 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBoss(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new CharacterComponent());
			e.addComponent(new EnemyComponent(Constants.BOSS));
			e.addComponent(new SpatialFormComponent(BossSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.BOSS, BodyFactory.createBoss()));
			e.addComponent(new HealthComponent(2));
			e.refresh();

			return e;
		}
		
		/**
		 * createEnemy 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createEnemy(_world : World, type: String, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new CharacterComponent());
			e.addComponent(new EnemyComponent(type));
			e.addComponent(new SpatialFormComponent(EnemySpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.ENEMY, BodyFactory.createEnemy()));
			e.addComponent(new HealthComponent(0.5));
			e.refresh();

			return e;
		}

		/**
		 * createTruck 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createTruck(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(TruckSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.TRUCK, BodyFactory.createTruck()));
			e.refresh();

			return e;
		}
		
		/**
		 * createBg 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBg(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(BgSpatial));
			e.addComponent(new TransformComponent(0, 0));
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
			e.addComponent(new BulletComponent(owner));
//			e.addComponent(new SoundComponent(SiONSounds.BULLET, SiONSounds.BULLET));
			e.addComponent(new VelocityComponent());
			e.addComponent(new ExpiresComponent(1));
			e.addComponent(new DebugComponent(Constants.BULLET));
			e.refresh();

			Audio.play(Assets.bullet);
			
			return e;
		}
		
		
		/**
		 * createLevel 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createLevel(_world : World, level: OgmoLevel) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(EntityTag.LEVEL);
			e.addComponent(new SpatialFormComponent(LevelSpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new LevelComponent(level));
			e.refresh();

			return e;
		}
		
		/**
		 * createPedestrian 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createPedestrian(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new PedestrianComponent());
			e.addComponent(new BoidComponent());
			e.addComponent(new SpatialFormComponent(PedestrianSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.PEDESTRIAN, BodyFactory.createPedestrian(width, height)));
			e.refresh();

			return e;
		}
		
		/**
		 * createCyclist 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createCyclist(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new CyclistComponent());
			e.addComponent(new BoidComponent());
			e.addComponent(new SpatialFormComponent(CyclistSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.CYCLIST, BodyFactory.createCyclist(width, height)));
			e.refresh();

			return e;
		}
		/**
		 * createBomb 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBomb(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new BombComponent());
			e.addComponent(new SpatialFormComponent(BombSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.PEDESTRIAN, BodyFactory.createBomb(width, height)));
			e.refresh();

			return e;
		}
		/**
		 * createCyclist 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createSlick(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SlickComponent());
			e.addComponent(new SpatialFormComponent(SlickSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.SLICK, BodyFactory.createSlick(width, height)));
			e.refresh();

			return e;
		}
		/**
		 * createRoadBlock 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createRoadBlock(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			if(isNaN(width)) width = 64;
			if(isNaN(height)) height = 64;
			
			var e : Entity;
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new RoadBlockComponent());
			e.addComponent(new SpatialFormComponent(RoadBlockSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.ROAD_BLOCK, BodyFactory.createRoadBlock(width, height)));
			e.refresh();

			return e;
		}
		/**
		 * createTree
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createTree(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			if(isNaN(width)) width = 64;
			if(isNaN(height)) height = 64;
			
			var e : Entity;
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
//			e.addComponent(new RoadBlockComponent());
			e.addComponent(new SpatialFormComponent(TreeSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.TREE, BodyFactory.createStaticObstacle(width - 12, height - 6)));
			e.refresh();

			return e;
		}
		/**
		 * createBoulder
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBoulder(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			if(isNaN(width)) width = 64;
			if(isNaN(height)) height = 64;
			
			var e : Entity;
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
//			e.addComponent(new RoadBlockComponent());
			e.addComponent(new SpatialFormComponent(BoulderSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.TREE, BodyFactory.createStaticObstacleCircular(width * 0.4)));
			e.refresh();

			return e;
		}

		public static function createRoad(_world : World, x : Number, y : Number, width : Number, height : Number, type : String) : Entity {
			if(isNaN(width)) width = 1024;
			if(isNaN(height)) height = 256;
			trace("EntityFactory.createRoad(",type,")");
			var e : Entity;
			
//			var c : Class = NapeBitmaps[type];
//			var bitmap : Bitmap = ObjectPool.get(c);
//			var bitmapData: BitmapData = bitmap.bitmapData;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
//			e.addComponent(new TransformComponent(x, y, bitmapData.width, bitmapData.height));
			e.addComponent(new TransformComponent(x, y, width, height));
			//e.addComponent(new PhysicsComponent(type, BodyFactory.createWall(x, y, bitmapData, type)));
			e.refresh();
			
//			ObjectPool.dispose(bitmap);

			return e;
			
		}

		public static function createExplosion(_world : World, x : Number, y : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(ExplosionSpatial));
			e.addComponent(new TransformComponent(x, y));
//			e.addComponent(new ExpiresComponent(1));
			e.refresh();
			
			Audio.play(Assets.explode);
			
			return e;
			
		}
	}
}