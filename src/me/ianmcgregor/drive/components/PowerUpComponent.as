package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public class PowerUpComponent extends Component {
		/**
		 * _lifeTime 
		 */
		private var _lifeTime : Number;

		/**
		 * PowerUpComponent 
		 * 
		 * @param lifeTime 
		 * 
		 * @return 
		 */
		public function PowerUpComponent(lifeTime : Number = 0) {
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
