package me.ianmcgregor.pong.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.pong.components.Enemy;
	import me.ianmcgregor.pong.components.Velocity;
	import me.ianmcgregor.pong.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;


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
		/**
		 * _moveTo 
		 */
		private var _moveTo : int = -1;
		
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
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
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
			 * ball 
			 */
			var ball : Entity = _world.getTagManager().getEntity(EntityTag.BALL);
			/**
			 * ballTransformComponent 
			 */
			var ballTransformComponent : TransformComponent = _transformMapper.get(ball);
			/**
			 * ballVelocity 
			 */
			var ballVelocity : Velocity = _velocityMapper.get(ball);
			/**
			 * ballApproaching 
			 */
			var ballApproaching : Boolean = ballVelocity.velocityX > 0;
			
			/**
			 * moveUp 
			 */
			var moveUp : Boolean;
			/**
			 * moveDown 
			 */
			var moveDown : Boolean;

			if(ballApproaching){
				_moveTo = -1;
				moveUp = ballTransformComponent.y < transform.y - 10;
				moveDown = ballTransformComponent.y > transform.y + 10;
			} else if(ballTransformComponent.x < _container.getWidth() - 200) {
				if( _moveTo == -1) {
					_moveTo = 100 + int(280 * Math.random());
				}
				moveUp = _moveTo < transform.y - 10;
				moveDown = _moveTo > transform.y + 10;
			}
			
			if (moveUp) {
				transform.addY(_world.getDelta() * -300);
			} else if(moveDown) {
				transform.addY(_world.getDelta() * 300);
			}
			// clamp
			if (transform.y < 0) {
				transform.y = 0;
			} else if(transform.y > _container.getHeight() - 60) {
				transform.y = _container.getHeight() - 60;
			}
		}
	}
}
