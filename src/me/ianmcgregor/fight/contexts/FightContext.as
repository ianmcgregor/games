package me.ianmcgregor.fight.contexts {
	import me.ianmcgregor.fight.constants.State;
	import me.ianmcgregor.fight.factories.EntityFactory;
	import me.ianmcgregor.fight.systems.BadGuyAISystem;
	import me.ianmcgregor.fight.systems.DebugSystem;
	import me.ianmcgregor.fight.systems.GameConfigSystem;
	import me.ianmcgregor.fight.systems.GameOverSystem;
	import me.ianmcgregor.fight.systems.HUDSystem;
	import me.ianmcgregor.fight.systems.PhysicsSystem;
	import me.ianmcgregor.fight.systems.PlayerControlSystem;
	import me.ianmcgregor.fight.systems.SoundSystem;
	import me.ianmcgregor.fight.systems.TitlesSystem;
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;

	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class FightContext implements IContext {
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
		private var _debugSystem : EntitySystem;
		private var _gameConfigSystem : EntitySystem;
		private var _playerControlSystem : EntitySystem;
		private var _physicsSystem : EntitySystem;
		private var _badGuyAISystem : EntitySystem;

		/**
		 * GameContext 
		 * 
		 * @param container 
		 * 
		 */
		public function FightContext(gameContainer : GameContainer) {
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
			_debugSystem = systemManager.setSystem(new DebugSystem(_gameContainer));
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_gameContainer));
			_physicsSystem = systemManager.setSystem(new PhysicsSystem(_gameContainer));
			_badGuyAISystem = systemManager.setSystem(new BadGuyAISystem(_gameContainer));
			
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
					_hudSystem.process();
					_playerControlSystem.process();
					_physicsSystem.process();
					_badGuyAISystem.process();
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
