package me.ianmcgregor.fight.factories {
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	/**
	 * @author ianmcgregor
	 */
	public final class BodyFactory {
		
		/**
		 * createGround 
		 * 
		 * @param x 
		 * @param y 
		 * @param width 
		 * @param height 
		 * 
		 * @return 
		 */
		static public function createGround(x : Number, y : Number, width : Number, height : Number) : Body {
			var body : Body = new Body(BodyType.STATIC, Vec2.weak(x, y));
			body.userData.isGround = true;
			var shape : Polygon = new Polygon(Polygon.rect(0, 0, width, height));
			body.shapes.add(shape);
			return body;
		}
		
		/**
		 * createHero 
		 * 
		 * @return 
		 */
		static public function createHero() : Body {
			var x: int = 16;
			var w: int = 32;
			var h: int = 68;
			var body : Body = new Body(BodyType.DYNAMIC);
			var shape : Shape = new Polygon(Polygon.rect(x, 0, w, h-2));
			shape.material.dynamicFriction = 0;
			shape.material.staticFriction = 0;
			shape.filter.collisionGroup = 2;
			shape.filter.collisionMask = ~2;
			body.shapes.add(shape);
			var feet : Shape = new Polygon(Polygon.rect(x + 10, h - 2, w - 20, 2));
			feet.filter.collisionGroup = 2;
			feet.filter.collisionMask = ~2;
			body.shapes.add(feet);
			body.userData.feet = feet;
			body.allowRotation = false;
			// fist
			var fist : Shape = new Polygon(Polygon.rect(4, h * 0.5 - 4, w + 24, 12));
			fist.material = new Material(10, 10, 10, 10);
			body.userData.fist = fist;
			return body;
		}
		
		/**
		 * Boss
		 */
		static public function createBoss() : Body {
			var body : Body = new Body(BodyType.DYNAMIC);
			var shape : Shape = new Polygon(Polygon.rect(0, 0, 64, 64));
			shape.material = Material.rubber();
			body.shapes.add(shape);
			body.allowRotation = false;
			return body;
		}

		public static function createBadGuy() : Body {
			var x: int = 16;
			var w: int = 32;
			var h: int = 68;
			var body : Body = new Body(BodyType.DYNAMIC);
			body.allowRotation = false;
			// body
			var shape : Shape = new Polygon(Polygon.rect(x, 0, w, h-2));
			shape.material.dynamicFriction = 0;
			shape.material.staticFriction = 0;
			shape.filter.collisionGroup = 2;
			shape.filter.collisionMask = ~2;
			body.shapes.add(shape);
			// feet
			var feet : Shape = new Polygon(Polygon.rect(x + 10, h - 2, w - 20, 2));
			feet.filter.collisionMask = ~2;
			feet.filter.collisionGroup = 2;
			body.shapes.add(feet);
			body.userData.feet = feet;
			// fist
			var fist : Shape = new Polygon(Polygon.rect(4, h * 0.5 - 4, w + 24, 12));
			fist.material = new Material(10, 10, 10, 10);
			body.userData.fist = fist;
			return body;
		}
	}
}
