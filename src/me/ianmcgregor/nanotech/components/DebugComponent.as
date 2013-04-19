package me.ianmcgregor.nanotech.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class DebugComponent extends Component {
		public var entityType : String;
		public function DebugComponent(entityType: String) {
			this.entityType = entityType;
		}
	}
}
