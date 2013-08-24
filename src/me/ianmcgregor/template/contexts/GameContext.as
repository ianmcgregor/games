package me.ianmcgregor.template.contexts {
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.template.constants.State;
	import me.ianmcgregor.template.factories.EntityFactory;
	import me.ianmcgregor.template.systems.DebugSystem;
	import me.ianmcgregor.template.systems.GameConfigSystem;
	import me.ianmcgregor.template.systems.GameOverSystem;
	import me.ianmcgregor.template.systems.HUDSystem;
	import me.ianmcgregor.template.systems.NullSystem;
	import me.ianmcgregor.template.systems.PlayerControlSystem;
	import me.ianmcgregor.template.systems.SoundSystem;
	import me.ianmcgregor.template.systems.TitlesSystem;

	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class GameContext implements IContext {
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
		private var _hudSystem : EntitySystem;
		private var _nullSystem : EntitySystem;
		private var _debugSystem : EntitySystem;
		private var _gameConfigSystem : EntitySystem;
		private var _playerControlSystem : EntitySystem;

		/**
		 * GameContext 
		 * 
		 * @param container 
		 * 
		 */
		public function GameContext(gameContainer : GameContainer) {
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
			_hudSystem = systemManager.setSystem(new HUDSystem(_gameContainer));
			_nullSystem = systemManager.setSystem(new NullSystem(_gameContainer));
			_debugSystem = systemManager.setSystem(new DebugSystem(_gameContainer));
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_gameContainer));
			
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
			EntityFactory.createDebug(_world);
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
					_nullSystem.process();
					_hudSystem.process();
					_playerControlSystem.process();
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
