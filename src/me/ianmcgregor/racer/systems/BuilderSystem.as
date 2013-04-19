package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.BuilderComponent;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.TileComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameState;
	import me.ianmcgregor.racer.constants.TileConstants;
	import me.ianmcgregor.racer.constants.Tracks;

	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.ui.Keyboard;

	/**
	 * @author McFamily
	 */
	public final class BuilderSystem extends EntityProcessingSystem {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _trackMapper 
		 */
		private var _trackMapper : ComponentMapper;
		/**
		 * _track 
		 */
		private var _track : TrackComponent;
		/**
		 * _tileChanged 
		 */
		private var _tileChanged : Boolean;
		/**
		 * _builderMapper 
		 */
		private var _builderMapper : ComponentMapper;
		/**
		 * _builder 
		 */
		private var _builder : BuilderComponent;
		/**
		 * _gameMapper 
		 */
		private var _gameMapper : ComponentMapper;
		/**
		 * _game 
		 */
		private var _game: GameComponent;
		/**
		 * BuilderSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function BuilderSystem(container : GameContainer) {
			super(TrackComponent, []);
			_container = container;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_trackMapper = new ComponentMapper(TrackComponent, _world);
			_builderMapper = new ComponentMapper(BuilderComponent, _world);
			_gameMapper = new ComponentMapper(GameComponent, _world);

			_container.stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		/**
		 * onTouch 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTouch(event : TouchEvent) : void {
			if(!_track) return;
			/**
			 * touch 
			 */
			var touch:Touch = event.getTouch(_container.stage);
			if (touch && touch.phase == TouchPhase.BEGAN) {
				// offset mouse XY so center of tile 0,0 is 0,0
				/**
				 * x 
				 */
				var x: Number = touch.globalX - _container.getWidth() * 0.5;// - TileConstants.TILE_SIZE;
				/**
				 * y 
				 */
				var y: Number = touch.globalY - TileConstants.TILE_SIZE * 1.25 - TileConstants.TRACK_OFFSET_Y;
				// map to iso grid
				/**
				 * tileX 
				 */
				var tileX : Number = (y + x * 0.5) / TileConstants.TILE_SIZE;
				/**
				 * tileY 
				 */
				var tileY : Number = (y - x * 0.5) / TileConstants.TILE_SIZE;
				// pick tile
				/**
				 * tile 
				 */
				var tile: TileComponent = _track.getTile(tileY, tileX);
				changeType(tile);
			}
		}

		/**
		 * changeType 
		 * 
		 * @param tile 
		 * 
		 * @return 
		 */
		private function changeType(tile : TileComponent) : void {
			/**
			 * _tileDefinitions 
			 */
			var _tileDefinitions : Array = Tracks.TILE_DEFINITIONS;
			
			/**
			 * index 
			 */
			var index: int = tile.index + ( _container.getInput().isDown(Keyboard.SHIFT) ? -1 : 1);
			if(index <= 0) index = 0;
			if(index >= _tileDefinitions.length - 1) index = 0;
			
			/**
			 * definition 
			 */
			var definition: Object = _tileDefinitions[index];
			// props
			tile.index = index;
			tile.type = definition["type"];
			tile.texture = definition["texture"];
			tile.direction = definition["direction"];
			tile.curveTo = definition["curveTo"];
			tile.cornerA = definition["cornerA"];
			tile.cornerB = definition["cornerB"];
			tile.climb = definition["climb"];
			
			_tileChanged = true;
		}

		/**
		 * stringifyTrackMap 
		 * 
		 * @return 
		 */
		private function stringifyTrackMap() : void {
			/**
			 * track 
			 */
			var track : Vector.<Vector.<TileComponent>> = _track.currentTrackMap;
			/**
			 * name 
			 */
			var name : String = String(_builder.name || _track.name);
			/**
			 * laps 
			 */
			var laps : String = String(_builder.laps > 0 ? _builder.laps : _track.laps);
			/**
			 * trackString 
			 */
			var trackString : String = "['" + name + "', " + laps + ", [";

			const l : int = track.length;
			/**
			 * row 
			 */
			for (var row : int = 0; row < l; ++row) {
				if (row > 0) trackString += ", ";
				trackString += "[";
				/**
				 * col 
				 */
				for (var col : int = 0; col < l; ++col) {
					if (col > 0) trackString += ",";
					trackString += track[row][col].index;
				}
				trackString += "]";
			}
			trackString += "]],";
			_builder.track = trackString;
		}
		
		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			
			_game = _gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
			_builder = _builderMapper.get(_world.getTagManager().getEntity(EntityTag.BUILDER));
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
				
				case GameState.TITLES:
					_track.isBuilder = true;
					_builder.trackIndex = -1;
					stringifyTrackMap();
					_game.state = GameState.READY;
					break;
				
				case GameState.READY:
					_track.currentTrack = _builder.trackIndex;
					if(_track.currentTrack == -1){
						_track.blankTrack();
					} else {
						_track.buildTrack(_track.currentTrack);
					}
					_builder.name = _track.name;
					_builder.laps = _track.laps;
					stringifyTrackMap();
					_track.doForcedRebuild = true;
					_game.state = GameState.BUILDING_TRACK;
					break;
					
				case GameState.BUILDING_TRACK:
					if(_builder.trackIndex != _track.currentTrack) {
						_track.doForcedRebuild = true;
						_game.state = GameState.READY;
					} else if(_tileChanged || _builder.changed) {
						// monitor for changes in current track
						if(_tileChanged) _track.doForcedRebuild = true;
						stringifyTrackMap();
						_tileChanged = false;
						_builder.changed = false;
					}
					break;
					
				default:
			}
		}

		/**
		 * traceAllTracks 
		 * 
		 * @return 
		 */
		protected function traceAllTracks() : void {
			/**
			 * l 
			 */
			var l : int = Tracks.TRACK_MAPS.length;
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				stringifyTrackMap();
				_track.nextTrack();
				trace(_builder.track + ",");
			}
		}
	}
}
