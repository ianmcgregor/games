package me.ianmcgregor.rogue.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class MessageComponent extends Component {
		public var text : String;

		public function MessageComponent(text : String) {
			this.text = text;
		}
	}
}
