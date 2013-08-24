package me.ianmcgregor.fight.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class BadGuyComponent extends Component {
		public var type : String;

		public function BadGuyComponent(type : String) {
			this.type = type;
		}
	}
}
