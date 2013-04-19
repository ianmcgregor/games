package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.TitlesComponent;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameType;
	import me.ianmcgregor.racer.constants.State;

	import com.artemis.ComponentMapper;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public class TitlesSystem extends EntityProcessingSystem {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _menu 
		 */
		private var _menu : TitlesComponent;

		/**
		 * TitlesSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function TitlesSystem(container : GameContainer) {
			_container = container;
			super(TitlesComponent, []);
		}
		
		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			
			/**
			 * gameMapper 
			 */
			var gameMapper : ComponentMapper = new ComponentMapper(GameComponent, _world);
			_game = gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
			
			/**
			 * menuMapper 
			 */
			var menuMapper : ComponentMapper = new ComponentMapper(TitlesComponent, _world);
			_menu = menuMapper.get(_world.getTagManager().getEntity(EntityTag.MENU));

			/**
			 * Has a new game been selected?
			 */
			if(_game.type) {
				_container.state = _game.type == GameType.BUILDER ? State.BUILD : State.PLAY; 
			}
		}
	}
}
