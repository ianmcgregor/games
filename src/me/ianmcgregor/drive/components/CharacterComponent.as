package me.ianmcgregor.drive.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class CharacterComponent extends Component {
		public static const ATTACK_TYPE_REAR :  int = 0;
		public static const ATTACK_TYPE_LEFT :  int = 1;
		public static const ATTACK_TYPE_RIGHT :  int = 2;
		public var attackType: int;
		
		public var directionH: int;
		public var directionV : int;
		private var _timeNow : Number = 0;
		private var _isDead : Boolean;
		public var deadAt : Number;
		private var _isHurt : Boolean;
		private var _hurtAt : Number = 0;
		public var damageDirection : String;
		/**
		 * CharacterComponent 
		 * 
		 * @return 
		 */

		public function CharacterComponent() {
		}
		
		public function updateTime(timeNow: Number) : void {
			_timeNow = timeNow;
			if (_isHurt && _hurtAt < _timeNow - 0.2) {
				_isHurt = false;
			}
		}
		
		public function setDead(deadAt: Number) : void {
			this.deadAt = deadAt;
			_isDead = true;
		}

		public function setHurt() : void {
			_isHurt = true;
			_hurtAt = _timeNow;
		}

		public function getHurt() : Boolean {
			return _isHurt;
		}
	}
}
