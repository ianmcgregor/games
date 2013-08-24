package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class EnemyComponent extends Component {
		public var type : String;

		public function EnemyComponent(type : String) {
			this.type = type;
		}
	}
}
