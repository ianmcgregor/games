package me.ianmcgregor.chicks.factories {
	import me.ianmcgregor.chicks.spatials.MamaSpatial;
	import me.ianmcgregor.chicks.spatials.WireSpatial;
	import me.ianmcgregor.chicks.components.DropperComponent;
	import me.ianmcgregor.chicks.components.DebugComponent;
	import me.ianmcgregor.chicks.components.GameConfigComponent;
	import me.ianmcgregor.chicks.components.GameOverComponent;
	import me.ianmcgregor.chicks.components.HUDComponent;
	import me.ianmcgregor.chicks.components.PhysicsComponent;
	import me.ianmcgregor.chicks.components.PlayerComponent;
	import me.ianmcgregor.chicks.components.TitlesComponent;
	import me.ianmcgregor.chicks.constants.Constants;
	import me.ianmcgregor.chicks.constants.EntityGroup;
	import me.ianmcgregor.chicks.constants.EntityTag;
	import me.ianmcgregor.chicks.spatials.BgSpatial;
	import me.ianmcgregor.chicks.spatials.ControlsSpatial;
	import me.ianmcgregor.chicks.spatials.DebugSpatial;
	import me.ianmcgregor.chicks.spatials.EggSpatial;
	import me.ianmcgregor.chicks.spatials.GameOverSpatial;
	import me.ianmcgregor.chicks.spatials.GroundSpatial;
	import me.ianmcgregor.chicks.spatials.HUDSpatial;
	import me.ianmcgregor.chicks.spatials.PlayerSpatial;
	import me.ianmcgregor.chicks.spatials.TitlesSpatial;
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
		 * createEgg 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createEgg(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(EggSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.EGG, BodyFactory.createEgg()));
			e.refresh();

			return e;
		}
		/**
		 * createEgg 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createDropper(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new DropperComponent());
			e.addComponent(new TransformComponent(x, y, width, height));
			e.refresh();

			return e;
		}
		/**
		 * createEgg 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createWire(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(WireSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.WIRE, BodyFactory.createWire()));
			e.refresh();

			return e;
		}
		/**
		 * createMama 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createMama(_world : World, x : Number, y : Number, width : Number, height : Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(MamaSpatial));
			e.addComponent(new TransformComponent(x, y, width, height));
			e.addComponent(new PhysicsComponent(Constants.MAMA, BodyFactory.createMama()));
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