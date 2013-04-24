package me.ianmcgregor.rogue.factories {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.utils.ogmo.OgmoEntity;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import me.ianmcgregor.nanotech.components.BulletComponent;
	import me.ianmcgregor.rogue.components.BatComponent;
	import me.ianmcgregor.rogue.components.CollisionComponent;
	import me.ianmcgregor.rogue.components.DebugComponent;
	import me.ianmcgregor.rogue.components.GameConfigComponent;
	import me.ianmcgregor.rogue.components.GameOverComponent;
	import me.ianmcgregor.rogue.components.HUDComponent;
	import me.ianmcgregor.rogue.components.InventoryComponent;
	import me.ianmcgregor.rogue.components.ItemComponent;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.MessageComponent;
	import me.ianmcgregor.rogue.components.MonsterComponent;
	import me.ianmcgregor.rogue.components.MoveableComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.SwordComponent;
	import me.ianmcgregor.rogue.components.TitlesComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityGroup;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.spatials.BatSpatial;
	import me.ianmcgregor.rogue.spatials.ControlsSpatial;
	import me.ianmcgregor.rogue.spatials.DebugSpatial;
	import me.ianmcgregor.rogue.spatials.GameOverSpatial;
	import me.ianmcgregor.rogue.spatials.HUDSpatial;
	import me.ianmcgregor.rogue.spatials.ItemSpatial;
	import me.ianmcgregor.rogue.spatials.LevelSpatial;
	import me.ianmcgregor.rogue.spatials.MessageSpatial;
	import me.ianmcgregor.rogue.spatials.MonsterBulletSpatial;
	import me.ianmcgregor.rogue.spatials.MonsterSpatial;
	import me.ianmcgregor.rogue.spatials.PlayerSpatial;
	import me.ianmcgregor.rogue.spatials.SpatterSpatial;
	import me.ianmcgregor.rogue.spatials.SwordSpatial;
	import me.ianmcgregor.rogue.spatials.TitlesSpatial;

	import com.artemis.Component;
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
		private static const TEMP_SCALE : Number = 1;
		
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
			e.addComponent(new TransformComponent(860, 0));
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
			e.addComponent(new TransformComponent(0, 10));
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
		public static function createPlayer(_world : World, playerNum: int, data: OgmoEntity) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag( ( playerNum == 1 ? EntityTag.PLAYER_1 : EntityTag.PLAYER_2 ) );
			e.addComponent(new PlayerComponent(playerNum));
			e.addComponent(new SpatialFormComponent(PlayerSpatial));
			// FIXME: temp scaling position
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new WeaponComponent());
			e.addComponent(new HealthComponent(1));
			e.addComponent(new VelocityComponent(-3,3,-3,3));
			e.addComponent(new CollisionComponent(2,2,28,28));
			e.addComponent(new InventoryComponent());
			e.refresh();
			
			//createWeapon(_world, e, "", ( playerNum == 1 ? EntityTag.WEAPON_PLAYER_1 : EntityTag.WEAPON_PLAYER_2 ));			

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
			e.setTag(EntityTag.CONTROLS);
			e.addComponent(new SpatialFormComponent(ControlsSpatial));
			e.addComponent(new TransformComponent());
			e.refresh();
			
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
			trace("EntityFactory.createLevel(",_world, level,")");
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
		 * createMonster 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createMonster(_world : World, data: OgmoEntity) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(MonsterSpatial));
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new MonsterComponent(data.type));
			e.addComponent(new HealthComponent(1));
			if( data.type == Constants.MONSTER_MAN )e.addComponent(new WeaponComponent());
			e.addComponent(new VelocityComponent());
			e.addComponent(new CollisionComponent(2,2,28,28));
			
			e.refresh();

			return e;
		}
		
		/**
		 * createBat 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createBat(_world : World, data: OgmoEntity) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(BatSpatial));
			// FIXME: temp scaling position
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new BatComponent());
			e.addComponent(new HealthComponent(1));
			e.addComponent(new WeaponComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createMonsterBullet 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createMonsterBullet(_world : World, fromX: Number, fromY: Number, velX: Number, velY: Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.BULLETS);
			e.addComponent(new SpatialFormComponent(MonsterBulletSpatial));
			e.addComponent(new TransformComponent(fromX, fromY));
			e.addComponent(new BulletComponent(null));
			e.addComponent(new VelocityComponent(-10, 10, -10, 10, velX, velY));
			e.addComponent(new ExpiresComponent(1));
			e.refresh();

			return e;
		}
		
		/**
		 * createSpatter 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createSpatter(_world : World, x: Number, y: Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(SpatterSpatial));
			e.addComponent(new TransformComponent(x, y));
			e.addComponent(new ExpiresComponent(0.5));
			e.refresh();

			return e;
		}
		
		/**
		 * createMessage
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createMessage(_world : World, text: String, lifeTime : Number = NaN, transformToFollow: TransformComponent = null, x: Number = NaN, y: Number = NaN) : Entity {
			var e : Entity;
			
			if(isNaN(lifeTime)) lifeTime = 4;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(MessageSpatial));
			e.addComponent(transformToFollow || new TransformComponent(x, y));
			e.addComponent(new ExpiresComponent(lifeTime));
			e.addComponent(new MessageComponent(text));
			e.refresh();

			return e;
		}
		
		/**
		 * createItem 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createItem(_world : World, data: OgmoEntity, tex: String) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(ItemSpatial));
			// FIXME: temp scaling position
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new ItemComponent(data.type, tex));
			e.refresh();

			return e;
		}
		
		/**
		 * createItem2 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createItem2(_world : World, data : OgmoEntity, tex : String, component : Component) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(ItemSpatial));
			// FIXME: temp scaling position
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new ItemComponent(data.type, tex));
			e.addComponent(component);
			e.refresh();

			return e;
		}
		
		/**
		 * createMoveableItem 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createMoveableItem(_world : World, data: OgmoEntity, tex: String) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new SpatialFormComponent(ItemSpatial));
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new ItemComponent(data.type, tex));
			e.addComponent(new CollisionComponent(0, 0, Constants.TILE_SIZE, Constants.TILE_SIZE));
			e.addComponent(new VelocityComponent());
			e.addComponent(new MoveableComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createInvisibleItem 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createInvisibleItem(_world : World, data: OgmoEntity) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.LEVEL_ENTITIES);
			e.addComponent(new TransformComponent(data.x * TEMP_SCALE, data.y * TEMP_SCALE));
			e.addComponent(new CollisionComponent(0, 0, data.width, data.height));
			e.addComponent(new ItemComponent(data.type, null));
			e.refresh();

			return e;
		}
		
		/**
		 * createWeapon 
		 * 
		 * @param _world 
		 * 
		 * @return 
		 */
		public static function createWeapon(_world : World, owner : Entity, weapon : String, tag: String) : Entity {
			weapon;
			
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(tag);
			e.setGroup(EntityGroup.WEAPONS);
			e.addComponent(new SpatialFormComponent(SwordSpatial));
			//e.addComponent(new TransformComponent());
			e.addComponent(owner.getComponent(TransformComponent));
			e.addComponent(new SwordComponent(owner));
//			e.addComponent(new ExpiresComponent(0.5));
			e.addComponent(new CollisionComponent(-32, 0, 64, 32));
			e.refresh();

			return e;
		}
	}
}