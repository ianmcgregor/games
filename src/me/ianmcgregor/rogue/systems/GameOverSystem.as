package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.GameOverComponent;
	import me.ianmcgregor.rogue.constants.KeyConstants;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class GameOverSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _gameOverMapper : ComponentMapper;
		/**
		 * _gameOverComponent 
		 */
		private var _gameOverComponent : GameOverComponent;

		/**
		 * GameOverSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function GameOverSystem(g : GameContainer) {
			super(GameOverComponent, []);
			_g = g;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			/**
			 * _titlesMapper 
			 */
			_gameOverMapper = new ComponentMapper(GameOverComponent, _world);
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			_gameOverComponent = _gameOverMapper.get(e);

			if (_g.getInput().justPressed(KeyConstants.PLAY_AGAIN)) {
				_g.getInput().setKeyUp(KeyConstants.PLAY_AGAIN);
				_world.deleteEntity(e);
				_g.state = State.TITLES;
				EntityFactory.createTitles(_world);
			}
		}
	}
}
