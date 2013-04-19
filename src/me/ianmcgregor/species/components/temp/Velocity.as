package me.ianmcgregor.species.components.temp {
	import com.artemis.utils.Utils;
	import com.artemis.Component;

	/**
	 * Velocity 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class Velocity extends Component {
		/**
		 * _velocity 
		 */
		private var _velocity : Number;
		/**
		 * _angle 
		 */
		private var _angle : Number;

		/**
		 * Velocity 
		 * 
		 * @param velocity 
		 * @param angle 
		 * 
		 * @return 
		 */
		public function Velocity(velocity : Number = 0, angle : Number = 0) {
			_velocity = velocity;
			_angle = angle;
		}

		/**
		 * getVelocity 
		 * 
		 * @return 
		 */
		public function getVelocity() : Number {
			return _velocity;
		}

		/**
		 * setVelocity 
		 * 
		 * @param velocity 
		 * 
		 * @return 
		 */
		public function setVelocity(velocity : Number) : void {
			_velocity = velocity;
		}

		/**
		 * setAngle 
		 * 
		 * @param angle 
		 * 
		 * @return 
		 */
		public function setAngle(angle : Number) : void {
			_angle = angle;
		}

		/**
		 * getAngle 
		 * 
		 * @return 
		 */
		public function getAngle() : Number {
			return _angle;
		}

		/**
		 * addAngle 
		 * 
		 * @param a 
		 * 
		 * @return 
		 */
		public function addAngle(a : Number) : void {
			_angle = (_angle + a) % 360;
		}

		/**
		 * getAngleAsRadians 
		 * 
		 * @return 
		 */
		public function getAngleAsRadians() : Number {
			return Utils.toRadians(_angle);
		}
	}
}