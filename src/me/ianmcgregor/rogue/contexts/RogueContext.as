package me.ianmcgregor.rogue.contexts {
	import me.ianmcgregor.games.artemis.systems.ExpirationSystem;
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.factories.EntityFactory;
	import me.ianmcgregor.rogue.systems.BatMovementSystem;
	import me.ianmcgregor.rogue.systems.BulletCollisionSystem;
	import me.ianmcgregor.rogue.systems.CollisionSystem;
	import me.ianmcgregor.rogue.systems.DebugSystem;
	import me.ianmcgregor.rogue.systems.GameConfigSystem;
	import me.ianmcgregor.rogue.systems.GameOverSystem;
	import me.ianmcgregor.rogue.systems.HUDSystem;
	import me.ianmcgregor.rogue.systems.ItemsCollisionSystem;
	import me.ianmcgregor.rogue.systems.MessageSystem;
	import me.ianmcgregor.rogue.systems.MonsterAISystem;
	import me.ianmcgregor.rogue.systems.MonsterSystem;
	import me.ianmcgregor.rogue.systems.MoveableSystem;
	import me.ianmcgregor.rogue.systems.NullSystem;
	import me.ianmcgregor.rogue.systems.PlayerControlSystem;
	import me.ianmcgregor.rogue.systems.PlayerHealthSystem;
	import me.ianmcgregor.rogue.systems.SoundSystem;
	import me.ianmcgregor.rogue.systems.TileSystem;
	import me.ianmcgregor.rogue.systems.TitlesSystem;
	import me.ianmcgregor.rogue.systems.WeaponCollisionSystem;

	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class RogueContext implements IContext {
		/**
		 * _container 
		 */
		private var _g : GameContainer;
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
		private var _collisionSystem : EntitySystem;
		private var _monsterSystem : EntitySystem;
		private var _tileSystem : EntitySystem;
		private var _itemsCollisionSystem : EntitySystem;
		private var _monsterAISystem : EntitySystem;
		private var _weaponCollisionSystem : EntitySystem;
		private var _expirationSystem : EntitySystem;
		private var _bulletCollisionSystem : EntitySystem;
		private var _playerHealthSystem : EntitySystem;
		private var _messageSystem : EntitySystem;
		private var _batMovementSystem : EntitySystem;
		private var _moveableSystem : EntitySystem;
		

		/**
		 * GameContext 
		 * 
		 * @param container 
		 * 
		 */
		public function RogueContext(gameContainer : GameContainer) {
			super();
			_g = gameContainer;
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
			_gameConfigSystem = systemManager.setSystem(new GameConfigSystem(_g));
			_renderSystem = systemManager.setSystem(new RenderSystem(_g));
			_soundSystem = systemManager.setSystem(new SoundSystem(_g));
			_titlesSystem = systemManager.setSystem(new TitlesSystem(_g));
			_gameOverSystem = systemManager.setSystem(new GameOverSystem(_g));
			_hudSystem = systemManager.setSystem(new HUDSystem(_g));
			_nullSystem = systemManager.setSystem(new NullSystem(_g));
			_debugSystem = systemManager.setSystem(new DebugSystem(_g));
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_g));
			_collisionSystem = systemManager.setSystem(new CollisionSystem(_g));
			_monsterSystem = systemManager.setSystem(new MonsterSystem(_g));
			_tileSystem = systemManager.setSystem(new TileSystem(_g));
			_itemsCollisionSystem = systemManager.setSystem(new ItemsCollisionSystem(_g));
			_monsterAISystem = systemManager.setSystem(new MonsterAISystem(_g));
			_weaponCollisionSystem = systemManager.setSystem(new WeaponCollisionSystem(_g));
			_expirationSystem = systemManager.setSystem(new ExpirationSystem());
			_bulletCollisionSystem = systemManager.setSystem(new BulletCollisionSystem(_g));
			_playerHealthSystem = systemManager.setSystem(new PlayerHealthSystem(_g));
			_messageSystem = systemManager.setSystem(new MessageSystem(_g));
			_batMovementSystem = systemManager.setSystem(new BatMovementSystem(_g));
			_moveableSystem = systemManager.setSystem(new MoveableSystem());
			
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
			
			switch(_g.state){
				case State.TITLES:
					_titlesSystem.process();
					break;
				case State.GAME_START:
				case State.NEXT_LEVEL:
				case State.PREV_LEVEL:
				case State.INIT_LEVEL:
				case State.GAME_END:
					_gameConfigSystem.process();
					break;
				case State.PLAY:
					_nullSystem.process();
					_hudSystem.process();
					_playerControlSystem.process();
					_monsterAISystem.process();
					_monsterSystem.process();
					_moveableSystem.process();
					_itemsCollisionSystem.process();
					_collisionSystem.process();
					_tileSystem.process();
					_weaponCollisionSystem.process();
					_expirationSystem.process();
					_bulletCollisionSystem.process();
					_playerHealthSystem.process();
					_messageSystem.process();
					_batMovementSystem.process();
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
