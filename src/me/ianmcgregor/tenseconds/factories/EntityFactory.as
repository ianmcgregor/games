package me.ianmcgregor.tenseconds.factories {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.tenseconds.components.BeamComponent;
	import me.ianmcgregor.tenseconds.components.DebugComponent;
	import me.ianmcgregor.tenseconds.components.EnemyComponent;
	import me.ianmcgregor.tenseconds.components.EnemySpawnComponent;
	import me.ianmcgregor.tenseconds.components.GameConfigComponent;
	import me.ianmcgregor.tenseconds.components.GameOverComponent;
	import me.ianmcgregor.tenseconds.components.HUDComponent;
	import me.ianmcgregor.tenseconds.components.PlayerComponent;
	import me.ianmcgregor.tenseconds.components.TitlesComponent;
	import me.ianmcgregor.tenseconds.components.TowerComponent;
	import me.ianmcgregor.tenseconds.constants.EntityGroup;
	import me.ianmcgregor.tenseconds.constants.EntityTag;
	import me.ianmcgregor.tenseconds.spatials.ControlsSpatial;
	import me.ianmcgregor.tenseconds.spatials.DebugSpatial;
	import me.ianmcgregor.tenseconds.spatials.EnemySpatial;
	import me.ianmcgregor.tenseconds.spatials.GameOverSpatial;
	import me.ianmcgregor.tenseconds.spatials.BgSpatial;
	import me.ianmcgregor.tenseconds.spatials.HUDSpatial;
	import me.ianmcgregor.tenseconds.spatials.TitlesSpatial;
	import me.ianmcgregor.tenseconds.spatials.TowerSpatial;

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
		public static function createGameOver(_world : World, won: Boolean) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new SpatialFormComponent(GameOverSpatial));
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new GameOverComponent(won));
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
			e.addComponent(new TransformComponent(15, 10));
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
		public static function createPlayer(_world : World, playerNum: int) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag( ( playerNum == 1 ? EntityTag.PLAYER_1 : EntityTag.PLAYER_2 ) );
			e.addComponent(new PlayerComponent(playerNum));
			e.addComponent(new HealthComponent(1));
			e.refresh();

			return e;
		}
		
		/**
		 * createTower 
		 * 
		 * @param _world 
		 * @param playerNum 
		 * 
		 * @return 
		 */
		public static function createTower(_world : World, id: int, x: Number, y: Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup(EntityGroup.TOWERS);
			e.addComponent(new SpatialFormComponent(TowerSpatial));
			e.addComponent(new TransformComponent(x, y));
			e.addComponent(new TowerComponent());
			e.addComponent(new BeamComponent(id));
			e.addComponent(new HealthComponent(10));
			e.refresh();

			return e;
		}
		
		/**
		 * createEnemySpawner 
		 * 
		 * @param _world 
		 * @param playerNum 
		 * 
		 * @return 
		 */
		public static function createEnemySpawner(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new EnemySpawnComponent());
			e.refresh();

			return e;
		}
		
		/**
		 * createEnemy
		 * 
		 * @param _world 
		 * @param playerNum 
		 * 
		 * @return 
		 */
		public static function createEnemy(_world : World, x: Number, y: Number) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.setGroup( EntityGroup.ENEMIES );
			e.addComponent(new EnemyComponent());
			e.addComponent(new SpatialFormComponent(EnemySpatial, true));
			var speedMultiplier : Number = 0.8 + 0.4 * Math.random();
			e.addComponent(new TransformComponent(x, y, speedMultiplier));
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
		
		public static function createBg(_world : World) : Entity {
			var e : Entity;
			
			e = _world.createEntity();
			e.addComponent(new TransformComponent(0, 0));
			e.addComponent(new SpatialFormComponent(BgSpatial));
			e.refresh();
			
			return e;
			
		}
	}
}