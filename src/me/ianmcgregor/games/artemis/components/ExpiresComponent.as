package me.ianmcgregor.games.artemis.components {
	import com.artemis.Component;

	/**
	 * ExpiresComponent 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class ExpiresComponent extends Component {
		/**
		 * _lifeTime 
		 */
		private var _lifeTime : Number;

		/**
		 * ExpiresComponent 
		 * 
		 * @param lifeTime 
		 * 
		 * @return 
		 */
		public function ExpiresComponent(lifeTime : Number) {
			_lifeTime = lifeTime;
		}

		/**
		 * getLifeTime 
		 * 
		 * @return 
		 */
		public function getLifeTime() : Number {
			return _lifeTime;
		}

		/**
		 * setLifeTime 
		 * 
		 * @param lifeTime 
		 * 
		 * @return 
		 */
		public function setLifeTime(lifeTime : Number) : void {
			_lifeTime = lifeTime;
		}

		/**
		 * reduceLifeTime 
		 * 
		 * @param lifeTime 
		 * 
		 * @return 
		 */
		public function reduceLifeTime(lifeTime : Number) : void {
			_lifeTime -= lifeTime;
		}

		/**
		 * isExpired 
		 * 
		 * @return 
		 */
		public function isExpired() : Boolean {
			return _lifeTime <= 0;
		}
	}
}