package me.ianmcgregor.chick.factories {
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
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
			/**
			 * body 
			 */
			var body : Body = new Body(BodyType.STATIC, Vec2.weak(x, y));
			body.userData.isGround = true;
			/**
			 * shape 
			 */
			var shape : Polygon = new Polygon(Polygon.rect(0, 0, width, height));
//			shape.material.elasticity = 1;
//			shape.material.density = 1;
//			shape.material.staticFriction = 1;
			body.shapes.add(shape);
//			shape.filter.collisionGroup = 8;
//			shape.filter.collisionMask = ~8;
			shape.material = Material.steel();
//			shape.material = Material.rubber();
//			shape.filter.collisionGroup = 2;
			return body;
		}
		
		/**
		 * createHero 
		 * 
		 * @return 
		 */
		static public function createHero() : Body {
			var body : Body = new Body(BodyType.DYNAMIC);
//			var shape : Shape = NapeUtils.getTriangle(30);
			var shape : Shape = new Polygon(Polygon.rect(2, 0, 28, 32));
//			shape.filter.collisionMask = ~2;
			shape.material = Material.wood();
			body.shapes.add(shape);
			var feet : Shape = new Polygon(Polygon.rect(4, 30, 24, 2));
			feet.material = Material.wood();
			body.shapes.add(feet);
			body.userData.feet = feet;
			// shape.material = new Material(1,5);
			// shape.filter.collisionGroup = 2;
//			shape.filter.collisionGroup = 4;
			body.allowRotation = false;
			return body;
		}
		
		/**
		 * Egg
		 */
		static public function createEgg() : Body {
			var body : Body = new Body(BodyType.DYNAMIC);
			var shape : Circle = new Circle(16);
			shape.material = Material.rubber();
			body.shapes.add(shape);
			body.userData.isGround = true;
			shape.filter.collisionGroup = 4;
			return body;
		}
		
		/**
		 * Wire
		 */
		static public function createWire() : Body {
			var body : Body = new Body(BodyType.DYNAMIC);
			var shape : Shape = new Polygon(Polygon.rect(0, 0, 32, 64));
			shape.material = Material.rubber();
			body.shapes.add(shape);
			body.allowRotation = false;
			shape.filter.collisionMask = ~4;
			return body;
		}
		/**
		 * Mama
		 */
		static public function createMama() : Body {
			var body : Body = new Body(BodyType.DYNAMIC);
			var shape : Shape = new Polygon(Polygon.rect(0, 0, 64, 64));
			shape.material = Material.rubber();
			body.shapes.add(shape);
			body.allowRotation = false;
			return body;
		}
	}
}
