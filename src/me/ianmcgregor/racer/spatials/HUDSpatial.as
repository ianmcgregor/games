package me.ianmcgregor.racer.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.ui.QuickText;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.HUDComponent;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameState;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.spatials.gfx.RacerButton;
	import me.ianmcgregor.racer.spatials.gfx.RacerText;
	import me.ianmcgregor.racer.spatials.gfx.StartLightsGfx;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.VAlign;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSpatial extends Spatial {
		/**
		 * _carOne 
		 */
		private var _carOne : QuickText;
		/**
		 * _carTwo 
		 */
		private var _carTwo : QuickText;
		/**
		 * _info 
		 */
		private var _info : QuickText;
		/**
		 * _debug 
		 */
		private var _debug : QuickText;
		/**
		 * _hud 
		 */
		private var _hud : HUDComponent;
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _nextTrackButton 
		 */
		private var _nextTrackButton : Button;
		/**
		 * _startLights 
		 */
		private var _startLights : StartLightsGfx;
		/**
		 * _trackInfo 
		 */
		private var _trackInfo : RacerText;
		/**
		 * _playAgainButton 
		 */
		private var _playAgainButton : RacerButton;
		/**
		 * _gameContainer 
		 */
		private var _gameContainer : GameContainer;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		/**
		 * _counter 
		 */
		private var _counter : int;

		/*
		 * TODO: separate GFX for game info
		 */
		public function HUDSpatial(world : World, owner : Entity) {
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
			g;
			_gfx = new Sprite();
			
			_carOne = new QuickText(60, 50, "", 2);
			_carTwo = new QuickText(60, 50, "", 2);
			_info = new QuickText(120, 60, "", 4, 0x000000, 0xFFFF00);
			_info.textField.vAlign = VAlign.TOP;
			_debug = new QuickText(100, 100);
			_trackInfo = new RacerText("");
			_trackInfo.width = 600;
			
			_debug.visible = false;
			
			_nextTrackButton = new RacerButton("NEXT TRACK");
			_nextTrackButton.addEventListener(Event.TRIGGERED, onNextTrack);

			_playAgainButton = new RacerButton("PLAY AGAIN");
			_playAgainButton.addEventListener(Event.TRIGGERED, onPlayAgain);
			
			_startLights = new StartLightsGfx();

			/**
			 * hudMapper 
			 */
			var hudMapper : ComponentMapper = new ComponentMapper(HUDComponent, _world);
			_hud = hudMapper.get(_owner);

			/**
			 * gameMapper 
			 */
			var gameMapper : ComponentMapper = new ComponentMapper(GameComponent, _world);
			_game = gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));

			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);
			
			_gfx.addChild(_carOne);
			_gfx.addChild(_info);
			_gfx.addChild(_debug);
			_gfx.addChild(_carTwo);
			_gfx.addChild(_nextTrackButton);
			_gfx.addChild(_playAgainButton);
			_gfx.addChild(_startLights);
			_gfx.addChild(_trackInfo);
		}

		/**
		 * onNextTrack 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onNextTrack(event : Event) : void {
			event;
			_game.state = GameState.CREATING_TRACK;
		}

		/**
		 * onPlayAgain 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onPlayAgain(event : Event) : void {
			event;
			_game.state = GameState.TITLES;
			_game.type = null;
			_gameContainer.state = State.TITLES;
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
				if (g.contains(_gfx)) {
					g.removeChild(_gfx);
				}
				return;
			}
			if (!g.contains(_gfx)) {
				_gameContainer = g;
				g.addChild(_gfx);
				
				_carOne.x = 200;//_transform.x;
				_carOne.y = 20;//_transform.y;

				_info.x = _carOne.x + _carOne.width;
				_info.y = _carOne.y;

				_debug.x = g.getWidth() - _debug.width - 10;
				_debug.y = 10;

				_carTwo.x = g.getWidth() - _carTwo.width - 200;//_info.x + _info.width;
				_carTwo.y = _carOne.y;
				
				_info.x = (g.getWidth() - _info.width) * 0.5;
				_info.y = (g.getHeight() - _info.height) * 0.5;

				_nextTrackButton.x = (g.getWidth() - _nextTrackButton.width) * 0.5;
				_nextTrackButton.y = _info.y + _info.height - _nextTrackButton.height - 10;

				_playAgainButton.x = (g.getWidth() - _playAgainButton.width) * 0.5;
				_playAgainButton.y = _info.y + _info.height - _playAgainButton.height - 10;
				

				_startLights.x = (g.getWidth() - _startLights.width) * 0.5;
				_startLights.y = 20;
//				_startLights.y = (g.getHeight() - _startLights.height) * 0.5;
				_startLights.visible = false;
				
				_trackInfo.x = (g.getWidth() - _trackInfo.width) * 0.5;
				_trackInfo.y = g.getHeight() - 60;
			}
			
			switch(_game.state){
				case GameState.TRACK_COMPLETE:
				case GameState.GAME_OVER:
					_counter++;
					if(!_info.visible && _counter >= 30) {
						_info.visible = true;
						_nextTrackButton.visible = _game.state == GameState.TRACK_COMPLETE;
						_playAgainButton.visible = _game.state == GameState.GAME_OVER;
					}
					g.setChildIndex(_gfx, g.numChildren - 1);
					break;
				default:
					_counter = 0;
					_playAgainButton.visible = _nextTrackButton.visible = _info.visible = false;
					break;
			}
			
			
			_carOne.text = "PLAYER ONE\n" + getCarInfo(_hud.lap1, _hud.trackLaps, _hud.speed1, _hud.winTotal1, _hud.lives1, _hud.nextLap1, _hud.lapTime1);
			_carTwo.text = "PLAYER TWO\n" + getCarInfo(_hud.lap2, _hud.trackLaps, _hud.speed2, _hud.winTotal2, _hud.lives2, _hud.nextLap2, _hud.lapTime2);
			_info.text = _hud.info;
			_debug.text = _hud.debug;
			
			
			if(_game.state == GameState.START_LIGHTS && !_startLights.visible) {
				_trackInfo.text = "TRACK: " + _hud.trackName.toUpperCase() + " (LAPS:" + _hud.trackLaps + ")";
				_startLights.visible = true;
				_startLights.addEventListener(Event.COMPLETE, onStartLightsComplete);
				_startLights.go();
			}
		}

		/**
		 * onStartLightsComplete 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onStartLightsComplete(event : Event) : void {
			event.stopImmediatePropagation();
			_startLights.removeEventListener(Event.COMPLETE, onStartLightsComplete);
			_game.state = GameState.DRIVING;
			_startLights.visible = false;
		}

		/**
		 * getCarInfo 
		 * 
		 * @param lap 
		 * @param trackLaps 
		 * @param speed 
		 * @param winTotal 
		 * @param lives 
		 * @param nextlap 
		 * @param lapTime 
		 * 
		 * @return 
		 */
		private function getCarInfo(lap : uint, trackLaps : uint, speed : Number, winTotal : uint, lives : uint, nextlap : uint, lapTime: Number) : String {
			nextlap, lapTime;
			return lap + "/" + trackLaps + "\nSPEED:" + speed.toFixed(2) + "\nWINS:" + winTotal + "\nLIVES:" + lives;// + "\nLAP TIME:" + (lapTime * 0.001).toFixed(1); + "\nNEXTLAP:" + nextlap;
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
