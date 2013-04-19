package me.ianmcgregor.racer.components {
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.racer.constants.TileConstants;
	import me.ianmcgregor.racer.constants.TileType;
	import me.ianmcgregor.racer.constants.Tracks;

	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public class TrackComponent extends Component {
		/**
		 * _currentTrack 
		 */
		private var _currentTrack : int;
		/**
		 * _randomTracks 
		 */
		private var _randomTracks : Array;
		/**
		 * _tileDefinitions 
		 */
		private var _tileDefinitions : Array;
		/**
		 * _trackMaps 
		 */
		private var _trackMaps : Array;
		
//		private var _isDriving : Boolean;
		/**
		 * currentTrackMap 
		 */
		public var currentTrackMap : Vector.<Vector.<TileComponent>>;
		/**
		 * startGrid 
		 */
		public var startGrid : TileComponent;
		/**
		 * name 
		 */
		public var name : String;
		/**
		 * laps 
		 */
		public var laps : uint;
		/**
		 * winner 
		 */
		public var winner : int;
		/**
		 * doForcedRebuild 
		 */
		public var doForcedRebuild : Boolean;
		/**
		 * isBuilder 
		 */
		public var isBuilder : Boolean;
 // TODO: might be usefull to store each track's winner

		/**
		 * TrackComponent 
		 */
		public function TrackComponent() {
			
			_tileDefinitions = Tracks.TILE_DEFINITIONS;
			_trackMaps = Tracks.TRACK_MAPS;

			initTrackMap();
			
			_currentTrack = -1;
		}
		
		/**
		 * Init track map
		 */

		/**
		 * initTrackMap 
		 * 
		 * @return 
		 */
		private function initTrackMap() : void {
			// create empty tile map
			currentTrackMap = new Vector.<Vector.<TileComponent>>(TileConstants.TILE_RANGE, true);
			// add rows
			/**
			 * i 
			 */
			var i: int = -1;
			/**
			 * l 
			 */
			var l : int = TileConstants.TILE_RANGE;
			while(++i < l) {
				/**
				 * row 
				 */
				var row: Vector.<TileComponent> = new Vector.<TileComponent>(TileConstants.TILE_RANGE, true);
				currentTrackMap[i] = row;
				// add component objects
				/**
				 * j 
				 */
				var j: int = -1;
				while(++j < l) {
					row[j] = new TileComponent();
				}
			}
		}
		
		/**
		 * Get tile car is on
		 */

		/**
		 * getTile 
		 * 
		 * @param rowY 
		 * @param colX 
		 * 
		 * @return 
		 */
		public function getTile(rowY : Number, colX : Number) : TileComponent {
//			trace("TrackComponent.getTile(",rowY, colX,")");
			/**
			 * min 
			 */
			var min: int = 0;
			/**
			 * max 
			 */
			var max: int = TileConstants.TILE_RANGE - 1;
			
			/**
			 * row 
			 */
			var row : int = Math.round(rowY);
			if (row < min) row = min;
			if (row > max) row = max;

			/**
			 * col 
			 */
			var col : int = Math.round(colX);
			if (col < min) col = min;
			if (col > max) col = max;

			return currentTrackMap[row][col];
		}
		
		/**
		 * Select random track
		 */

		/**
		 * randomTrack 
		 * 
		 * @return 
		 */
		public function randomTrack() : void {
			if (!_randomTracks || _randomTracks.length == 0) {
				_randomTracks = [];
				/**
				 * l 
				 */
				var l : uint = _trackMaps.length;
				/**
				 * i 
				 */
				for (var i : int = 0; i < l - 1; ++i) {
					_randomTracks.push(i);
				}
			}
			/**
			 * t 
			 */
			var t : Number = MathUtils.randomInt(_randomTracks.length);
			_currentTrack = _randomTracks[t];
			_randomTracks.splice(t, 1);
			build(_trackMaps[_currentTrack]);
		}
		
		/**
		 * Select next track
		 */

		/**
		 * nextTrack 
		 * 
		 * @return 
		 */
		public function nextTrack() : void {
			if (_currentTrack >= _trackMaps.length - 1) {
				_currentTrack = 0;
			} else {
				_currentTrack++;
			}
			build(_trackMaps[_currentTrack]);
		}

		/**
		 * Select blank track
		 */

		/**
		 * blankTrack 
		 * 
		 * @return 
		 */
		public function blankTrack() : void {
			build(Tracks.BLANK_TRACK);
		}
		
		/**
		 * Select blank track
		 */
		
		/**
		 * buildTrack 
		 * 
		 * @param index 
		 * 
		 * @return 
		 */
		public function buildTrack(index : int) : void {
			build(_trackMaps[index]);
		}
		
		/**
		 * Get track map
		 */
		
//		public function getTrackMap(index: int): Array {
//			return _trackMaps[index];
//		}
		
		/**
		 * Build new track
		 */
		
		/**
		 * build 
		 * 
		 * @param track 
		 * 
		 * @return 
		 */
		private function build(track : Array) : void {
			demolish();
			name = track[0];
			laps = track[1];
			/**
			 * map 
			 */
			var map : Array = track[2]; 
			const l : int = TileConstants.TILE_RANGE;
			/**
			 * row 
			 */
			for (var row : int = 0; row < l; ++row) {
				/**
				 * col 
				 */
				for (var col : int = 0; col < l; ++col) {
					/**
					 * index 
					 */
					var index : int = map[row][col];
					/**
					 * definition 
					 */
					var definition: Object = _tileDefinitions[index];
					/**
					 * tile 
					 */
					var tile: TileComponent = currentTrackMap[row][col];
					// props
					tile.id = ((row * 10) + col);
					tile.index = index;
//					tile.textureRef = "tile00" + ( frame < 10 ? "0" + frame : frame );
					tile.type = definition["type"];
					tile.texture = definition["texture"];
					tile.direction = definition["direction"];
					tile.curveTo = definition["curveTo"];
					tile.cornerA = definition["cornerA"];
					tile.cornerB = definition["cornerB"];
					tile.climb = definition["climb"];
					// indices
					tile.row = row;
					tile.col = col;
					tile.z = 0;
					// set startgrid tile
					if (tile.type == TileType.START_GRID) {
						startGrid = tile;
					}
				}
			}
		}
		
		/**
		 * Demolish old track FIXME: maybe irrelevant now?
		 */

		/**
		 * demolish 
		 * 
		 * @return 
		 */
		public function demolish() : void {
			startGrid = null;
		}
		
		/**
		 * isDriving
		 */

//		public function get isDriving() : Boolean {
//			return _isDriving;
//		}
//
//		public function set isDriving(b : Boolean) : void {
//			_isDriving = b;
//		}

		/**
		 * currentTrack 
		 */
		public function get currentTrack() : int {
			return _currentTrack;
		}

		/**
		 * @private
		 */
		public function set currentTrack(currentTrack : int) : void {
			_currentTrack = currentTrack;
		}
	}
}
