package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class AvatarComponent extends Component {
		public var name: String;
		public var texturePrefix : String;

		public function AvatarComponent(name: String, texturePrefix: String) {
			this.name = name;
			this.texturePrefix = texturePrefix;
		}

	}
}
