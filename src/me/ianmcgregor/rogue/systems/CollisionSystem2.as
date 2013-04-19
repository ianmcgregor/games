package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Rect;
	import me.ianmcgregor.rogue.components.CollisionComponent;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.geom.Rectangle;

	/**
	 * @author ianmcgregor
	 */
	public class CollisionSystem2 extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _playerMapper : ComponentMapper;

		public function CollisionSystem2(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			// _someComponent = _someMapper.get(_world.getTagManager().getEntity(EntityTag.SOME_TAG));
			// var bag: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.SOME_GROUP);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var level : LevelComponent = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
			/**
			 * player 
			 */
			// var player: PlayerComponent = _playerMapper.get(e);
			var transform : TransformComponent = e.getComponent(TransformComponent);
			var velocity : VelocityComponent = e.getComponent(VelocityComponent);
			var collision : CollisionComponent = e.getComponent(CollisionComponent);
			

			// TODO : only check the ones relevant to current velocities
			
			var topLeft: Rect = level.getWalkableTileRect(transform.x + velocity.getX(), transform.y + velocity.getY());
			if( topLeft )
				collide(topLeft, transform, velocity, collision);

			var topRight: Rect = level.getWalkableTileRect(transform.x + velocity.getX() + collision.width, transform.y + velocity.getY());
			if( topRight )
				collide(topRight, transform, velocity, collision);

			var bottomRight: Rect = level.getWalkableTileRect(transform.x + velocity.getX() + collision.width, transform.y + velocity.getY() + collision.height);
			if( bottomRight )
				collide(bottomRight, transform, velocity, collision);
			
			var bottomLeft: Rect = level.getWalkableTileRect(transform.x + velocity.getX(), transform.y + velocity.getY() + collision.height);
			if( bottomLeft )
				collide(bottomLeft, transform, velocity, collision);
			
			transform.addX(velocity.getX());
			transform.addY(velocity.getY());
			trace('velocity.getX(): ' + (velocity.getX()), 'velocity.getY(): ' + (velocity.getY()));
		}
		
		private function collide(tileRect: Rect, transform: TransformComponent, velocity : VelocityComponent, collision: CollisionComponent): void {
			var playerRect : Rect = Rect.get(transform.x + velocity.getX(), transform.y + velocity.getY(), collision.width, collision.height);
			
			var intersects : Boolean = playerRect.intersects(tileRect);
			if (intersects) {
				var intersection : Rectangle = playerRect.intersection(tileRect);
//				trace('intersection: ' + (intersection));

				if (intersection.height > intersection.width) {
					var vX: Number = tileRect.x < playerRect.x ? intersection.width : -intersection.width;
					velocity.addX(vX);
					playerRect.x = transform.x + velocity.getX();
				}

				intersection = playerRect.intersection(tileRect);
				var vY: Number = tileRect.y < playerRect.y ? intersection.height : -intersection.height;
				velocity.addY(vY);
			}
			tileRect.dispose();
			playerRect.dispose();
		}
	}
}
