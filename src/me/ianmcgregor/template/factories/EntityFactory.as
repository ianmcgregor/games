package me.ianmcgregor.template.factories {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.template.components.DebugComponent;
	import me.ianmcgregor.template.components.GameConfigComponent;
	import me.ianmcgregor.template.components.GameOverComponent;
	import me.ianmcgregor.template.components.HUDComponent;
	import me.ianmcgregor.template.components.PlayerComponent;
	import me.ianmcgregor.template.components.TitlesComponent;
	import me.ianmcgregor.template.constants.EntityGroup;
	import me.ianmcgregor.template.constants.EntityTag;
	import me.ianmcgregor.template.spatials.BgSpatial;
	import me.ianmcgregor.template.spatials.ControlsSpatial;
	import me.ianmcgregor.template.spatials.DebugSpatial;
	import me.ianmcgregor.template.spatials.GameOverSpatial;
	import me.ianmcgregor.template.spatials.HUDSpatial;
	import me.ianmcgregor.template.spatials.NullSpatial;
	import me.ianmcgregor.template.spatials.PlayerSpatial;
	import me.ianmcgregor.template.spatials.TitlesSpatial;

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
		public static function createPlayer(_world : World, playerNum: int, x: Number, y: Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag( ( playerNum == 1 ? EntityTag.PLAYER_1 : EntityTag.PLAYER_2 ) );
			e.addComponent(new PlayerComponent(playerNum));
			e.addComponent(new SpatialFormComponent(PlayerSpatial));
			e.addComponent(new TransformComponent(x, y));
			e.addComponent(new WeaponComponent());
			e.addComponent(new HealthComponent(1));
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
			e.addComponent(new SpatialFormComponent(NullSpatial));
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
//			e.setGroup(EntityGroup.BULLET);
//			e.addComponent(new SpatialFormComponent(BulletSpatial));
//			e.addComponent(new TransformComponent(0, 0));
//			e.addComponent(new PhysicsComponent(Constants.BULLET, BodyFactory.createBullet()));
//			e.addComponent(new BulletComponent(owner));
////			e.addComponent(new SoundComponent(SiONSounds.BULLET, SiONSounds.BULLET));
//			e.addComponent(new VelocityComponent());
//			e.addComponent(new ExpiresComponent(1));
//			e.addComponent(new DebugComponent(Constants.BULLET));
			e.refresh();
			
			return e;
		}
	}
}