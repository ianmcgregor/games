package me.ianmcgregor.games.utils.nape {
	import me.ianmcgregor.games.utils.math.MathUtils;

	import nape.dynamics.Arbiter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	import flash.display.BitmapData;

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
		
		/**
		 * Using MarchingSquares to generate Nape bodies from a BitmapData
		 */
		public static function bodyFromBitmapData(bitmapData : BitmapData, alphaThreshold : Number = 0x80, granularity : Vec2 = null, quality : int = 2, simplification : Number = 1.5) : Body {
			var iso : BitmapDataIso = new BitmapDataIso(bitmapData, alphaThreshold);
			return IsoBody.run(iso, iso.bounds, granularity, quality, simplification);
			
			/*
		var graphicOffset:Vec2 = body.userData.graphicOffset;
        var position:Vec2 = body.localPointToWorld(graphicOffset);
		 */
		}
		
		/**
		 * clone body
		 */
		public static function cloneBody(b: Body): Body {
			return b.copy();
		}
		
		[Inline]
		public static function move(body : Body, delta : Number, left : Boolean, right : Boolean, up : Boolean, down : Boolean, angularDampening : Number = 0.15, rotationIncrement : Number = 0.07, maxVelocity : Number = 60, impulse : Number = 30) : void {
				body.angularVel *= angularDampening;
				body.angularVel *= angularDampening;
			if (left) {
				body.rotation -= rotationIncrement;
			} else if (right) {
				body.rotation += rotationIncrement;
			}
			if (up || down) {
				var mass : Number = body.mass;
				var maxVelocityXMass : Number = mass * maxVelocity;
				var impulseStrength : Number = mass * impulse;
				var rotation: Number = body.rotation;
				if(down) rotation += Math.PI;
				var vec2 : Vec2 = Vec2.fromPolar(impulseStrength, rotation);
				body.applyImpulse(vec2);
				vec2.dispose();
				// limit
				if (body.velocity.length > maxVelocityXMass) {
					body.velocity.length = maxVelocityXMass;
				}
			} else {
				// dampening : 1 = no dampening 0 = total dampening
				var dampening : Number = 0.5;
				var damp : Number = Math.pow(dampening, delta);
				body.velocity.muleq(damp);
				body.angularVel *= damp;
			}
		}
		
		[Inline]
		public static function clampPosition(body: Body, minX: Number, maxX: Number, minY: Number, maxY: Number) : void {
			// clamp X
			if(body.position.x < minX || body.position.x > maxX) body.velocity.x = 0;
			body.position.x = MathUtils.clamp(body.position.x, minX, maxX);
			
			// clamp Y
			if(body.position.y < minY || body.position.y > maxY) body.velocity.y = 0;
			body.position.y = MathUtils.clamp(body.position.y, minY, maxY);
		}
		
		[Inline]
		public static function push(pusher: Body, pushed: Body, impulseStrength: Number): void {
			var angle: Number = MathUtils.angle(pusher.position.x, pusher.position.y, pushed.position.x, pushed.position.y);
			var impulseVec : Vec2 = Vec2.fromPolar(impulseStrength, angle);
			pushed.applyImpulse(impulseVec);
			impulseVec.dispose();
		}

		[Inline]
		public static function getAngle(b1: Body, b2: Body): Number {
			var dx : Number = b1.position.x - b2.position.x;
			var dy : Number = b1.position.y - b2.position.y;
			return Math.atan2(dy, dx);
		}
	}
}
import nape.geom.AABB;
import nape.geom.GeomPoly;
import nape.geom.GeomPolyList;
import nape.geom.IsoFunction;
import nape.geom.MarchingSquares;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.shape.Polygon;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
/**
 * Helpers for bodyFromBitmapData
 */
 
 


class IsoBody {
	public static function run(iso : IsoFunction, bounds : AABB, granularity : Vec2 = null, quality : int = 2, simplification : Number = 1.5) : Body {
		var body : Body = new Body();

		if (granularity == null) granularity = Vec2.weak(8, 8);
		var polys : GeomPolyList = MarchingSquares.run(iso, bounds, granularity, quality);
		var l : int = polys.length;
		for (var i : int = 0; i < l; ++i) {
			var p : GeomPoly = polys.at(i);

			var qolys : GeomPolyList = p.simplify(simplification).convexDecomposition(true);
			var len : int = qolys.length;
			for (var j : int = 0; j < len; ++j) {
				var q : GeomPoly = qolys.at(j);

				body.shapes.add(new Polygon(q));

				// Recycle GeomPoly and its vertices
				q.dispose();
			}
			// Recycle list nodes
			qolys.clear();

			// Recycle GeomPoly and its vertices
			p.dispose();
		}
		// Recycle list nodes
		polys.clear();

		// Align body with its centre of mass.
		// Keeping track of our required graphic offset.
		var pivot : Vec2 = body.localCOM.mul(-1);
		body.translateShapes(pivot);

		body.userData.graphicOffset = pivot;
		
		return body;
	}
}

class BitmapDataIso implements IsoFunction {
	public var bitmap : BitmapData;
	public var alphaThreshold : Number;
	public var bounds : AABB;

	public function BitmapDataIso(bitmap : BitmapData, alphaThreshold : Number = 0x80) : void {
		this.bitmap = bitmap;
		this.alphaThreshold = alphaThreshold;
		bounds = new AABB(0, 0, bitmap.width, bitmap.height);
	}

	public function graphic() : DisplayObject {
		return new Bitmap(bitmap);
	}

	public function iso(x : Number, y : Number) : Number {
		// Take 4 nearest pixels to interpolate linearly.
		// This gives us a smooth iso-function for which
		// we can use a lower quality in MarchingSquares for
		// the root finding.

		var ix : int = int(x);
		var iy : int = int(y);
		// clamp in-case of numerical inaccuracies
		if (ix < 0) ix = 0;
		if (iy < 0) iy = 0;
		if (ix >= bitmap.width) ix = bitmap.width - 1;
		if (iy >= bitmap.height) iy = bitmap.height - 1;

		// iso-function values at each pixel centre.
		var a11 : Number = alphaThreshold - (bitmap.getPixel32(ix, iy) >>> 24);
		var a12 : Number = alphaThreshold - (bitmap.getPixel32(ix + 1, iy) >>> 24);
		var a21 : Number = alphaThreshold - (bitmap.getPixel32(ix, iy + 1) >>> 24);
		var a22 : Number = alphaThreshold - (bitmap.getPixel32(ix + 1, iy + 1) >>> 24);

		// Bilinear interpolation for sample point (x,y)
		var fx : Number = x - ix;
		var fy : Number = y - iy;
		return a11 * (1 - fx) * (1 - fy) + a12 * fx * (1 - fy) + a21 * (1 - fx) * fy + a22 * fx * fy;
	}
}
