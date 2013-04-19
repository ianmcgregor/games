package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.input.IKeyListener;
	import me.ianmcgregor.species.components.CollisionRect;
	import me.ianmcgregor.species.components.Hero;
	import me.ianmcgregor.species.components.Level;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.ui.Keyboard;
	import flash.utils.getTimer;



	/**
	 * @author McFamily
	 */
	public class PlayerControlSystem extends EntityProcessingSystem implements IKeyListener {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;
		/**
		 * _levelMapper 
		 */
		private var _levelMapper : ComponentMapper;
		/**
		 * _moveUp 
		 */
		private var _moveUp : Boolean;
		/**
		 * _moveDown 
		 */
		private var _moveDown : Boolean;
		/**
		 * _moveLeft 
		 */
		private var _moveLeft : Boolean;
		/**
		 * _moveRight 
		 */
		private var _moveRight : Boolean;
		/**
		 * _shoot 
		 */
		private var _shoot : Boolean;
		private const SPEED : Number = 300;
		/**
		 * _level 
		 */
		private var _level : Level;
		/**
		 * _moveUpTime 
		 */
		private var _moveUpTime : int;
		/**
		 * _isJumping 
		 */
		private var _isJumping : Boolean;
		/**
		 * _jumpPower 
		 */
		private var _jumpPower : Number;
		/**
		 * _lastDirection 
		 */
		private var _lastDirection : int;
		/**
		 * _weaponMapper 
		 */
		private var _weaponMapper : ComponentMapper;
		/**
		 * _now 
		 */
		private var _now : int;
		/**
		 * _rectMapper 
		 */
		private var _rectMapper : ComponentMapper;

		/**
		 * PlayerControlSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function PlayerControlSystem(container : GameContainer) {
			super(TransformComponent, [Hero]);
			_container = container;
		}
		

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_weaponMapper = new ComponentMapper(WeaponComponent, _world);
			_rectMapper = new ComponentMapper(CollisionRect, _world);
			_container.getInput().addKeyListener(this);
			_lastDirection = 1;
		}
		
		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_now = getTimer();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * levelEntity 
			 */
			var levelEntity : Entity = _world.getTagManager().getEntity(EntityTag.LEVEL);
			_level = _levelMapper.get(levelEntity);

			/**
			 * transform 
			 */
			var transform : TransformComponent = _transformMapper.get(e);
			/**
			 * velocity 
			 */
			var velocity : Velocity = _velocityMapper.get(e);
			/**
			 * rect 
			 */
			var rect : CollisionRect = _rectMapper.get(e);
			velocity.velocityX = velocity.velocityY = 0;

			/**
			 * amount 
			 */
			var amount : Number = _world.getDelta() * SPEED;

//			var topLeft : Boolean = _level.collides(transform.x, transform.y);
//			var topRight : Boolean = _level.collides(transform.x + 32, transform.y);
//			var bottomLeft : Boolean = _level.collides(transform.x, transform.y + 32);
//			var bottomRight : Boolean = _level.collides(transform.x + 32, transform.y + 32);
			
			/**
			 * bottomLeft 
			 */
			var bottomLeft : Boolean = _level.collides(transform.x + rect.rect.x, transform.y + rect.rect.y + rect.rect.height + 1);
//			trace('bottomLeft: ' + (bottomLeft));
			/**
			 * bottomRight 
			 */
			var bottomRight : Boolean = _level.collides(transform.x + rect.rect.width + rect.rect.x, transform.y + rect.rect.y + rect.rect.height + 1);
//			trace('bottomRight: ' + (bottomRight));

			if (!_isJumping && !bottomLeft && !bottomRight) {
				_moveDown = true;
//				trace('_moveDown: ' + (_moveDown));
			}

			if (_isJumping) {
				_jumpPower -= 50;
				velocity.velocityY = _world.getDelta() * -_jumpPower;
				if(getTimer() - _moveUpTime > 200){
					_isJumping = false;
				}
			} else  if (_moveUp && (bottomLeft || bottomRight)) {
				_jumpPower = 800;
				velocity.velocityY = _world.getDelta() * -_jumpPower;
				_isJumping = true;
				_moveDown = false;
				_moveUpTime = getTimer();
			} 
			if (_moveDown) {
				velocity.velocityY = amount;
			}
			if (_moveLeft) {
				velocity.velocityX = -amount;
				_lastDirection = -1;
			}
			if (_moveRight) {
				velocity.velocityX = amount;
				_lastDirection = 1;
			}
			
//			moveBy(velocity.velocityX, velocity.velocityY, transform, velocity);
			
			/**
			 * weapon 
			 */
			var weapon : WeaponComponent = _weaponMapper.get(e);
			if (_shoot  && weapon.getShotAt() + 80 < _now) {
				var direction : int = _lastDirection;
				var bulletX: int = direction > 0 ? transform.x + 40 : transform.x - 4;
				var bullet : Entity = EntityFactory.createBullet(_world);
				TransformComponent(bullet.getComponent(TransformComponent)).setLocation(bulletX, transform.y + 20);
				Velocity(bullet.getComponent(Velocity)).velocityX = 10 * direction;
				Velocity(bullet.getComponent(Velocity)).velocityY = ( -2 + Math.random() * 4 );
				bullet.refresh();
				weapon.setShotAt(_now);
			}
		}

