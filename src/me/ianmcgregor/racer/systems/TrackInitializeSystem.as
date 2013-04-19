package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameState;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public final class TrackInitializeSystem extends EntityProcessingSystem {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _track 
		 */
		private var _track : TrackComponent;
		/**
		 * _trackMapper 
		 */
		private var _trackMapper : ComponentMapper;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _gameMapper 
		 */
		private var _gameMapper : ComponentMapper;
		/**
		 * _counter 
		 */
		private var _counter : uint;

		/**
		 * TrackInitializeSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function TrackInitializeSystem(container : GameContainer) {
			_container = container;
			super(TrackComponent, []);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_trackMapper = new ComponentMapper(TrackComponent, _world);
			_gameMapper = new ComponentMapper(GameComponent, _world);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			
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
			_track = _trackMapper.get(e);
			
			switch(_game.state){
				
				/**
				 * Creating track: reset, select next and change state
				 */
				
				case GameState.CREATING_TRACK:
					_counter = 0;
					_track.nextTrack();
					_game.state = GameState.READY;
					break;
				
				/**
				 * Track complete: delay before starting next track
				 */
				
				case GameState.TRACK_COMPLETE:
					_counter++;
					if(_counter == 200) {
//						_game.state = GameState.CREATING_TRACK;
					}
					break;
					
				case GameState.GAME_OVER:
					_track.currentTrack = -1;
					break;
				
				default:
			}
		}
	}
}
