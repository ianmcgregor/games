package me.ianmcgregor.rogue.components {
	import me.ianmcgregor.games.utils.astar.Node;

	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class MonsterComponent extends Component {
		public var type : String;
		private var path : Vector.<Node>;
		public var pathIndex : int;
		public var stepX : Number;
		public var stepY : Number;

		public function MonsterComponent(type : String) {
			this.type = type;
		}
		
		public function getPath() : Vector.<Node> {
			return path;
		}
		
		public function setPath(path: Vector.<Node>) : void {
			this.path = path;
			stepX = stepY = NaN;
			pathIndex = 0;
		}
	}
}
