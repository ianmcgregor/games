package me.ianmcgregor.tenseconds.contexts {
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.tenseconds.constants.State;
	import me.ianmcgregor.tenseconds.factories.EntityFactory;
	import me.ianmcgregor.tenseconds.systems.BeamSystem;
	import me.ianmcgregor.tenseconds.systems.EnemySpawnSystem;
	import me.ianmcgregor.tenseconds.systems.EnemySystem;
	import me.ianmcgregor.tenseconds.systems.GameConfigSystem;
	import me.ianmcgregor.tenseconds.systems.GameOverSystem;
	import me.ianmcgregor.tenseconds.systems.PlayerControlSystem;
	import me.ianmcgregor.tenseconds.systems.TitlesSystem;

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
		private var _titlesSystem : EntitySystem;
		private var _gameOverSystem : EntitySystem;
//		private var _debugSystem : EntitySystem;
		private var _gameConfigSystem : EntitySystem;
		private var _playerControlSystem : EntitySystem;
		private var _beamSystem : EntitySystem;
		private var _enemySpawnSystem : EntitySystem;
		private var _enemySystem : EntitySystem;

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
			_titlesSystem = systemManager.setSystem(new TitlesSystem(_gameContainer));
			_gameOverSystem = systemManager.setSystem(new GameOverSystem(_gameContainer));
			_beamSystem = systemManager.setSystem(new BeamSystem(_gameContainer));
//			_debugSystem = systemManager.setSystem(new DebugSystem(_gameContainer));
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_gameContainer));
			_enemySpawnSystem = systemManager.setSystem(new EnemySpawnSystem(_gameContainer));
			_enemySystem = systemManager.setSystem(new EnemySystem(_gameContainer));
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
			
			Audio.play(music, 0.5, true);
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
				case State.PLAY:
					_playerControlSystem.process();
					_beamSystem.process();
					_enemySpawnSystem.process();
					_enemySystem.process();
					break;
				case State.TITLES:
					_titlesSystem.process();
					break;
				case State.GAME_START:
				case State.GAME_ENDING:
				case State.GAME_END:
				case State.NEXT_LEVEL:
				case State.PLAY_AGAIN:
					_gameConfigSystem.process();
					break;
				case State.GAME_OVER:
					_gameOverSystem.process();
					break;
				default:
			}
			_renderSystem.process();
//			_debugSystem.process();
		}

		/**
		 * world 
		 */
		public function get world() : World {
			return _world;
		}
	}
}
