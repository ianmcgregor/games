package me.ianmcgregor.chicks.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class SoundComponent extends Component {
		/**
		 * name 
		 */
		public var name : String;
		public var added : String;
		public var removed : String;
		public var trigger : String;
		public var arg : *;

		/**
		 * SoundComponent 
		 * 
		 * @param name 
		 * @param added 
		 * @param removed 
		 * 
		 * @return 
		 */
		public function SoundComponent(name : String, added: String = null, removed: String = null) {
			this.name = name;
			this.added = added;
			this.removed = removed;
		}
	}
}
