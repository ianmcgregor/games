package me.ianmcgregor.rogue.components {
	import me.ianmcgregor.games.utils.display.Rect;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import me.ianmcgregor.rogue.constants.Constants;

	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public final class LevelComponent extends Component {
		public var current : OgmoLevel;
		public function LevelComponent(level: OgmoLevel) {
			this.current = level;
		}
		
		public function isWalkable(indexX : Number, indexY : Number) : Boolean {
			if(indexX > current.grid[0].length -1) return false;
			if(indexY > current.grid.length -1) return false;
			return current.grid[indexY][indexX];
		}
		public function getWalkable(x: Number, y: Number) : Boolean {
			var indexX: uint = getGridColumn(x);
			var indexY: uint = getGridRow(y);
			return current.grid[indexY][indexX];
		}

		public function getTileRect(x : Number, y : Number, tileSize : Number = Constants.TILE_SIZE) : Rect {
			var indexX: uint = getGridColumn(x);
			var indexY: uint = getGridRow(y);
			return Rect.get(indexX * tileSize, indexY * tileSize, tileSize, tileSize);
		}

		public function getTileRect2(indexX : Number, indexY : Number, tileSize : Number = Constants.TILE_SIZE) : Rect {
			return Rect.get(indexX * tileSize, indexY * tileSize, tileSize, tileSize);
		}

		public function getWalkableTileRect(x : Number, y : Number, tileSize : Number = Constants.TILE_SIZE) : Rect {
			var indexX: uint = getGridColumn(x);
			var indexY: uint = getGridRow(y);
			return current.grid[indexY][indexX] ? null : Rect.get(indexX * tileSize, indexY * tileSize, tileSize, tileSize);
		}
		
		public function getGridColumn(x: Number, tileSize: Number = Constants.TILE_SIZE) : uint {
			var max: int = current.grid[0].length - 1;
			
			var indexX: int = Math.floor(x / tileSize);
			if(indexX < 0) indexX = 0;
			if(indexX > max) indexX = max;
			
			return indexX;
		}
		
		public function getGridRow(y: Number, tileSize: Number = Constants.TILE_SIZE) : uint {
			var max: int = current.grid.length - 1;
			
			var index: int = Math.floor(y / tileSize);
			if(index < 0) index = 0;
			if(index > max) index = max;
			
			return index;
		}

		public function getTile(x : Number, y : Number) : uint {
			return current.tiles[getGridRow(y)][getGridColumn(x)];
		}
	}
}