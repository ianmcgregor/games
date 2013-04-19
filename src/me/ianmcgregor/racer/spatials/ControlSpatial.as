package me.ianmcgregor.racer.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.constants.Constants;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameType;
	import me.ianmcgregor.racer.constants.State;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public final class ControlSpatial extends Spatial {
		/**
		 * _playerOneButton 
		 */
		private var _playerOneButton : Button;
		/**
		 * _playerTwoButton 
		 */
		private var _playerTwoButton : Button;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * _buttonOneUp 
		 */
		private var _buttonOneUp : Texture;
		/**
		 * _buttonTwoUp 
		 */
		private var _buttonTwoUp : Texture;
		
		/**
		 * ControlSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function ControlSpatial(world : World, owner : Entity) {
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
			 * gameMapper 
			 */
			var gameMapper : ComponentMapper = new ComponentMapper(GameComponent, _world);
			_game = gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
			
			/**
			 * textureAtlas 
			 */
			var textureAtlas: TextureAtlas = g.assets.getTextureAtlas("tiles");

			_buttonOneUp = textureAtlas.getTexture("24_button1_up");
			_playerOneButton = new Button(_buttonOneUp, "", textureAtlas.getTexture("25_button1_down"));
			
			_playerOneButton.addEventListener(TouchEvent.TOUCH, onTouch);
			
			_buttonTwoUp = textureAtlas.getTexture("26_button2_up");
			_playerTwoButton = new Button(_buttonTwoUp, "", textureAtlas.getTexture("27_button2_down"));
			_playerTwoButton.addEventListener(TouchEvent.TOUCH, onTouch);
			
			_playerTwoButton.visible = _game.type == GameType.TWO_PLAYER;
		}

		/**
		 * onTouch 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTouch(event : TouchEvent) : void {
			/**
			 * touch 
			 */
			var touch: Touch = event.getTouch(event.currentTarget as DisplayObject);
			if(!touch) return;

			/**
			 * key 
			 */
			var key: uint = event.currentTarget == _playerOneButton ? Constants.KEY_PLAYER_ONE : Constants.KEY_PLAYER_TWO;
			switch(touch.phase){
				case TouchPhase.BEGAN:
					_input.setKeyDown(key);
					break;
				case TouchPhase.ENDED:
					_input.setKeyUp(key);
					break;
				default:
			}
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if(g.state != State.PLAY) {
				if (g.contains(_playerOneButton)) {
					g.removeChild(_playerOneButton);
				}
				if (g.contains(_playerTwoButton)) {
					g.removeChild(_playerTwoButton);
				}
				return;
			}
			if(g.state == State.PLAY) {
				if(!g.contains(_playerOneButton)) {
					_input = g.getInput();
					
					g.addChild(_playerOneButton);
					g.addChild(_playerTwoButton);
					
					
					switch(_game.type){
						case GameType.ONE_PLAYER:
							_playerOneButton.visible = true;
							_playerTwoButton.visible = false;
							break;
						case GameType.TWO_PLAYER:
							_playerOneButton.visible = true;
							_playerTwoButton.visible = true;
							break;
						case GameType.DEMO:
							_playerOneButton.visible = false;
							_playerTwoButton.visible = false;
							break;
						default:
					}
					
					/**
					 * margin 
					 */
					var margin: Number = 60;
					
					_playerOneButton.x = margin;
					_playerOneButton.y = g.getHeight() - _playerOneButton.height - margin;
					
					_playerTwoButton.x = g.getWidth() - _playerTwoButton.width - margin;
					_playerTwoButton.y = _playerOneButton.y;
				}
				
				if(_input.isDown(Constants.KEY_PLAYER_ONE)) {
					_playerOneButton.upState = _playerOneButton.downState;
				} else {
					_playerOneButton.upState = _buttonOneUp;
				}
				if(_input.isDown(Constants.KEY_PLAYER_TWO)) {
					_playerTwoButton.upState = _playerTwoButton.downState;
				} else {
					_playerTwoButton.upState = _buttonTwoUp;
				}
			}
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
