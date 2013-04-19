package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.HUDComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.EntityGroup;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameState;
	import me.ianmcgregor.racer.constants.GameType;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSystem extends EntityProcessingSystem {
		/**
		 * TODO: update HUDComponent with current player info so can be rendered in HUDSpatial
		 * 
		 * current lap
		 * lives
		 * speedometer?
		 * 
		 */
		private var _container : GameContainer;
		/**
		 * _carMapper 
		 */
		private var _carMapper : ComponentMapper;
		/**
		 * _hudMapper 
		 */
		private var _hudMapper : ComponentMapper;
		/**
		 * _trackMapper 
		 */
		private var _trackMapper : ComponentMapper;
		/**
		 * _track 
		 */
		private var _track : TrackComponent;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _gameMapper 
		 */
		private var _gameMapper : ComponentMapper;

		/**
		 * HUDSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function HUDSystem(container : GameContainer) {
			super(HUDComponent, []);
			_container = container;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_hudMapper = new ComponentMapper(HUDComponent, _world);
			_trackMapper = new ComponentMapper(TrackComponent, _world);
			_carMapper = new ComponentMapper(CarComponent, _world);
			_gameMapper = new ComponentMapper(GameComponent, _world);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_track = _trackMapper.get(_world.getTagManager().getEntity(EntityTag.TRACK));
			_game = _gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * hud 
			 */
			var hud : HUDComponent = _hudMapper.get(e);

			/**
			 * debug 
			 */
			var debug : String = "";
			debug += "STATE:\n" + GameState.getStateName(_game.state);

			/**
			 * info 
			 */
			var info : String = "";
//			info += _track.name + "\nLAPS:" + _track.laps;
//			info += "\n";
//			info += "\n";
			
			// track
			hud.trackName = _track.name;
			hud.trackLaps = _track.laps;

			/**
			 * cars 
			 */
			var cars : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.CARS);
			/**
			 * l 
			 */
			var l : int = cars.size();
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				/**
				 * car 
				 */
				var car : CarComponent = _carMapper.get(cars.get(i));
				/**
				 * Set car data
				 */
				hud.setType(car.id, car.type);
				hud.setSpeed(car.id, car.speed);
				hud.setLap(car.id, car.lap);
				hud.setNextLap(car.id, car.nextLap);
				hud.setWinTotal(car.id, car.winTotal);
				hud.setLives(car.id, car.lives);
				hud.setLapTime(car.id, car.lapTime);
				
				
			}

			/**
			 * Check track complete TODO move to car system
			 */
			
			switch(_game.state){
				case GameState.TRACK_COMPLETE:
					hud.lastWinner = _track.winner;
					info += createPlayerMessage(hud);
					break;
				case GameState.GAME_OVER:
					info += "GAME OVER\n\n";
					info += "PLAYER ONE: " + hud.winTotal1 + " WINS\n";
					info += "PLAYER TWO: " + hud.winTotal2 + " WINS\n";
					break;
				default:
			} 
			
			// update output text
			hud.debug = debug;
			hud.info = info;
		}

		/**
		 * createPlayerMessage 
		 * 
		 * @param hud 
		 * 
		 * @return 
		 */
		private function createPlayerMessage(hud : HUDComponent) : String {
			/**
			 * info 
			 */
			var info : String = "";
			if (_game.type == GameType.ONE_PLAYER) {
				info += ( hud.lastWinner == 1 ? "YOU WIN!" : "YOU LOSE!");
				info += "\n\n";
				if (hud.lastWinner == 1) {
					info += "GREAT RACE!";
				} else {
					info += "TRY HARDER NEXT TIME!";
				}
			} else {
				info += "WINNER: PLAYER " + hud.lastWinner;
				info += "\n\n";
				info += "GREAT RACE PLAYER " + hud.lastWinner + "!";
				info += "\n";
				info += "TRY HARDER PLAYER " + ( hud.lastWinner == 1 ? "2" : "1") + "!";
			}
//			info += "\n";
//			info += "WINS: " + hud.getWinTotal(hud.lastWinner);
			return info;
		}
	}
}
