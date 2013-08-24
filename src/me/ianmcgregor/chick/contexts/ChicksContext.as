package me.ianmcgregor.chick.contexts {
	import me.ianmcgregor.chick.constants.State;
	import me.ianmcgregor.chick.factories.EntityFactory;
	import me.ianmcgregor.chick.systems.DebugSystem;
	import me.ianmcgregor.chick.systems.EggDropperSystem;
	import me.ianmcgregor.chick.systems.GameConfigSystem;
	import me.ianmcgregor.chick.systems.GameOverSystem;
	import me.ianmcgregor.chick.systems.PhysicsSystem;
	import me.ianmcgregor.chick.systems.PlayerControlSystem;
	import me.ianmcgregor.chick.systems.SoundSystem;
	import me.ianmcgregor.chick.systems.TitlesSystem;
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;

	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class ChicksContext implements IContext {
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
		private var _renderSystem : EntitySystem;
		private var _soundSystem : EntitySystem;
		private var _titlesSystem : EntitySystem;
		private var _gameOverSystem : EntitySystem;
//		private var _hudSystem : EntitySystem;
//		private var _nullSystem : EntitySystem;
		private var _debugSystem : EntitySystem;
		private var _gameConfigSystem : EntitySystem;
		private var _playerControlSystem : EntitySystem;
		private var _physicsSystem : EntitySystem;
		private var _eggDropperSystem : EntitySystem;
//		private var _wireSystem : EntitySystem;

		/**
		 * GameContext 
		 * 
		 * @param container 
		 * 
		 */
		public function ChicksContext(gameContainer : GameContainer) {
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
			_gameConfigSystem = systemManager.setSystem(new GameConfigSystem(_gameContainer));
			_renderSystem = systemManager.setSystem(new RenderSystem(_gameContainer));
			_soundSystem = systemManager.setSystem(new SoundSystem(_gameContainer));
			_titlesSystem = systemManager.setSystem(new TitlesSystem(_gameContainer));
			_gameOverSystem = systemManager.setSystem(new GameOverSystem(_gameContainer));
//			_hudSystem = systemManager.setSystem(new HUDSystem(_gameContainer));
//			_nullSystem = systemManager.setSystem(new NullSystem(_gameContainer));
			_debugSystem = systemManager.setSystem(new DebugSystem(_gameContainer));
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_gameContainer));
			_physicsSystem = systemManager.setSystem(new PhysicsSystem(_gameContainer));
			_eggDropperSystem = systemManager.setSystem(new EggDropperSystem(_gameContainer));
//			_wireSystem = systemManager.setSystem(new WireSystem(_gameContainer));
			
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
//			EntityFactory.createDebug(_world);
			EntityFactory.createBg(_world);
			EntityFactory.createTitles(_world);
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
				case State.NEXT_LEVEL:
					_gameConfigSystem.process();
					break;
				case State.PLAY:
//					_nullSystem.process();
//					_hudSystem.process();
					_playerControlSystem.process();
					_physicsSystem.process();
					_eggDropperSystem.process();
//					_wireSystem.process();
					break;
				case State.GAME_ENDING:
					_gameConfigSystem.process();
					_physicsSystem.process();
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
