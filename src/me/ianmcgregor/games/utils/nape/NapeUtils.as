package me.ianmcgregor.games.utils.nape {
	import nape.dynamics.Arbiter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	/**
	 * @author ianmcgregor
	 */
	public final class NapeUtils {
		
		public static function scaleCircle(scale : Number, b : Body, originalRadius: Number) : void {
			var currentScale : Number = b.shapes.at(0).castCircle.radius / originalRadius;
			var newScale : Number = scale / currentScale;
			b.scaleShapes(newScale, newScale);
		}
		
		public static function scaleBody(body : Body, scaleX : Number, scaleY : Number = NaN): void {
			if( isNaN(scaleY) ) scaleY = scaleX;
			body.scaleShapes(scaleX, scaleY);
		}
		
		public static function rotateBodyAboutPoint(body:Body, anchor:Vec2, angle:Number): void {
		    var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
		    var dx:Number = body.position.x - anchor.x;
			var dy:Number = body.position.y - anchor.y;
		
		    body.rotation += angle;
		    body.position.x = anchor.x + cos * dx - sin * dy;
		    body.position.y = anchor.y + sin * dx + cos * dy;
		}
		
		public static function getTriangle(baseSize: Number): Shape {
			var vertices : Vector.<Vec2> = new <Vec2>[];
			var halfSize: Number = baseSize * 0.5;
			vertices[vertices.length] = new Vec2(0, -halfSize);
			vertices[vertices.length] = new Vec2(halfSize, halfSize);
			vertices[vertices.length] = new Vec2(-halfSize, halfSize);
			var polygon : Polygon = new Polygon(vertices);
			polygon.rotate(Math.PI * 0.5); // point right
			return polygon;
		}
		
		public static function getOnGround(playerBody: Body, playerFeet: Shape): Boolean {
//				trace('playerBody.arbiters: ' + (playerBody.arbiters));
			var onGround: Boolean = false;
			var i: int = playerBody.arbiters.length;
			while (--i > -1) {
				var a : Arbiter = playerBody.arbiters.at(i);
				if (a.isCollisionArbiter() && (a.shape1 == playerFeet || a.shape2 == playerFeet)) {
					var otherBody : Body = (a.body1 == playerBody ? a.body2 : a.body1);
					if (otherBody.userData.isGround) {
						onGround = true;
						break;
					}
				}
			}
			return onGround;
		}
		// 1 = no dampening 0 = total dampening
		public static function dampenVelocity(body: Body, dampening: Number, delta: Number) : void {
//			var dampening : Number = 0.5;
			var damp : Number = Math.pow(dampening, delta);
			body.velocity.muleq(damp);
			body.angularVel *= damp;
		}
	}
}
