package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Rect;
	import me.ianmcgregor.rogue.components.CollisionComponent;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.EntityTag;

	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public class CollisionSystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _level : LevelComponent;

		public function CollisionSystem(g : GameContainer) {
			super(CollisionComponent, [TransformComponent, VelocityComponent]);
			_g = g;
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_level = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var transform : TransformComponent = e.getComponent(TransformComponent);
			var velocity : VelocityComponent = e.getComponent(VelocityComponent);
			var collision : CollisionComponent = e.getComponent(CollisionComponent);
			
			// x
			var tile : Rect;
			var bottom : int;
			var left : int;
			var top : int;
			var right : int;
			var x: Number;
			var y: Number;
			var velocityX : Number = velocity.getX();
			
			// left
			if (velocityX < 0) {
				x = transform.x + collision.x;
				y = transform.y + collision.y;
				left = _level.getGridColumn(x + velocityX);
				top = _level.getGridRow(y);
				bottom = _level.getGridRow(y + collision.height);
			
				if(!_level.isWalkable(left, top)) {
					tile = _level.getTileRect2(left, top);
//					if (x + velocityX < tile.x + tile.width) {
						velocity.setX(tile.x + tile.width - x);
//					}
					tile.dispose();
				} else if(!_level.isWalkable(left, bottom)) {
					tile = _level.getTileRect2(left, bottom);
//					if(x + velocityX < tile.x + tile.width) {
						velocity.setX(tile.x + tile.width - x);
//					}
					tile.dispose();
				}
			// right	
			} else if(velocityX > 0){
				x = transform.x + collision.x;
				y = transform.y + collision.y;
				right = _level.getGridColumn(x + collision.width + 1 + velocityX);
				top = _level.getGridRow(y);
				bottom = _level.getGridRow(y + collision.height);
			
				if (!_level.isWalkable(right, top)) {
					tile = _level.getTileRect2(right, top);
//					if (x + collision.width + velocityX > tile.x) {
						velocity.setX(tile.x - x - collision.width - 1);
//					}
					tile.dispose();
				} else if(!_level.isWalkable(right, bottom)) {
					tile = _level.getTileRect2(right, bottom);
//					if(x + collision.width + velocityX > tile.x) {
						velocity.setX(tile.x - x - collision.width - 1);
//					}
					tile.dispose();
				}
			}
			transform.addX(velocity.getX());
			
			// y
			
			var velocityY : Number = velocity.getY();
			// up
			if(velocityY < 0) {
				x = transform.x + collision.x;
				y = transform.y + collision.y;
				top = _level.getGridRow(y + velocityY);
				left = _level.getGridColumn(x);
				right = _level.getGridColumn(x + collision.width);
			
				if(!_level.isWalkable(left, top)) {
					tile = _level.getTileRect2(left, top);
//					if (y + velocityY < tile.y + tile.height) {
						velocity.setY(tile.y + tile.height - y);
//					}
					tile.dispose();
				} else if(!_level.isWalkable(right, top)) {
					tile = _level.getTileRect2(right, top);
//					if (y + velocityY < tile.y + tile.height) {
						velocity.setY(tile.y + tile.height - y);
//					}
					tile.dispose();
				}
			// down
			} else if(velocityY > 0){
				x = transform.x + collision.x;
				y = transform.y + collision.y;
				bottom = _level.getGridRow(y + collision.height + 1 + velocityY);
				left = _level.getGridColumn(x);
				right = _level.getGridColumn(x + collision.width);
			
				if(!_level.isWalkable(left, bottom)) {
					tile = _level.getTileRect2(left, bottom);
//					if (y + collision.height + velocityY > tile.y) {
						velocity.setY(tile.y - y - collision.height - 1);
//					}
					tile.dispose();
				} else if(!_level.isWalkable(right, bottom)) {
					tile = _level.getTileRect2(right, bottom);
//					if (y + collision.height + velocityY > tile.y) {
						velocity.setY(tile.y - y - collision.height - 1);
//					}
					tile.dispose();
				}
			}
			
			transform.addY(velocity.getY());
		}
	}
}
