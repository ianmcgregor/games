package me.ianmcgregor.games.utils.raycast {
	import me.ianmcgregor.games.utils.astar.Grid;

	import flash.geom.Point;

	/**
	 * RayCaster 
	 * 
	 */
	public class RayCaster {
		/**
		 * _grid 
		 */
		private var _grid : Grid;

		/**
		 * RayCaster 
		 * 
		 * Ray casting technique described in paper:
		 * A Fast Voxel Traversal Algorithm for Ray Tracing - John Amanatides, Andrew Woo
		 * http://www.cse.yorku.ca/~amana/research/grid.pdf
		 * 
		 */
		public function RayCaster() {
		}

		/**
		 * castRay 
		 * 
		 * @param grid 
		 * @param p1OriginalX 
		 * @param p1OriginalY 
		 * @param p2OriginalX 
		 * @param p2OriginalY 
		 * @param tileSize 
		 * 
		 * @return 
		 */
		public function castRay(grid : Grid, p1OriginalX : Number, p1OriginalY : Number, p2OriginalX : Number, p2OriginalY : Number, tileSize : int = 32, collisionPoint : Point = null) : Point {
			// initialise
			_grid = grid;
			
			// point to return
			if(!collisionPoint) {
				collisionPoint = new Point();
			}
			collisionPoint.setTo(0, 0);

			// normalise the points
			var p1X : Number = p1OriginalX / tileSize;
			var p1Y : Number = p1OriginalY / tileSize;

			var p2X : Number = p2OriginalX / tileSize;
			var p2Y : Number = p2OriginalY / tileSize;

			// initialise the integer test coordinates with the coordinates of the starting tile, in tile space ( integer )
			// Note: using noralised version of p1
			var testX : int = int(p1X);
			var testY : int = int(p1Y);

			var endTileX : int = int(p2X);
			var endTileY : int = int(p2Y);

			// find out if any difference between start and end in tile space
			if ( testX == endTileX && testY == endTileY ) {
				// since it doesn't cross any boundaries, there can't be a collision
				collisionPoint.x = p2OriginalX;
				collisionPoint.y = p2OriginalY;
				return collisionPoint;
			}

			// find out which direction to step, on each axis
			var stepX : int = ( p2X > p1X ) ? 1 : -1;
			var stepY : int = ( p2Y > p1Y ) ? 1 : -1;

			var rayDirectionX: Number = p2X - p1X;
			var rayDirectionY: Number = p2Y - p1Y;

			// find out how far to move on each axis for every whole integer step on the other
			var ratioX : Number = rayDirectionX / rayDirectionY;
			var ratioY : Number = rayDirectionY / rayDirectionX;

			var deltaY : Number = p2X - p1X;
			var deltaX : Number = p2Y - p1Y;
			// faster than Math.abs()...
			deltaX = deltaX < 0 ? -deltaX : deltaX;
			deltaY = deltaY < 0 ? -deltaY : deltaY;

			// initialise the non-integer step, by advancing to the next tile boundary / ( whole integer of opposing axis )
			// if moving in positive direction, move to end of curent tile, otherwise the beginning
			var maxX : Number = deltaX * ( ( stepX > 0 ) ? ( 1.0 - (p1X % 1) ) : (p1X % 1) );
			var maxY : Number = deltaY * ( ( stepY > 0 ) ? ( 1.0 - (p1Y % 1) ) : (p1Y % 1) );

			// traverse
			while ( testX != endTileX || testY != endTileY ) {
				if (  maxX < maxY ) {
					maxX += deltaX;
					testX += stepX;

					if ( notWalkable(testX, testY) ) {
						collisionPoint.x = testX;
						if ( stepX < 0 ) collisionPoint.x += 1.0;
						// add one if going left
						collisionPoint.y = p1Y + ratioY * ( collisionPoint.x - p1X);
						collisionPoint.x *= tileSize;
						// scale up
						collisionPoint.y *= tileSize;
						return collisionPoint;
					}
				} else {
					maxY += deltaY;
					testY += stepY;

					if ( notWalkable(testX, testY) ) {
						collisionPoint.y = testY;
						if ( stepY < 0 ) collisionPoint.y += 1.0;
						// add one if going up
						collisionPoint.x = p1X + ratioX * ( collisionPoint.y - p1Y);
						collisionPoint.x *= tileSize;
						// scale up
						collisionPoint.y *= tileSize;
						return collisionPoint;
					}
				}
			}
			
			// no intersection found, just return end point:
			collisionPoint.x = p2OriginalX;
			collisionPoint.y = p2OriginalY;
			return collisionPoint;
		}

		/**
		 * notWalkable 
		 * 
		 * @param testX 
		 * @param testY 
		 * 
		 * @return 
		 */
		private function notWalkable(testX : int, testY : int) : Boolean {
			if(!_grid.getNode(testX, testY)) return false;
			return !_grid.getNode(testX, testY).walkable;
		}
	}
}