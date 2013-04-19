package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.components.GameConfigComponent;
	import me.ianmcgregor.nanotech.components.TitlesComponent;
	import me.ianmcgregor.nanotech.constants.EntityTag;
	import me.ianmcgregor.nanotech.constants.State;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.ui.Keyboard;

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

			if (_g.getInput().isDown(Keyboard.NUMBER_1)) {
				_g.getInput().setKeyUp(Keyboard.NUMBER_1);
				_world.deleteEntity(e);
				startGame(1);
			}
			
			if (_g.getInput().isDown(Keyboard.NUMBER_2)) {
				_g.getInput().setKeyUp(Keyboard.NUMBER_2);
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
