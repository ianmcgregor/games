package me.ianmcgregor.pong.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.pong.components.CollisionRect;
	import me.ianmcgregor.pong.components.Velocity;
	import me.ianmcgregor.pong.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author McFamily
	 */
	public class CollisionSystem extends EntityProcessingSystem {
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _velocityMapper 
		 */
		private var _velocityMapper : ComponentMapper;
		/**
		 * _rectMapper 
		 */
		private var _rectMapper : ComponentMapper;
		/**
		 * CollisionSystem 
		 */
		public function CollisionSystem() {
			super(TransformComponent, [CollisionRect]);
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
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
			
			/**
			 * ball 
			 */
			var ball : Entity = _world.getTagManager().getEntity(EntityTag.BALL);
			/**
			 * player 
			 */
			var player : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER);
			/**
			 * enemy 
			 */
			var enemy : Entity = _world.getTagManager().getEntity(EntityTag.ENEMY);
			/**
			 * ballVelocity 
			 */
			var ballVelocity: Velocity = _velocityMapper.get(ball);
			/**
			 * ballTransformComponent 
			 */
			var ballTransformComponent : TransformComponent = _transformMapper.get(ball);
			if(ballVelocity.velocityX < 0 && collisionExists(ball, player)){
				/**
				 * playerTransformComponent 
				 */
				var playerTransformComponent : TransformComponent = _transformMapper.get(player);
				updateBallVelocity(ballVelocity, ballTransformComponent, playerTransformComponent);
			} 
			else if(ballVelocity.velocityX > 0 && collisionExists(ball, enemy)){
				/**
				 * enemyTransformComponent 
				 */
				var enemyTransformComponent : TransformComponent = _transformMapper.get(enemy);
				updateBallVelocity(ballVelocity, ballTransformComponent, enemyTransformComponent);
			}
		}

		/**
		 * updateBallVelocity 
		 * 
		 * @param ballVelocity 
		 * @param ballTransformComponent 
		 * @param playerTransformComponent 
		 * 
		 * @return 
		 */
		private function updateBallVelocity(ballVelocity : Velocity, ballTransformComponent : TransformComponent, playerTransformComponent : TransformComponent) : void {
			ballVelocity.velocityX *= -1;
			ballVelocity.velocityY = map(ballTransformComponent.y - playerTransformComponent.y, -20, 60, -1, 1);
//			var minVelocity: Number = 0.4;
//			if (ballVelocity.velocityY < 0 && ballVelocity.velocityY > -minVelocity) ballVelocity.velocityY = -minVelocity;
//			if (ballVelocity.velocityY > 0 && ballVelocity.velocityY < minVelocity) ballVelocity.velocityY = minVelocity;
//			if(ballVelocity.velocityY > 1) ballVelocity.velocityY = 1;
//			if(ballVelocity.velocityY < -1) ballVelocity.velocityY = -1;
		}
		
		/**
		 * map 
		 * 
		 * @param v 
		 * @param a 
		 * @param b 
		 * @param x 
		 * @param y 
		 * 
		 * @return 
		 */
		private function map(v:Number, a:Number, b:Number, x:Number = 0, y:Number = 1):Number {
		    return (v == a) ? x : (v - a) * (y - x) / (b - a) + x;
		}
		
		/**
		 * collisionExists 
		 * 
		 * @param e1 
		 * @param e2 
		 * 
		 * @return 
		 */
		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			/**
			 * t1 
			 */
			var t1 : TransformComponent = _transformMapper.get(e1);
			/**
			 * t2 
			 */
			var t2 : TransformComponent = _transformMapper.get(e2);
			/**
			 * r1 
			 */
			var r1 : CollisionRect = _rectMapper.get(e1);
			/**
			 * r2 
			 */
			var r2 : CollisionRect = _rectMapper.get(e2);
			
			r1.rect.x = t1.x;
			r1.rect.y = t1.y;
			
			r2.rect.x = t2.x;
			r2.rect.y = t2.y;
			
			return r1.rect.intersects(r2.rect);
		}
	}
}
