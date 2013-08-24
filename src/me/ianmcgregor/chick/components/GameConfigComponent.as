package me.ianmcgregor.chick.components {
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class GameConfigComponent extends Component {
		public var numPlayers : int;
		public var level : OgmoLevel;
		public function GameConfigComponent() {
		}
	}
}
