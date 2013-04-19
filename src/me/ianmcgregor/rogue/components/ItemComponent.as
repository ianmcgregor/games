package me.ianmcgregor.rogue.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class ItemComponent extends Component {
		public var type : String;
		public var texture : String;
		public var textureChanged : Boolean;

		public function ItemComponent(type : String, texture : String) {
			this.type = type;
			this.texture = texture;
		}

		public function update(type : String, texture : String = null) : void {
			this.type = type;
			if(texture) {
				this.texture = texture;
				this.textureChanged = true;
			}
		}
	}
}
