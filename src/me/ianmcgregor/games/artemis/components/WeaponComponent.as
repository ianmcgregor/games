package me.ianmcgregor.games.artemis.components {
	import com.artemis.Component;

	/**
	 * WeaponComponent 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class WeaponComponent extends Component {
		/**
		 * _shotAt 
		 */
		private var _shotAt : Number = 0;

		/**
		 * WeaponComponent 
		 */
		public function WeaponComponent() {
		}

		/**
		 * setShotAt 
		 * 
		 * @param shotAt 
		 * 
		 * @return 
		 */
		public function setShotAt(shotAt : Number) : void {
			_shotAt = shotAt;
		}

		/**
		 * getShotAt 
		 * 
		 * @return 
		 */
		public function getShotAt() : Number {
			return _shotAt;
		}
	}
}