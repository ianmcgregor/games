package me.ianmcgregor.pong.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.pong.components.CollisionRect;
	import me.ianmcgregor.pong.components.Velocity;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;


	/**
	 * @author McFamily
	 */
	public class BallMovementSystem extends EntityProcessingSystem {
		
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _rectMapper 
		 */
		private var _rectMapper : ComponentMapper;

		/**
		 * BallMovementSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function BallMovementSystem(container : GameContainer) {
			_container = container;
			super(TransformComponent, [Velocity, CollisionRect]);
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_rectMapper = new ComponentMapper(CollisionRect, _world);
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
			var rect: CollisionRect = _rectMapper.get(e);

			transform.addX( velocity.velocityX * ( _world.getDelta() * 300 ) );
			transform.addY( velocity.velocityY * ( _world.getDelta() * 300 ) );

			/**
			 * maxX 
			 */
			var maxX : int = _container.getWidth() - rect.rect.width;
			if (transform.x > maxX) transform.x = maxX;
			if (transform.x < 0) transform.x = 0;

			/**
			 * maxY 
			 */
			var maxY : int = _container.getHeight() - rect.rect.height;
			if (transform.y < 0) transform.y = 0;
			if (transform.y > maxY) transform.y =maxY;

			if (transform.x >= maxX || transform.x <= 0) {
				velocity.velocityX *= -1;
			}
			
			if (transform.y >= maxY || transform.y <= 0) {
				velocity.velocityY *= -1;
			}
			
			/**
			 * minVelocity 
			 */
			var minVelocity: Number = 0.4;
			if (velocity.velocityY < 0 && velocity.velocityY > -minVelocity) velocity.velocityY = -minVelocity;
			if (velocity.velocityY > 0 && velocity.velocityY < minVelocity) velocity.velocityY = minVelocity;
			if(velocity.velocityY > 1) velocity.velocityY = 1;
			if (velocity.velocityY < -1) velocity.velocityY = -1;
		}
	}
}
