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
	public class CollisionSystem3 extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _playerMapper : ComponentMapper;

		public function CollisionSystem3(g : GameContainer) {
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

			var velocityX : Number = velocity.getX();
			var velocityY : Number = velocity.getY();
			// trace('velocityX: ' + (velocityX), 'velocityY: ' + (velocityY));

			var lX : Number = transform.x + velocityX;
			var rX : Number = lX + collision.width;

			var tY : Number = transform.y + velocityY;
			var bY : Number = tY + collision.height;

			// TODO : only check the ones relevant to current velocities

			// TL, TR, BR, BL
			var collides : Boolean = !level.getWalkable(lX, tY) || !level.getWalkable(rX, tY) || !level.getWalkable(rX, bY) || !level.getWalkable(lX, bY);

			if (collides) {
				var playerRect : Rect = Rect.get(lX, tY, collision.width, collision.height);
				var tileRect : Rect;
				var intersection : Rectangle;
				// var penetrationX : Number;
				// var penetrationY : Number;
				// top left
				var tl : Boolean = !level.getWalkable(lX, tY);
				if (tl) {
					tileRect = level.getTileRect(lX, tY);
					var topLeftCollides : Boolean = playerRect.intersects(tileRect);
					if (topLeftCollides) {
						// penetrationX = tileRect.x + tileRect.width - playerRect.x;
						// trace('1. penetrationX: ' + (penetrationX));

						intersection = playerRect.intersection(tileRect);

//						trace('1. intersection: ' + (intersection));
						if (intersection.height > intersection.width) {
//							trace('a. velocityX: ' + (velocityX));
							velocityX += intersection.width;
//							trace('b. velocityX: ' + (velocityX));
							lX = transform.x + velocityX;
							rX = lX + collision.width;
							playerRect.x = lX;
						}

						// penetrationY = tileRect.y + tileRect.height - playerRect.y;
						// trace('1. penetrationY: ' + (penetrationY));
						intersection = playerRect.intersection(tileRect);
//						trace('2. intersection: ' + (intersection));
						velocityY += intersection.height;
						// trace('velocityY: ' + (velocityY));
						tY = transform.y + velocityY;
						bY = tY + collision.height;
						playerRect.y = tY;
					}
					tileRect.dispose();
				}
				// top right
				var tr : Boolean = !level.getWalkable(rX, tY);
				if (tr) {
					tileRect = level.getTileRect(rX, tY);
					var topRightCollides : Boolean = tr && playerRect.intersects(tileRect);
					if (topRightCollides) {
						intersection = playerRect.intersection(tileRect);
						if (intersection.height > intersection.width) {
							velocityX -= intersection.width;
							lX = transform.x + velocityX;
							rX = lX + collision.width;
							playerRect.x = lX;
						}

						intersection = playerRect.intersection(tileRect);
						velocityY += intersection.height;
						tY = transform.y + velocityY;
						bY = tY + collision.height;
						playerRect.y = tY;

						// penetrationX = playerRect.x + playerRect.width - tileRect.x;
						// penetrationY = tileRect.y + tileRect.height - playerRect.y;
						// trace('2. intersection: ' + (intersection.width), intersection.height);
						// trace('2. penetration: ' + (penetrationX), (penetrationY));
					}
					tileRect.dispose();
				}
				// bottom right
				var br : Boolean = !level.getWalkable(rX, bY);
				if (br) {
					tileRect = level.getTileRect(rX, bY);
					var bottomRightCollides : Boolean = br && playerRect.intersects(tileRect);
					if (bottomRightCollides) {
						intersection = playerRect.intersection(tileRect);
						if (intersection.height > intersection.width) {
							velocityX -= intersection.width;
							lX = transform.x + velocityX;
							rX = lX + collision.width;
							playerRect.x = lX;
						}
						intersection = playerRect.intersection(tileRect);
						velocityY -= intersection.height;
						tY = transform.y + velocityY;
						bY = tY + collision.height;
						playerRect.y = tY;

						// penetrationX = playerRect.x + playerRect.width - tileRect.x;
						// penetrationY = playerRect.y + playerRect.width - tileRect.y;
						// trace('3. intersection: ' + (intersection.width), intersection.height);
						// trace('3. penetration: ' + (penetrationX), (penetrationY));
					}
					tileRect.dispose();
				}
				// bottom left
				var bl : Boolean = !level.getWalkable(lX, bY);
				if (bl) {
					tileRect = level.getTileRect(lX, bY);
					var bottomLeftCollides : Boolean = bl && playerRect.intersects(tileRect);
					if (bottomLeftCollides) {
						intersection = playerRect.intersection(tileRect);
						if (intersection.height > intersection.width) {
							velocityX += intersection.width;
							lX = transform.x + velocityX;
							rX = lX + collision.width;
							playerRect.x = lX;
						}

						intersection = playerRect.intersection(tileRect);
						velocityY -= intersection.height;
						tY = transform.y + velocityY;
						bY = tY + collision.height;
						playerRect.y = tY;
						// penetrationX = tileRect.x + tileRect.width - playerRect.x;
						// penetrationY = playerRect.y + playerRect.width - tileRect.y;
						// trace('4. intersection: ' + (intersection.width), intersection.height);
						// trace('4. penetration: ' + (penetrationX), (penetrationY));
						// trace(intersection.width > intersection.height);
					}
					tileRect.dispose();
				}
				playerRect.dispose();
				// trace('TL:' + (topLeftCollides), 'TR:' + (topRightCollides), 'BR:' + (bottomRightCollides), 'BL:' + (bottomLeftCollides));
				// trace('tl: ' + (tl), 'tr: ' + (tr), 'br: ' + (br), 'bl: ' + (bl));
			}

			// trace('velocityX: ' + (velocityX), 'velocityY: ' + (velocityY));
			velocity.setX(velocityX);
			velocity.setY(velocityY);

			transform.addX(velocity.getX());
			transform.addY(velocity.getY());
		}
	}
}
