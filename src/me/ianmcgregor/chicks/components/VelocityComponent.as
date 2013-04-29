package me.ianmcgregor.chicks.components {
	import com.artemis.Component;

	/**
	 * VelocityComponent 
	 */
	public final class VelocityComponent extends Component {
		/**
		 * _x 
		 */
		private var _x : Number;
		/**
		 * _y 
		 */
		private var _y : Number;

		/**
		 * VelocityComponent 
		 * 
		 * @param x 
		 * @param y 
		 * 
		 * @return 
		 */
		private var _maxY : Number;
		private var _minY : Number;
		private var _maxX : Number;
		private var _minX : Number;

		public function VelocityComponent(minX : Number = -10, maxX : Number = 10, minY : Number = -10, maxY : Number = 10, x : Number = 0, y : Number = 0) {
			_minX = minX;
			_maxX = maxX;
			_minY = minY;
			_maxY = maxY;
			_x = x;
			_y = y;
		}
		
		/**
		 * addX 
		 * 
		 * @param x 
		 * 
		 * @return 
		 */
		public function addX(x : Number) : void {
			_x += x;
			if(_x > _maxX) _x = _maxX;
			if(_x < _minX) _x = _minX;
		}

		/**
		 * addY 
		 * 
		 * @param y 
		 * 
		 * @return 
		 */
		public function addY(y : Number) : void {
			_y += y;
			if(_y > _maxY) _y = _maxY;
			if(_y < _minY) _y = _minY;
		}

		/**
		 * x 
		 */
		public function getX() : Number {
			return _x;
		}

		/**
		 * @private
		 */
		public function setX(x : Number) : void {
			_x = x;
			if(_x > _maxX) _x = _maxX;
			if(_x < _minX) _x = _minX;
		}

		/**
		 * y 
		 */
		public function getY() : Number {
			return _y;
		}

		/**
		 * @private
		 */
		public function setY(y : Number) : void {
			_y = y;
			if(_y > _maxY) _y = _maxY;
			if(_y < _minY) _y = _minY;
		}

		public function dampenX(amount : Number) : void {
			_x *= amount;
		}

		public function dampenY(amount : Number) : void {
			_y *= amount;
		}

		public function dampen(amount : Number) : void {
			_x *= amount;
			_y *= amount;
		}
	}
}