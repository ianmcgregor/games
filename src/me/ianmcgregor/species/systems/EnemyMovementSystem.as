package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.components.CollisionRect;
	import me.ianmcgregor.species.components.Enemy;
	import me.ianmcgregor.species.components.Level;
	import me.ianmcgregor.species.components.Velocity;
	import me.ianmcgregor.species.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.utils.getTimer;


	/**
	 * @author McFamily
	 */
	public class EnemyMovementSystem extends EntityProcessingSystem {
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
		private const MIN_DISTANCE : int = 1;
		/**
		 * _levelMapper 
		 */
		private var _levelMapper : ComponentMapper;
		/**
		 * _isJumping 
		 */
		private var _isJumping : Boolean;
		/**
		 * _jumpPower 
		 */
		private var _jumpPower : Number;
		/**
		 * _moveUpTime 
		 */
		private var _moveUpTime : int;
		/**
		 * _jumpedAt 
		 */
		private var _jumpedAt : int;
		/**
		 * _rectMapper 
		 */
		private var _rectMapper : ComponentMapper;
		
		/**
		 * EnemyMovementSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function EnemyMovementSystem(container : GameContainer) {
			super(TransformComponent, [Enemy]);
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
			_rectMapper = new ComponentMapper(CollisionRect, _world);
			_jumpedAt = getTimer();
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
			/**
			 * level 
			 */
			var level: Level = _levelMapper.get(levelEntity);
			/**
			 * transform 
			 */
			var transform : TransformComponent = _transformMapper.get(e);
			/**
			 * rect 
			 */
			var rect : CollisionRect = _rectMapper.get(e);
			/**
			 * velocity 
			 */
			var velocity : Velocity = _velocityMapper.get(e);
			velocity.velocityX = velocity.velocityY = 0;
			if(velocity.speed == 0) {
				velocity.speed = 60 + Math.random() * 4;
			}
			/**
			 * hero 
			 */
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			/**
			 * heroTransform 
			 */
			var heroTransform : TransformComponent = _transformMapper.get(hero);
			/**
			 * distance 
			 */
			var distance: int = transform.getDistanceTo(heroTransform);
			/**
			 * approach 
			 */
			var approach : Boolean = distance > 20 && distance < 320;
			
			/**
			 * moveUp 
			 */
			var moveUp : Boolean;
			/**
			 * moveDown 
			 */
			var moveDown : Boolean;
			/**
			 * moveLeft 
			 */
			var moveLeft : Boolean;
			/**
			 * moveRight 
			 */
			var moveRight : Boolean;
			if( approach ) {
				//moveUp = heroTransform.y < transform.y - MIN_DISTANCE;
				//moveDown = heroTransform.y > transform.y + MIN_DISTANCE;
				moveLeft = heroTransform.x < transform.x - MIN_DISTANCE;
				moveRight = heroTransform.x > transform.x + 32 + MIN_DISTANCE;
				var amount : Number = _world.getDelta() * velocity.speed;
				

				var x: int = rect.rect.x + transform.x;
				var y: int = rect.rect.y + transform.y;
				var w: int = rect.rect.width;
				var h: int = rect.rect.height;
				
				
//				var topLeft : Boolean = level.collides(x, y);
//				var topRight : Boolean = level.collides(x + w, y);
//				var bottomLeft : Boolean = level.collides(x, y + h);
//				var bottomRight : Boolean = level.collides(x + w, y + h);

			//	var bottomLeft : Boolean = level.collides(transform.x + rect.rect.x, transform.y + rect.rect.height * 0.9);
				//var bottomRight : Boolean = level.collides(transform.x + rect.rect.width + rect.rect.x, transform.y + rect.rect.height * 0.9);
				var bottomLeft : Boolean = level.collides(transform.x + rect.rect.x, transform.y + rect.rect.y + rect.rect.height + 1);
				var bottomRight : Boolean = level.collides(transform.x + rect.rect.width + rect.rect.x, transform.y + rect.rect.y + rect.rect.height + 1);
				
				if (moveLeft) {
					velocity.velocityX = -amount;
				} else if(moveRight) {
					velocity.velocityX = amount;
				} 
				
				if(moveLeft && level.collides(x + velocity.velocityX, transform.y + rect.rect.height - 1)) {
					moveUp = true;
				}
				
				if(moveRight && level.collides(x + w + velocity.velocityX, transform.y + rect.rect.height - 1)) {
					moveUp = true;
				}
				
				if(!_isJumping && !bottomLeft && !bottomRight) {
					moveDown = true;
				}
	
				
//				trace('getTimer() - _jumpedAt: ' + (getTimer() - _jumpedAt));
				if (_isJumping) {
					_jumpPower -= 50;
					velocity.velocityY = _world.getDelta() * -_jumpPower;
					if(getTimer() - _moveUpTime > 200){
						_isJumping = false;
					}
				} else  if (getTimer() - _jumpedAt > 1000 && moveUp && ( level.collides(x, y + h + 2 ) || level.collides(x + w, y + h + 2 ) )) {
//					trace('>> jump! <<');
					_jumpPower = 400;
					velocity.velocityY = _world.getDelta() * -_jumpPower;
					_isJumping = true;
					moveDown = false;
					_moveUpTime = _jumpedAt = getTimer();
				} 
				if(moveDown) {
					velocity.velocityY = amount;
				}
			}
		}
	}
}
