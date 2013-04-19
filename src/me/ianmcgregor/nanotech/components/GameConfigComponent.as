package me.ianmcgregor.nanotech.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class GameConfigComponent extends Component {
		public var numPlayers : int;
		private var _progress : Number = 0;
		public function GameConfigComponent() {
		}
		
		public function setProgress(amount: Number) : void {
			_progress = amount;
		}
		
		public function addProgress(amount: Number) : void {
			_progress += amount;
			if(_progress > 1) _progress = 1;
		}
		public function getProgress() : Number {
			return _progress;
		}
	}
}
