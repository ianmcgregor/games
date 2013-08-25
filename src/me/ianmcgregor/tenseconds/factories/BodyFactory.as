package me.ianmcgregor.tenseconds.factories {
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.games.utils.collections.ObjectPool;
	import me.ianmcgregor.games.utils.collections.UniqueObjectPool;
	import me.ianmcgregor.games.utils.math.MathUtils;

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
		static public function createGround(width : Number, height : Number) : Body {
			
			var body : Body = new Body(BodyType.STATIC);
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
			var body : Body = createBox(64, 64, true);
			body.rotation = MathUtils.radians(270);
			var shape: Shape = body.shapes.at(0);
			shape.material.density = 2; 
//			shape.material.dynamicFriction = 1;
//			trace('shape.material.dynamicFriction: ' + (shape.material.dynamicFriction));
//			shape.material.staticFriction = 0;
//			trace('shape.material.staticFriction: ' + (shape.material.staticFriction));
//			shape.filter.collisionGroup = 2;
//			shape.filter.collisionMask = ~2;
//			body.allowRotation = false;
			return body;
		}

		public static function createEnemy() : Body {
			var body : Body = createBox(64, 64, true);
			body.rotation = MathUtils.radians(270);
//			var shape: Shape = body.shapes.at(0);
//			shape.material.dynamicFriction = 0;
//			shape.material.staticFriction = 0;
//			shape.filter.collisionGroup = 2;
//			shape.filter.collisionMask = ~2;
			return body;
		}

		public static function createBox(width: Number, height: Number, center: Boolean = true, dynamicType: Boolean = true) : Body {
			var pivotX: Number = center ? 0 - width * 0.5 : 0;
			var pivotY: Number = center ? 0 - height * 0.5 : 0;
			var body : Body = new Body( (dynamicType ? BodyType.DYNAMIC : BodyType.STATIC ) );
			body.shapes.add(new Polygon(Polygon.rect(pivotX, pivotY, width, height)));
			return body;
		}
		
		public static function createCircle(radius: Number, dynamicType: Boolean = true) : Body {
			var body : Body = new Body( (dynamicType ? BodyType.DYNAMIC : BodyType.STATIC ) );
			body.shapes.add(new Circle(radius));
			return body;
		}
		
		
		/**
		 * _bulletPool 
		 */
		static private var _bulletPool : UniqueObjectPool;

		/**
		 * createBullet 
		 * 
		 * @return 
		 */
		static public function createBeam() : Body {
			if (!_bulletPool) {
				_bulletPool = new UniqueObjectPool();
				// for debug view:
				ObjectPool.pools["Bullet"] = _bulletPool.pool;
			}
			/**
			 * body 
			 */
			var body : Body = _bulletPool.get(Body);
//			var body : Body = new Body();
			if (body.shapes.empty()) {
				body.type = BodyType.DYNAMIC;
//				body.isBullet = true;
				var shape : Shape = new Polygon(Polygon.rect(-Constants.BULLET_SIZE * 0.5, -Constants.BULLET_SIZE * 0.5, Constants.BULLET_SIZE, Constants.BULLET_SIZE));
				// shape.material = new Material(1,5);
				shape.filter.collisionGroup = 2;
				shape.filter.collisionMask = ~2;
				body.shapes.add(shape);
				body.allowRotation = false;
			} else {
				body.rotation = 0;
				body.angularVel = 0;
				body.velocity.x = 0;
				body.velocity.y = 0;
			}
			return body;
		}

		/**
		 * disposeBullet 
		 * 
		 * @param object 
		 * 
		 * @return 
		 */
		static public function disposeBullet(object : Object) : void {
			_bulletPool.dispose(object);
		}

		public static function createStaticObstacle(width : Number, height : Number) : Body {
			var body: Body = createBox(width, height, true, false);
			var shape: Shape = body.shapes.at(0);
			shape.material = Material.rubber();
			return body;
		}
		public static function createStaticObstacleCircular(radius : Number) : Body {
			var body: Body = createCircle(radius, false);
			var shape: Shape = body.shapes.at(0);
			shape.material = Material.rubber();
			return body;
		}
	}
}
