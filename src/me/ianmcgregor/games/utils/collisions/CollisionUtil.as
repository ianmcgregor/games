package me.ianmcgregor.games.utils.collisions {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.utils.display.Rect;
	import me.ianmcgregor.rogue.components.CollisionComponent;
	import me.ianmcgregor.rogue.constants.Constants;

	import com.artemis.Entity;
	import com.artemis.utils.IImmutableBag;
	/**
	 * @author ianmcgregor
	 */
	public final class CollisionUtil {

		public static function resolveCollisions(entity : Entity, entities : IImmutableBag, callBack : Function) : void {
			var l : int = entities.size();
			for (var i : int = 0; i < l; ++i) {
				var e : Entity = entities.get(i);
				check(entity, e, callBack);
			}
		}

		private static function check(e1 : Entity, e2 : Entity, callBack : Function) : void {
			var t1 : TransformComponent = e1.getComponent(TransformComponent);
			var t2 : TransformComponent = e2.getComponent(TransformComponent);
			
			var x: Number = t2.x;
			var y: Number = t2.y;
			var width: Number = Constants.TILE_SIZE;
			var height: Number = Constants.TILE_SIZE;
			var collision: CollisionComponent = e2.getComponent(CollisionComponent);
			if( collision ) {
				x += collision.x;
				y += collision.y;
				width = collision.width;
				height = collision.height;
			}
			var r1: Rect = Rect.get(t1.x, t1.y, Constants.TILE_SIZE, Constants.TILE_SIZE);
			var r2: Rect = Rect.get(x, y, width, height);
//			if( r1.intersects(r2) && r1.getIntersectionPercent(r2) > minIntersection ) {
			if( r1.intersects(r2) ) {
//				trace('collision', r1.getIntersectionArea(r2), " of ",(r1.width * r1.height), '', r1.getIntersectionPercent(r2).toFixed(2));
				callBack(e1,e2,r1,r2,r1.getIntersectionPercent(r2));
			}
			r1.dispose();
			r2.dispose();
		}
	}
}
