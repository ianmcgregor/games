package me.ianmcgregor.fight.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class CharacterComponent extends Component {
		public static const PUNCH :  int = 1;
		public static const KICK :  int = 2;
		
		public var directionH: int;
		public var directionV : int;
		public var attack : int = 0;
		private var _attackedAt : Number = 0;
		private var _timeNow : Number = 0;
		public var attackDuration : Number = 0.1;
		public var attackRepeatGap : Number = 0.1;
		private var _isDead : Boolean;
		public var deadAt : Number;
		public var isHurt : Boolean;
		public var hurtAt : Number = 0;
		/**
		 * CharacterComponent 
		 * 
		 * @return 
		 */

		public function CharacterComponent() {
		}
		
		public function updateTime(timeNow: Number) : void {
			_timeNow = timeNow;
			if (attack > 0 && _attackedAt < _timeNow - attackDuration) {
				attack = 0;
			}
		}
		
		private function doAttack(type : int) : Boolean {
			if (attack == 0 && _attackedAt < _timeNow - attackRepeatGap) {
				attack = type;
				_attackedAt = _timeNow;
				return true;
			}
			return false;
		}
		
		public function kick() : Boolean {
			return doAttack(KICK);
		}
		
		public function punch() : Boolean {
			return doAttack(PUNCH);
		}

		public function isKicking() : Boolean {
			return attack == KICK;
		}

		public function isPunching() : Boolean {
			return attack == PUNCH;
		}

		public function isAttacking() : Boolean {
			return attack > 0;
		}

		public function isDead() : Boolean {
			return _isDead;
		}

		public function setDead(deadAt: Number) : void {
			this.deadAt = deadAt;
			_isDead = true;
		}
	}
}
