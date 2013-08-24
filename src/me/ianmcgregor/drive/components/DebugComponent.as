package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class DebugComponent extends Component {
		public var entityType : String;
		public function DebugComponent(entityType: String = null) {
			this.entityType = entityType;
		}
	}
}
