package me.ianmcgregor.games.utils.astar {
	import flash.display.Sprite;
	
	/**
	 * Serves as a visual representation of a grid of nodes used in a pathfinding solution.
	 */
	public final class GridOverlay extends Sprite
	{
		private var _cellSize:int = 32;
		private var _grid:Grid;
		
		/**
		 * Constructor.
		 */
		public function GridOverlay(grid : Grid, cellSize:int = 32)
		{
			_grid = grid;
			_cellSize = cellSize;
			drawGrid();
//			findPath();
			//addEventListener(MouseEvent.CLICK, onGridClick);
//			alpha = 0.5;
		}
		
		/**
		 * Draws the given grid, coloring each cell according to its state.
		 */
		public function drawGrid():void
		{
			graphics.clear();
			var l : int = _grid.numCols;
			for (var i : int = 0; i < l; i++) {
				var len : int = _grid.numRows;
				for (var j : int = 0; j < len; j++)
				{
					var node:Node = _grid.getNode(i, j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node), 0);
					graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				}
			}
		}
		
		/**
		 * Determines the color of a given node based on its state.
		 */
		private function getColor(node:Node):uint
		{
			if(!node.walkable) return 0;
			if(node == _grid.startNode) return 0x666666;
			if(node == _grid.endNode) return 0x666666;
			return 0xffffff;
		}
		
		/**
		 * Handles the click event on the GridView. Finds the clicked on cell and toggles its walkable state.
		 */
//		private function onGridClick(event:MouseEvent):void
//		{
//			var xpos:int = Math.floor(event.localX / _cellSize);
//			var ypos:int = Math.floor(event.localY / _cellSize);
//			
//			_grid.setWalkable(xpos, ypos, !_grid.getNode(xpos, ypos).walkable);
//			drawGrid();
//			findPath();
//		}
		
		/**
		 * Creates an instance of AStar and uses it to find a path.
		 */
//		private function findPath():void
//		{
//			var astar:AStar = new AStar();
//			if(astar.findPath(_grid))
//			{
//				showVisited(astar);
//				showPath(astar);
//			}
//		}
		
		public function setPath(astar: AStar) : void {
			showVisited(astar);
			showPath(astar);
		}
		
		/**
		 * Highlights all nodes that have been visited.
		 */
		private function showVisited(astar:AStar):void
		{
			var visited : Vector.<Node> = astar.visited;
			var l : uint = visited.length;
			for (var i : int = 0; i < l; ++i)
			{
				graphics.beginFill(0xcccccc, 0);
				graphics.drawRect(visited[i].x * _cellSize, visited[i].y * _cellSize, _cellSize, _cellSize);
				graphics.endFill();
			}
		}
		
		/**
		 * Highlights the found path.
		 */
		private function showPath(astar:AStar):void
		{
			var path : Vector.<Node> = astar.path;
			var l : uint = path.length;
			for (var i : int = 0; i < l; ++i)
			{
				graphics.lineStyle(0);
				graphics.beginFill(0xFFFFFF, 0.2);
				graphics.drawCircle(path[i].x * _cellSize + _cellSize / 2,
									path[i].y * _cellSize + _cellSize / 2,
									_cellSize / 3);
			}
		}
	}
}