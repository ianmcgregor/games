package me.ianmcgregor.games.artemis.components {
	import com.artemis.Component;

	/**
	 * HealthComponent 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class HealthComponent extends Component {
		/**
		 * _health 
		 */
		private var _health : Number;
		/**
		 * _maximumHealth 
		 */
		private var _maximumHealth : Number;
		/**
		 * _damagedAt 
		 */
		private var _damagedAt : Number = 0;

		/**
		 * HealthComponent 
		 * 
		 * @param health 
		 * 
		 * @return 
		 */
		public function HealthComponent(health : Number) {
			_health = _maximumHealth = health;
		}

		/**
		 * getHealth 
		 * 
		 * @return 
		 */
		public function getHealth() : Number {
			return _health;
		}
		
		/**
		 * setHealth 
		 * 
		 * @param value 
		 * 
		 * @return 
		 */
		public function setHealth(value: Number) : void {
			_health = value;
		}

		/**
		 * getMaximumHealth 
		 * 
		 * @return 
		 */
		public function getMaximumHealth() : Number {
			return _maximumHealth;
		}

		/**
		 * getHealthPercentage 
		 * 
		 * @return 
		 */
		public function getHealthPercentage() : Number {
			return _health / _maximumHealth;
		}

		/**
		 * addDamage 
		 * 
		 * @param damage 
		 * 
		 * @return 
		 */
		public function addDamage(damage : Number) : void {
			_health -= damage;
			if (_health < 0)
				_health = 0;
		}

		/**
		 * restoreHealth 
		 * 
		 * @param amount 
		 * 
		 * @return 
		 */
		public function restoreHealth(amount : Number) : void {
			if(isNaN(amount)) amount = _maximumHealth;
			_health += amount;
			if (_health > _maximumHealth)
				_health = _maximumHealth;
		}

		/**
		 * isAlive 
		 * 
		 * @return 
		 */
		public function isAlive() : Boolean {
			return _health > 0;
		}
		
		/**
		 * setDamagedAt 
		 * 
		 * @param damagedAt 
		 * 
		 * @return 
		 */
		public function setDamagedAt(damagedAt : Number) : void {
			_damagedAt = damagedAt;
		}

		/**
		 * getDamagedAt 
		 * 
		 * @return 
		 */
		public function getDamagedAt() : Number {
			return _damagedAt;
		}
	}
}