package me.ianmcgregor.species.contexts {
	import me.ianmcgregor.games.artemis.systems.ExpirationSystem;
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.species.Species;
	import me.ianmcgregor.species.components.Hero;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.constants.StateConstants;
	import me.ianmcgregor.species.factories.EntityFactory;
	import me.ianmcgregor.species.systems.BulletCollisionSystem;
	import me.ianmcgregor.species.systems.CollisionSystem;
	import me.ianmcgregor.species.systems.EnemyMovementSystem;
	import me.ianmcgregor.species.systems.EnemyShipSystem;
	import me.ianmcgregor.species.systems.EnemyShooterSystem;
	import me.ianmcgregor.species.systems.HealthBarRenderSystem;
	import me.ianmcgregor.species.systems.LevelInitializeSystem;
	import me.ianmcgregor.species.systems.MovementSystem;
	import me.ianmcgregor.species.systems.PlayerControlSystem;

	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public class PlayContext implements IContext {
		/**
		 * _world 
		 */
		private var _world : World;
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _main 
		 */
		private var _main : Species;
		/**
		 * _playerControlSystem 
		 */
		private var _playerControlSystem : EntitySystem;
		/**
		 * _collisionSystem 
		 */
		private var _collisionSystem : EntitySystem;
		/**
		 * _enemyMovementSystem 
		 */
		private var _enemyMovementSystem : EntitySystem;
		/**
		 * _renderSystem 
		 */
		private var _renderSystem : EntitySystem;
		/**
		 * _expirationSystem 
		 */
		private var _expirationSystem : EntitySystem;
//		private var _enemySpawnSystem : EntitySystem;
		/**
		 * _movementSystem 
		 */
		private var _movementSystem : EntitySystem;
		/**
		 * _bulletCollisionSystem 
		 */
		private var _bulletCollisionSystem : EntitySystem;
		/**
		 * _healthBarRenderSystem 
		 */
		private var _healthBarRenderSystem : EntitySystem;
		/**
		 * _enemyShooterSystem 
		 */
		private var _enemyShooterSystem : EntitySystem;
		/**
		 * _levelInitializeSystem 
		 */
		private var _levelInitializeSystem : EntitySystem;
		/**
		 * _enemyShipSystem 
		 */
		private var _enemyShipSystem : EntitySystem;

		/**
		 * PlayState 
		 * 
		 * @param container 
		 * @param main 
		 * 
		 * @return 
		 */
		public function PlayContext(container : GameContainer, main : Species) {
			super();
			_container = container;
			_main = main;
		}
		
		/**
		 * init 
		 * 
		 * @return 
		 */
		public function init() : void {
			if(_world){
				reset();
				return;
			}
			
			_world = new World();
			
			// init systems
			
			/**
			 * systemManager 
			 */
			var systemManager : SystemManager = _world.getSystemManager();
			
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_container));
			_collisionSystem = systemManager.setSystem(new CollisionSystem());
			_enemyMovementSystem = systemManager.setSystem(new EnemyMovementSystem(_container));
			_renderSystem = systemManager.setSystem(new RenderSystem(_container));
			_expirationSystem = systemManager.setSystem(new ExpirationSystem());
//			_enemySpawnSystem = systemManager.setSystem(new EnemySpawnSystem(2, _container));
			_movementSystem = systemManager.setSystem(new MovementSystem(_container));
			_bulletCollisionSystem = systemManager.setSystem(new BulletCollisionSystem());
			_healthBarRenderSystem = systemManager.setSystem(new HealthBarRenderSystem());
			_enemyShooterSystem = systemManager.setSystem(new EnemyShooterSystem());
			_levelInitializeSystem = systemManager.setSystem(new LevelInitializeSystem());
			_enemyShipSystem = systemManager.setSystem(new EnemyShipSystem(_container));
			
			systemManager.initializeAll();
			
			// init entities
			
			EntityFactory.createLevel(_world, 1);
			EntityFactory.createHero(_world);
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
			
			// check for game over
			
			/**
			 * hero 
			 */
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			if(!hero) {
				_main.changeState(StateConstants.GAME_OVER);
				return;
			} else {
				var heroComponent: Hero = Hero(hero.getComponent(Hero));
				if(heroComponent.won){
					_main.changeState(StateConstants.WON);
					return;
				}
			}
			
			// process systems
			_levelInitializeSystem.process();
			_collisionSystem.process();
			_playerControlSystem.process();
			_enemyMovementSystem.process();
			_expirationSystem.process();
//			_enemySpawnSystem.process();
			_movementSystem.process();
			_bulletCollisionSystem.process();
			_healthBarRenderSystem.process();
			_enemyShooterSystem.process();
			_enemyShipSystem.process();
			
			// render
			
			_renderSystem.process();
		}
		
		/**
		 * reset 
		 * 
		 * @return 
		 */
		private function reset() : void {
		}

		/**
		 * world 
		 */
		public function get world() : World {
			return _world;
		}

	}
}
