package me.ianmcgregor.chicks.systems {
	import me.ianmcgregor.chicks.components.GameConfigComponent;
	import me.ianmcgregor.chicks.components.TitlesComponent;
	import me.ianmcgregor.chicks.constants.EntityTag;
	import me.ianmcgregor.chicks.constants.KeyConstants;
	import me.ianmcgregor.chicks.constants.State;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class TitlesSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _titlesMapper : ComponentMapper;
		private var _gameConfigMapper : ComponentMapper;
		/**
		 * components 
		 */
		private var _titlesComponent : TitlesComponent;

		/**
		 * TitlesSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function TitlesSystem(g : GameContainer) {
			super(TitlesComponent, []);
			_g = g;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_titlesMapper = new ComponentMapper(TitlesComponent, _world);
			_gameConfigMapper = new ComponentMapper(GameConfigComponent, _world);
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
			_titlesComponent = _titlesMapper.get(e);

			if (_g.getInput().isDown(KeyConstants.ONE_PLAYER)) {
				_g.getInput().setKeyUp(KeyConstants.ONE_PLAYER);
				_world.deleteEntity(e);
				startGame(1);
			}
			
			if (_g.getInput().isDown(KeyConstants.TWO_PLAYER)) {
				_g.getInput().setKeyUp(KeyConstants.TWO_PLAYER);
				_world.deleteEntity(e);
				startGame(2);
			}
		}
		
		/**
		 * startGame
		 * 
		 * @param numPlayers
		 * 
		 * @return
		 */
		private function startGame(numPlayers: int): void {
			var gameConfig: GameConfigComponent = _gameConfigMapper.get(_world.getTagManager().getEntity(EntityTag.GAME_CONFIG));
			gameConfig.numPlayers = numPlayers;
			_g.state = State.GAME_START;
		}
	}
}
