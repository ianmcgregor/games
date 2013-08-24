package me.ianmcgregor.fight.factories {
	import me.ianmcgregor.fight.components.BadGuyComponent;
	import me.ianmcgregor.fight.components.CharacterComponent;
	import me.ianmcgregor.fight.components.DebugComponent;
	import me.ianmcgregor.fight.components.GameConfigComponent;
	import me.ianmcgregor.fight.components.GameOverComponent;
	import me.ianmcgregor.fight.components.HUDComponent;
	import me.ianmcgregor.fight.components.PhysicsComponent;
	import me.ianmcgregor.fight.components.PlayerComponent;
	import me.ianmcgregor.fight.components.TitlesComponent;
	import me.ianmcgregor.fight.constants.AvatarList;
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.EntityGroup;
	import me.ianmcgregor.fight.constants.EntityTag;
	import me.ianmcgregor.fight.spatials.BadGuySpatial;
	import me.ianmcgregor.fight.spatials.BgSpatial;
	import me.ianmcgregor.fight.spatials.BossSpatial;
	import me.ianmcgregor.fight.spatials.ControlsSpatial;
	import me.ianmcgregor.fight.spatials.DebugSpatial;
	import me.ianmcgregor.fight.spatials.GameOverSpatial;
	import me.ianmcgregor.fight.spatials.GroundSpatial;
	import me.ianmcgregor.fight.spatials.HUDSpatial;
	import me.ianmcgregor.fight.spatials.PlayerSpatial;
	import me.ianmcgregor.fight.spatials.TitlesSpatial;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;

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
			
			e = _world.createEntity();
			e.setTag( ( playerNum == 1 ? EntityTag.PLAYER_1 : EntityTag.PLAYER_2 ) );
			e.addComponent(new PlayerComponent(playerNum));
			e.addComponent(AvatarList.getHeroAvatarComponent(playerNum));
			e.addComponent(new CharacterComponent());
			e.addComponent(new SpatialFormComponent(PlayerSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
//			e.addComponent(new VelocityComponent(-1000, 1000, -1000, 1000));
			e.addComponent(new WeaponComponent());
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
			e.addComponent(new BadGuyComponent(Constants.BOSS));
			e.addComponent(new SpatialFormComponent(BossSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.BOSS, BodyFactory.createBoss()));
			e.addComponent(new HealthComponent(2));
			e.refresh();

			return e;
		}
		
		/**
		 * createBadGuy 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBadGuy(_world : World, type: String, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new CharacterComponent());
			e.addComponent(new BadGuyComponent(type));
			e.addComponent(new SpatialFormComponent(BadGuySpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.BAD_GUY, BodyFactory.createBadGuy()));
			e.addComponent(new HealthComponent(0.5));
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
	}
}