package me.ianmcgregor.nanotech.contexts {
	import me.ianmcgregor.games.artemis.systems.ExpirationSystem;
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.nanotech.constants.State;
	import me.ianmcgregor.nanotech.factories.EntityFactory;
	import me.ianmcgregor.nanotech.systems.DebugSystem;
	import me.ianmcgregor.nanotech.systems.EnemySpawnSystem;
	import me.ianmcgregor.nanotech.systems.FriendSystem;
	import me.ianmcgregor.nanotech.systems.GameConfigSystem;
	import me.ianmcgregor.nanotech.systems.GameOverSystem;
	import me.ianmcgregor.nanotech.systems.HUDSystem;
	import me.ianmcgregor.nanotech.systems.HeroControlSystem;
	import me.ianmcgregor.nanotech.systems.PhysicsSystem;
	import me.ianmcgregor.nanotech.systems.SoundSystem;
	import me.ianmcgregor.nanotech.systems.TitlesSystem;

	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class NanotechContext implements IContext {
		/**
		 * _container 
		 */
		private var _gameContainer : GameContainer;
		/**
		 * _world 
		 */
		private var _world : World;
		/**
		 * Systems 
		 */
		private var _debugSystem : EntitySystem;
		private var _renderSystem : EntitySystem;
		private var _soundSystem : EntitySystem;
		private var _titlesSystem : EntitySystem;
		private var _gameOverSystem : EntitySystem;
		private var _hudSystem : EntitySystem;
		private var _physicsSystem : EntitySystem;
		private var _enemySpawnSystem : EntitySystem;
		private var _heroControlSystem : EntitySystem;
		private var _expirationSystem : EntitySystem;
		private var _friendSystem : EntitySystem;
		private var _gameConfigSystem : EntitySystem;

		/**
		 * GameContext 
		 * 
		 * @param container 
		 * 
		 */
		public function NanotechContext(gameContainer : GameContainer) {
			super();
			_gameContainer = gameContainer;
		}

		/**
		 * init 
		 * 
		 * @return 
		 */
		public function init() : void {
			_world = new World();

			/**
			 * systemManager 
			 */
			var systemManager : SystemManager = _world.getSystemManager();
			
			// set systems
			_debugSystem = systemManager.setSystem(new DebugSystem(_gameContainer));
			_gameConfigSystem = systemManager.setSystem(new GameConfigSystem(_gameContainer));
			_renderSystem = systemManager.setSystem(new RenderSystem(_gameContainer));
			_soundSystem = systemManager.setSystem(new SoundSystem(_gameContainer));
			_titlesSystem = systemManager.setSystem(new TitlesSystem(_gameContainer));
			_gameOverSystem = systemManager.setSystem(new GameOverSystem(_gameContainer));
			_hudSystem = systemManager.setSystem(new HUDSystem(_gameContainer));
			_physicsSystem = systemManager.setSystem(new PhysicsSystem(_gameContainer));
			_enemySpawnSystem = systemManager.setSystem(new EnemySpawnSystem(_gameContainer));
			_heroControlSystem = systemManager.setSystem(new HeroControlSystem(_gameContainer));
			_expirationSystem = systemManager.setSystem(new ExpirationSystem());
			_friendSystem = systemManager.setSystem(new FriendSystem(_gameContainer));
			
			// init systems
			systemManager.initializeAll();

			// init entities
			createEntities();
		}

		/**
		 * createEntities 
		 * 
		 * @return 
		 */
		private function createEntities() : void {
			EntityFactory.createGameConfig(_world);
			EntityFactory.createTitles(_world);
			
			//EntityFactory.createDebug(_world);
			/**
			 * create walls
			 */
			var d : Number = 100;
			var w : Number = _gameContainer.getWidth() + d * 2;
			var h : Number = _gameContainer.getHeight() + d * 2;
			var t : Number = 10;
			EntityFactory.createWall(_world, -d, h, w, t);
			EntityFactory.createWall(_world, -d, -d, t, h);
			EntityFactory.createWall(_world, w, -d, t, h);
			EntityFactory.createWall(_world, -d, -d, w, t);
		}

		/**
		 * update 
		 * 
		 * @param deltaTime 
		 * 
		 * @return 
		 */
		public function update(deltaTime : Number) : void {
			_world.loopStart();
			_world.setDelta(deltaTime);

			// process systems
			
			switch(_gameContainer.state){
				case State.TITLES:
					_titlesSystem.process();
					break;
				case State.GAME_START:
				case State.GAME_END:
					_gameConfigSystem.process();
					break;
				case State.PLAY:
					_gameConfigSystem.process();
					_physicsSystem.process();
					_enemySpawnSystem.process();
					_hudSystem.process();
					_heroControlSystem.process();
					_expirationSystem.process();
					_friendSystem.process();
					break;
				case State.GAME_OVER:
					_gameOverSystem.process();
					break;
				default:
			}
			_soundSystem.process();
			_renderSystem.process();
			_debugSystem.process();
		}

		/**
		 * world 
		 */
		public function get world() : World {
			return _world;
		}
	}
}
