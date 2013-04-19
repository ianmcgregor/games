package me.ianmcgregor.template.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.input.controls.Dpad;
	import me.ianmcgregor.games.input.controls.KeyButton;
	import me.ianmcgregor.rogue.components.GameConfigComponent;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.constants.KeyConstants;

	import starling.events.Event;
	import starling.events.KeyboardEvent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public final class ControlsSpatial extends Spatial {
		/**
		 * _playerOne 
		 */
		private var _playerOneButton : KeyButton;
		private var _playerOneDpad : Dpad;
		/**
		 * _playerTwo 
		 */
		private var _playerTwoButton : KeyButton;
		private var _playerTwoDpad : Dpad;
		/**
		 * _gameConfig 
		 */
		private var _gameConfig : GameConfigComponent;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		
		/**
		 * ControlsSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function ControlsSpatial(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g : GameContainer) : void {
			/**
			 * _input
			 */
			_input = g.getInput();
			/**
			 * gameConfigMapper 
			 */
			var gameConfigMapper : ComponentMapper = new ComponentMapper(GameConfigComponent, _world);
			_gameConfig = gameConfigMapper.get(_world.getTagManager().getEntity(EntityTag.GAME_CONFIG));
			
			/**
			 * buttons 
			 */
			g.addChild(_playerOneButton = new KeyButton(KeyConstants.SHOOT_P1, g.assets.getTexture("btn_1_up"), g.assets.getTexture("btn_1_down")));
			_playerOneButton.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_playerOneButton.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			g.addChild(_playerTwoButton = new KeyButton(KeyConstants.SHOOT_P1, g.assets.getTexture("btn_2_up"), g.assets.getTexture("btn_2_down")));
			_playerTwoButton.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_playerTwoButton.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			/**
			 * Dpads 
			 */
			g.addChild(_playerOneDpad = new Dpad(KeyConstants.UP_P1, KeyConstants.DOWN_P1, KeyConstants.LEFT_P1, KeyConstants.RIGHT_P1, true, g.assets.getTexture("dpad_184"), 0xFF3333));
			_playerOneDpad.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_playerOneDpad.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			g.addChild(_playerTwoDpad = new Dpad(KeyConstants.UP_P2, KeyConstants.DOWN_P2, KeyConstants.LEFT_P2, KeyConstants.RIGHT_P2, true, g.assets.getTexture("dpad2"), 0x3366FF, 2));
			_playerTwoDpad.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_playerTwoDpad.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			/**
			 * players
			 */
			_playerTwoButton.visible = _playerTwoDpad.visible = _gameConfig.numPlayers > 1;
			
			/**
			 * layout
			 */
			var margin: Number = 30;
					
			_playerOneDpad.x = margin;
			_playerOneDpad.y = g.getHeight() - _playerOneDpad.height - margin;
			
			_playerOneButton.x = _playerOneDpad.x + _playerOneDpad.width + margin;;
			_playerOneButton.y = g.getHeight() - _playerOneButton.height - margin;
			
			_playerTwoDpad.x = g.getWidth() - _playerTwoDpad.width - margin;
			_playerTwoDpad.y = _playerOneDpad.y;
			
			_playerTwoButton.x = _playerTwoDpad.x - _playerTwoButton.width - margin;
			_playerTwoButton.y = _playerOneButton.y;
		}

		/**
		 * onKeyDown 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onKeyDown(event : Event) : void {
			_input.setKeyDown(event.data as uint);
		}

		/**
		 * onKeyUp 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onKeyUp(event : Event) : void {
			_input.setKeyUp(event.data as uint);
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			g;
			
			_playerOneButton.setDown(_input.isDown(_playerOneButton.keyCode));			
			_playerTwoButton.setDown(_input.isDown(_playerTwoButton.keyCode));			
		}
		
		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
		}
	}
}
