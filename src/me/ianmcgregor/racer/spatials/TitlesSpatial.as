package me.ianmcgregor.racer.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.LayoutUtils;
	import me.ianmcgregor.racer.assets.Assets;
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.components.CarModel;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.TitlesComponent;
	import me.ianmcgregor.racer.constants.Cars;
	import me.ianmcgregor.racer.constants.Constants;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameType;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.spatials.gfx.ChooseCar;
	import me.ianmcgregor.racer.spatials.gfx.RacerButton;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import flash.display.Bitmap;
	import flash.ui.Keyboard;

	/**
	 * @author ianmcgregor
	 */
	public class TitlesSpatial extends Spatial {
		private static const BTN_TRACKBUILDER : String = "TRACK BUILDER";
		private const BTN_1_PLAYER : String = "1 PLAYER";
		private const BTN_2_PLAYER : String = "2 PLAYER";

		/**
		 * _container 
		 */
		private var _container : Sprite;
		/**
		 * _menu 
		 */
		private var _menu : Sprite;
		/**
		 * _title 
		 */
		private var _title : TextField;
		/**
		 * _buttons 
		 */
		private var _buttons : Sprite;
		/**
		 * _playOnePlayer 
		 */
		private var _playOnePlayer : RacerButton;
		/**
		 * _playTwoPlayer 
		 */
		private var _playTwoPlayer : RacerButton;
		/**
		 * _choosePlayerOneCar 
		 */
		private var _chooseCarOne : ChooseCar;
		/**
		 * _choosePlayerTwoCar 
		 */
		private var _chooseCarTwo : ChooseCar;
		/**
		 * _trackBuilder 
		 */
		private var _trackBuilder : RacerButton;
		/**
		 * _carModels 
		 */
		private var _carModels : Vector.<CarModel>;
		/**
		 * _playerOneCar 
		 */
		private var _pOneCar: uint;
		/**
		 * _playerTwoCar 
		 */
		private var _pTwoCar : uint;
		/**
		 * _carOne 
		 */
		private var _carOne : Image;
		/**
		 * _carTwo 
		 */
		private var _carTwo : Image;
		/**
		 * _oneGameLogo 
		 */
		private var _oneGameLogo : Image;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _menuComponent 
		 */
		private var _menuComponent : TitlesComponent;
		
		
		/**
		 * TitlesSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function TitlesSpatial(world : World, owner : Entity) {
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
			trace("TitlesSpatial.initalize(",g,")");
			/**
			 * gameMapper 
			 */
			var gameMapper : ComponentMapper = new ComponentMapper(GameComponent, _world);
			_game = gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
			
			/**
			 * menuMapper 
			 */
			var menuMapper : ComponentMapper = new ComponentMapper(TitlesComponent, _world);
			_menuComponent = menuMapper.get(_world.getTagManager().getEntity(EntityTag.MENU));
			
			
			_container = new Sprite();
			
			_carModels = Cars.carModels;
			_pOneCar = 0;
			_pTwoCar = 1;
			
			_container.addChild(_menu = new Sprite());
			_menu.addChild( _title = new TextField(100, 20, "ULTRA RACER", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFF00, true) );
			_title.scaleX = _title.scaleY = 13;
			
			_menu.addChild(_buttons = new Sprite());
			
			// buttons to choose car type
			var _carTextures : TextureAtlas = g.assets.getTextureAtlas("cars");
			
			_buttons.addChild(_carOne = new Image( _carTextures.getTexture("car1_big")));
			_buttons.addChild(_carTwo = new Image( _carTextures.getTexture("car2_big")));
			
			_buttons.addChild(_chooseCarOne = new ChooseCar(_carTextures, _carModels[_pOneCar]));
			_chooseCarOne.addEventListener(Event.TRIGGERED, onCarButtonTriggered);
			
			_buttons.addChild(_chooseCarTwo = new ChooseCar(_carTextures, _carModels[_pTwoCar]));
			_chooseCarTwo.addEventListener(Event.TRIGGERED, onCarButtonTriggered);
			
			// buttons to start game
			
			_buttons.addChild(_playOnePlayer = new RacerButton(BTN_1_PLAYER));
			_playOnePlayer.addEventListener(Event.TRIGGERED, onPlayButtonTriggered);
			
			_buttons.addChild(_playTwoPlayer = new RacerButton(BTN_2_PLAYER));
			_playTwoPlayer.addEventListener(Event.TRIGGERED, onPlayButtonTriggered);

			_buttons.addChild(_trackBuilder = new RacerButton(BTN_TRACKBUILDER));
			_trackBuilder.addEventListener(Event.TRIGGERED, onPlayButtonTriggered);
			_trackBuilder.visible = false;
			
			_menu.addChild(_oneGameLogo = new Image(Texture.fromBitmap(new Assets.OneGameLogo as Bitmap)));
			
			// layout
			
			//_choosePlayerOneCar.visible = _choosePlayerTwoCar.visible = false;
			
			
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if (g.state == State.TITLES && !g.contains(_container)) {
				g.addChild(_container);
				
				/**
				 * w 
				 */
				var w : Number = g.getWidth();
//				var hw : Number = w * 0.5;
				_title.x = ( w - _title.width ) * 0.5;
				_title.y = 100;
				
				_carOne.x = 340;
				_carTwo.x = 500;
				_carOne.y = _carTwo.y = -100;
				
				_chooseCarOne.y = 160;
				_chooseCarTwo.y = _chooseCarOne.y;
				
				_playOnePlayer.x = 0;
				_playTwoPlayer.x = 380;
				_playOnePlayer.y = _chooseCarOne.y + 60;
				_playTwoPlayer.y = _playOnePlayer.y;
				
				LayoutUtils.positionCenterHorizontal(_chooseCarOne, _playOnePlayer.width, _playOnePlayer.x);
				LayoutUtils.positionCenterHorizontal(_chooseCarTwo, _playTwoPlayer.width, _playTwoPlayer.x);
				
				
				_trackBuilder.x = 110;
				_trackBuilder.y = _playOnePlayer.y + 120;
//				_trackBuilder.visible = false;
				
				_buttons.x = ( w - _buttons.width ) * 0.5;
				_buttons.y = 150;
				
				_oneGameLogo.x = (w - _oneGameLogo.width ) * 0.5;
				_oneGameLogo.y = 520;
			}
		}
		
		/**
		 * onPlayButtonTriggered 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onPlayButtonTriggered(event : Event) : void {
			/**
			 * btn 
			 */
			var btn: RacerButton = event.target as RacerButton;
			switch(btn){
				case _playOnePlayer:
					startGame(GameType.ONE_PLAYER);
					break;
				case _playTwoPlayer:
					startGame(GameType.TWO_PLAYER);
					break;
				case _trackBuilder:
					startTrackBuilder();//GameType.TRACK_BUILDER;
					break;
				default:
			}
		}

		/**
		 * startTrackBuilder 
		 * 
		 * @return 
		 */
		private function startTrackBuilder() : void {
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			_container.parent.removeChild(_container);
			_game.type = GameType.BUILDER;
		}
		
		/**
		 * onCarButtonTriggered 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onCarButtonTriggered(event : Event) : void {
			/**
			 * btn 
			 */
			var btn: ChooseCar = event.target as ChooseCar;
			switch(btn){
				case _chooseCarOne:
					selectCarOne();
					break;
				case _chooseCarTwo:
					selectCarTwo();
					break;
				default:
			}
		}

		private function selectCarOne() : void {
			_pOneCar++;
			if (_pOneCar > _carModels.length - 1) _pOneCar = 0;
			_chooseCarOne.choose(_carModels[_pOneCar]);
		}

		private function selectCarTwo() : void {
			_pTwoCar++;
			if (_pTwoCar > _carModels.length - 1) _pTwoCar = 0;
			_chooseCarTwo.choose(_carModels[_pTwoCar]);
		}
		
		/**
		 * onKey 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onKey(event : KeyboardEvent) : void {
			switch(event.keyCode) {
				
				case Keyboard.NUMBER_1:
					startGame(GameType.ONE_PLAYER);
					break;
					
				case Keyboard.NUMBER_2:
					startGame(GameType.TWO_PLAYER);
					break;
					
				case Keyboard.NUMBER_3:
					startGame(GameType.DEMO);
					break;

				case Keyboard.NUMBER_4:
					startTrackBuilder();
					break;
					
				case Constants.KEY_PLAYER_ONE:
					selectCarOne();
					break;
					
				case Constants.KEY_PLAYER_TWO:
					selectCarTwo();
					break;

				default:
			}
		}

		/**
		 * startGame 
		 * 
		 * @param gameType 
		 * 
		 * @return 
		 */
		private function startGame(gameType : String) : void {
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			_container.parent.removeChild(_container);
			/**
			 * carMapper 
			 */
			var carMapper: ComponentMapper = new ComponentMapper(CarComponent, _world);
			/**
			 * carOne 
			 */
			var carOne: CarComponent = carMapper.get(_world.getTagManager().getEntity(EntityTag.CAR_ONE));
			carOne.init(_carModels[_pOneCar]);
			/**
			 * carTwo 
			 */
			var carTwo: CarComponent = carMapper.get(_world.getTagManager().getEntity(EntityTag.CAR_TWO));
			carTwo.init(_carModels[_pTwoCar]);
			/**
			 * gameType
			 */
			_game.type = gameType;
		}
	}
}
