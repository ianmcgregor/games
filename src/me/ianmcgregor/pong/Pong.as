package me.ianmcgregor.pong {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.BaseGame;
	import me.ianmcgregor.games.debug.ArtemisMonitor;
	import me.ianmcgregor.games.debug.DebugDisplay;
	import me.ianmcgregor.pong.components.CollisionRect;
	import me.ianmcgregor.pong.components.Enemy;
	import me.ianmcgregor.pong.components.Player;
	import me.ianmcgregor.pong.components.Velocity;
	import me.ianmcgregor.pong.constants.EntityGroup;
	import me.ianmcgregor.pong.constants.EntityTag;
	import me.ianmcgregor.pong.systems.BallMovementSystem;
	import me.ianmcgregor.pong.systems.BallRenderSystem;
	import me.ianmcgregor.pong.systems.CollisionSystem;
	import me.ianmcgregor.pong.systems.EnemyMovementSystem;
	import me.ianmcgregor.pong.systems.EnemyRenderSystem;
	import me.ianmcgregor.pong.systems.PlayerControlSystem;
	import me.ianmcgregor.pong.systems.PlayerRenderSystem;

	import starling.events.Event;

	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;



	/**
	 * @author McFamily
	 */
	
	[SWF(backgroundColor="#000000", frameRate="60", width="640", height="480")]
	
	/**
	 * Pong 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class Pong extends BaseGame {
		/**
		 * _world 
		 */
		private var _world : World;
		/**
		 * _debug 
		 */
		private var _debug : DebugDisplay;
		/**
		 * _playerControlSystem 
		 */
		private var _playerControlSystem : EntitySystem;
		/**
		 * _playerRenderSystem 
		 */
		private var _playerRenderSystem : EntitySystem;
		/**
		 * _enemyRenderSystem 
		 */
		private var _enemyRenderSystem : EntitySystem;
		/**
		 * _ballRenderSystem 
		 */
		private var _ballRenderSystem : EntitySystem;
		/**
		 * _ballMovementSystem 
		 */
		private var _ballMovementSystem : EntitySystem;
		/**
		 * _collisionSystem 
		 */
		private var _collisionSystem : EntitySystem;
		/**
		 * _enemyMovementSystem 
		 */
		private var _enemyMovementSystem : EntitySystem;
		
		/**
		 * Pong 
		 */
		public function Pong() {
			super();
		}
		
		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		override protected function onAddedToStage(event : Event) : void {
			super.onAddedToStage(event);
			
			_world = new World();
			
			/**
			 * _debug 
			 */
			
			addChild(_debug = new DebugDisplay());
			/**
			 * _artemisMonitor 
			 */
			var _artemisMonitor : ArtemisMonitor;
			_debug.addChild(_artemisMonitor = new ArtemisMonitor(_world));
			_artemisMonitor.gameContainer = _gameContainer;
			
			// init systems
			
			/**
			 * systemManager 
			 */
			var systemManager : SystemManager = _world.getSystemManager();
			
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_gameContainer));
			_playerRenderSystem = systemManager.setSystem(new PlayerRenderSystem(_gameContainer));
			_enemyRenderSystem = systemManager.setSystem(new EnemyRenderSystem(_gameContainer));
			_ballRenderSystem = systemManager.setSystem(new BallRenderSystem(_gameContainer));
			_ballMovementSystem = systemManager.setSystem(new BallMovementSystem(_gameContainer));
			_collisionSystem = systemManager.setSystem(new CollisionSystem());
			_enemyMovementSystem = systemManager.setSystem(new EnemyMovementSystem(_gameContainer));
			
			systemManager.initializeAll();
			
			// init entities
			
			/**
			 * e 
			 */
			var e : Entity;
			e = _world.createEntity();
			e.setTag(EntityTag.PLAYER);
			e.setGroup(EntityGroup.PLAYERS);
			e.addComponent(new TransformComponent(20, ( _gameContainer.getHeight() * 0.5 ) - 30 ));
			e.addComponent(new CollisionRect(0, 0, 20, 60));
			e.addComponent(new Player());
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.ENEMY);
			e.setGroup(EntityGroup.PLAYERS);
			e.addComponent(new TransformComponent(_gameContainer.getWidth() - 40, ( _gameContainer.getHeight() * 0.5 ) - 30 ));
			e.addComponent(new CollisionRect(0, 0, 20, 60));
			e.addComponent(new Enemy());
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.BALL);
			e.addComponent(new TransformComponent(100, 100));
			e.addComponent(new CollisionRect(0, 0, 20, 20));
			e.addComponent(new Velocity(2,2));
			e.refresh();
			
			start();
		}

		/**
		 * update 
		 * 
		 * @param delta 
		 * 
		 * @return 
		 */
		override protected function update(delta : Number) : void {
			_world.loopStart();

			_world.setDelta(delta);
			
			_debug.update();
			
			// process systems
			
			_collisionSystem.process();
			_ballMovementSystem.process();
			_playerControlSystem.process();
			_enemyMovementSystem.process();
			_playerRenderSystem.process();
			_enemyRenderSystem.process();
			_ballRenderSystem.process();
		}
	}
}