//		private function moveBy(x : int, y : int, transform : Transform, velocity: Velocity) : void {
//			trace("PlayerControlSystem.moveBy(",x, y, transform,")");
//			var sign : int;
//			if (x != 0 && rectCollides(transform.x + x, transform.y, 31, 31)) {
//				sign = x > 0 ? 1 : -1;
//				while (x != 0) {
//					if (!rectCollides(transform.x + sign, transform.y, 31, 31)) {
//						transform.x += sign;
//					}
//					x -= sign;
//				}
//			} else {
//				transform.x += x;
//			}
//			
//			transform.y += y;
//		}
		
//		private function rectCollides(x: int, y: int, width: int, height: int) : Boolean {
//			return _level.collides(x, y) || _level.collides(x + width, y) || _level.collides(x, y + height) || _level.collides(x + width, y + height);
//		}

		// input
		/**
		 * keyPressed 
		 * 
		 * @param key 
		 * @param c 
		 * 
		 * @return 
		 */
		public function keyPressed(key : uint, c : String) : void {
			switch(key) {
				case Keyboard.W:
				case Keyboard.UP:
					_moveUp = true;
					_moveDown = false;
					break;
				// case Keyboard.S:
				// case Keyboard.DOWN:
				// _moveDown = true;
				// _moveUp = false;
				// break;
				case Keyboard.A:
				case Keyboard.LEFT:
					_moveLeft = true;
					_moveRight = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_moveRight = true;
					_moveLeft = false;
					break;
				case Keyboard.SPACE:
					_shoot = true;
					break;
				default:
			}
		}

		/**
		 * keyReleased 
		 * 
		 * @param key 
		 * @param c 
		 * 
		 * @return 
		 */
		public function keyReleased(key : uint, c : String) : void {
			switch(key) {
				case Keyboard.W:
				case Keyboard.UP:
					_moveUp = false;
					break;
				// case Keyboard.S:
				// case Keyboard.DOWN:
				// _moveDown = false;
				// break;
				case Keyboard.A:
				case Keyboard.LEFT:
					_moveLeft = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_moveRight = false;
					break;
				case Keyboard.SPACE:
					_shoot = false;
					break;
				default:
			}
		}

		/**
		 * inputEnded 
		 * 
		 * @return 
		 */
		public function inputEnded() : void {
		}

		/**
		 * inputStarted 
		 * 
		 * @return 
		 */
		public function inputStarted() : void {
		}

		/**
		 * isAcceptingInput 
		 * 
		 * @return 
		 */
		public function isAcceptingInput() : Boolean {
			return true;
		}

		/**
		 * setInput 
		 * 
		 * @param input 
		 * 
		 * @return 
		 */
		public function setInput(input : IKeyInput) : void {
		}
	}
}
