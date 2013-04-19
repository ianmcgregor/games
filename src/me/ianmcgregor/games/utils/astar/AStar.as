package me.ianmcgregor.games.utils.astar {
	/**
	 * AStar 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class AStar {
		/**
		 * heuristics
		 */
		public static const HEURISTIC_DIAGONAL : String = "diagonal";
		public static const HEURISTIC_MANHATTAN : String = "manhattan";
		public static const HEURISTIC_EUCLIDIAN : String = "euclidian";
		/**
		 * _open 
		 */
		private const _open : Vector.<Node> = new Vector.<Node>();
		/**
		 * _closed 
		 */
		private const _closed : Vector.<Node> = new Vector.<Node>();
		/**
		 * _grid 
		 */
		private var _grid : Grid;
		/**
		 * _endNode 
		 */
		private var _endNode : Node;
		/**
		 * _startNode 
		 */
		private var _startNode : Node;
		/**
		 * _path 
		 */
		private var _path : Vector.<Node>;
		/**
		 * _heuristic 
		 */
		private var _heuristic : Function = diagonal;
		/**
		 * _straightCost 
		 */
		private const _straightCost : Number = 1.0;
		/**
		 * _diagCost 
		 */
		private const _diagCost : Number = Math.SQRT2;

		/**
		 * AStar 
		 */
		public function AStar() {
		}

		/**
		 * findPath 
		 * 
		 * @param grid 
		 * 
		 * @return 
		 */
		public function findPath(grid : Grid, path: Vector.<Node> = null) : Boolean {
			_grid = grid;
			_open.length = 0;
			_closed.length = 0;
			_path = path || new Vector.<Node>();

			_startNode = _grid.startNode;
			_endNode = _grid.endNode;

			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;

			return search();
		}

		/**
		 * search 
		 * 
		 * @return 
		 */
		public function search() : Boolean {
			var node : Node = _startNode;
			while (node != _endNode) {
				// x
				var startX : int = node.x - 1;
				if( startX < 0 ) startX = 0;
				var maxX : int = _grid.numCols - 1;
				var endX : int = node.x + 1;
				if( endX > maxX ) endX = maxX;
				// y
				var startY : int = node.y - 1;
				if( startY < 0 ) startY = 0;
				var maxY : int = _grid.numRows - 1;
				var endY : int = node.y + 1;
				if( endY > maxY ) endY = maxY;
				// search
				for (var i : int = startX; i <= endX; ++i) {
					for (var j : int = startY; j <= endY; ++j) {
						var test : Node = _grid.getNode(i, j);
//						if (test == node || !test.walkable) { // alow corners to be cut or going through diagonal gaps
						if (test == node || !test.walkable || !_grid.getNode(node.x, test.y).walkable || !_grid.getNode(test.x, node.y).walkable) {
							continue;
						}

						var cost : Number = _straightCost;
						if (!((node.x == test.x) || (node.y == test.y))) {
							cost = _diagCost;
						}
						var g : Number = node.g + cost * test.costMultiplier;
						var h : Number = _heuristic(test);
						var f : Number = g + h;
						if (isOpen(test) || isClosed(test)) {
							if (test.f > f) {
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						} else {
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open[_open.length] = test;
						}
					}
				}
				_closed[_closed.length] = node;
				if (_open.length == 0) {
					//trace("no path found");
					return false;
				}
//				is this faster?
//				_open.sortOn("f", Array.DESCENDING | Array.NUMERIC);
//				node = _open.pop() as Node;
//				_open.sortOn("f", Array.NUMERIC);
				// would it be faster to sort DESC and pop?
				_open.sort(sortBehaviour);
				node = _open.shift();
			}
			buildPath();
			return true;
		}
		
		private function sortBehaviour(a: Node, b: Node) : Number {
			return a.f < b.f ? -1 : 1;
		}

		private function buildPath() : void {
			_path.length = 0;
//			_path = new Array();
			var node : Node = _endNode;
			_path[_path.length] = node;
			while (node != _startNode) {
				node = node.parent;
//				_path.unshift(node);
				_path[_path.length] = node;
			}
			_path.reverse();
		}

		public function get path() : Vector.<Node> {
			return _path;
		}

		private function isOpen(node : Node) : Boolean {
			var l : uint = _open.length;
			for (var i : int = 0; i < l; ++i) {
				if (_open[i] == node) {
					return true;
				}
			}
			return false;
		}

		private function isClosed(node : Node) : Boolean {
			var l : uint = _closed.length;
			for (var i : int = 0; i < l; ++i) {
				if (_closed[i] == node) {
					return true;
				}
			}
			return false;
		}

		private function manhattan(node : Node) : Number {
			var dx : Number = node.x - _endNode.x;
			dx = dx < 0 ? -dx : dx;
			
			var dy : Number = node.y + _endNode.y;
			dy = dy < 0 ? -dy : dy;
			
			return dx * _straightCost + dy * _straightCost;
			
//			return MathUtils.abs(node.x - _endNode.x) * _straightCost + MathUtils.abs(node.y + _endNode.y) * _straightCost;
		}

		private function euclidian(node : Node) : Number {
			var dx : Number = node.x - _endNode.x;
			var dy : Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}

		private function diagonal(node : Node) : Number {
//			var dx : Number = MathUtils.abs(node.x - _endNode.x);
			var dx : Number = node.x - _endNode.x;
			dx = dx < 0 ? -dx : dx;
			var dy : Number = node.y - _endNode.y;
			dy = dy < 0 ? -dy : dy;
//			var diag : Number = MathUtils.min(dx, dy);
			var diag : Number = dx < dy ? dx : dy;
			var straight : Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}

		public function get visited() : Vector.<Node> {
			return _closed.concat(_open);
		}
		
		public function set heuristic(value: String) : void {
			switch(value){
				case HEURISTIC_DIAGONAL:
					_heuristic = diagonal;
					break;
				case HEURISTIC_MANHATTAN:
					_heuristic = manhattan;
					break;
				case HEURISTIC_EUCLIDIAN:
					_heuristic = euclidian;
					break;
				default:
			}
		}
	}
}