package me.ianmcgregor.games.debug {
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.EntityManager;
	import com.artemis.World;


	/**
	 * ArtemisMonitor 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class ArtemisMonitor extends AbstractDebugPanel implements IUpdateable {
		private const TITLE : String = "ENTITIES:";
		/**
		 * _world 
		 */
		private var _world : World;
		/**
		 * _entityManager 
		 */
		private var _entityManager : EntityManager;
		/**
		 * gameContainer 
		 */
		public var gameContainer : GameContainer;

		/**
		 * ArtemisMonitor 
		 * 
		 * @param world 
		 * 
		 * @return 
		 */
		public function ArtemisMonitor(world : World, gameContainer: GameContainer = null) {
			super(TITLE);
			this.world = world;
			this.gameContainer = gameContainer;
		}

		/**
		 * update 
		 * 
		 * @return 
		 */
		public function update() : void {
			if(!_entityManager) return;
			text = getInfo();
		}
		
		/**
		 * getInfo 
		 * 
		 * @return 
		 */
		private function getInfo() : String {
			/**
			 * info 
			 */
			var info : String = "";
			info += TITLE + "\n";
			info += "COUNT: " + _entityManager.getEntityCount() + "\n";
			info += "CREATED: " + _entityManager.getTotalCreated() + "\n";
			info += "REMOVED: " + _entityManager.getTotalRemoved() + "\n";
			info += "DELTA: " + int(_world.getDelta() * 1000) + "ms" + "\n\n";
			if(gameContainer) info += "STATE:\n" + gameContainer.state;
			return info;
		}

		/**
		 * set world
		 * 
		 * @param world
		 */
		public function set world(world : World) : void {
			_world = world;
			if(_world) {
				_entityManager = _world.getEntityManager();
			} else {
				_entityManager = null;
			}
		}
	}
}