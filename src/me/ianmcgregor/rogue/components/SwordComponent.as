package me.ianmcgregor.rogue.components {
	import com.artemis.Entity;
	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public final class SwordComponent extends Component {
//		public var brandished : int;
		public var owner : Entity;

		public function SwordComponent(owner : Entity) {
			this.owner = owner;
		}
	}
}
