package me.ianmcgregor.tenseconds.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class GameOverComponent extends Component {
		public var won : Boolean;

		/**
		 * GameOverComponent 
		 */
		public function GameOverComponent(won : Boolean) {
			this.won = won;
		}
	}
}
