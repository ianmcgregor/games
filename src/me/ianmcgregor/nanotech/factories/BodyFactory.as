package me.ianmcgregor.nanotech.factories {
	import me.ianmcgregor.games.utils.collections.ObjectPool;
	import me.ianmcgregor.games.utils.collections.UniqueObjectPool;
	import me.ianmcgregor.nanotech.constants.Constants;

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
		 * createWall 
		 * 
		 * @param x 
		 * @param y 
		 * @param width 
		 * @param height 
		 * 
		 * @return 
		 */
		static public function createWall(x : Number, y : Number, width : Number, height : Number) : Body {
			/**
			 * body 
			 */
			var body : Body = new Body(BodyType.STATIC, Vec2.weak(x, y));
			/**
			 * shape 
			 */
			var shape : Polygon = new Polygon(Polygon.rect(0, 0, width, height));
			shape.material.elasticity = 1;
			shape.material.density = 1;
			shape.material.staticFriction = 1;
			body.shapes.add(shape);
//			shape.filter.collisionGroup = 8;
//			shape.filter.collisionMask = ~8;
			return body;
		}
		
		/**
		 * createHero 
		 * 
		 * @return 
		 */
		static public function createHero() : Body {
			var body : Body = new Body(BodyType.DYNAMIC);
			var halfSize : int = Constants.HERO_SIZE * 0.5;
			var vertices : Vector.<Vec2> = new <Vec2>[];
			vertices[vertices.length] = new Vec2(0, -halfSize);
			vertices[vertices.length] = new Vec2(halfSize, halfSize);
			vertices[vertices.length] = new Vec2(-halfSize, halfSize);
//			vertices[vertices.length] = new Vec2(0, -halfSize);
//			vertices[vertices.length] = new Vec2(halfSize, halfSize);
//			vertices[vertices.length] = new Vec2(-halfSize, halfSize);
			/**
			 * shape 
			 */
			var shape : Shape = new Polygon(vertices);
			shape.rotate(Math.PI * 0.5);
			// shape.material = new Material(1,5);
			// shape.filter.collisionGroup = 2;
			shape.filter.collisionGroup = 4;
			shape.filter.collisionMask = ~2;
			body.shapes.add(shape);
			shape.material = Material.steel();
			return body;
		}
		
		/**
		 * Friend
		 */
		static public function createFriend() : Body {
			var body: Body = new Body(BodyType.DYNAMIC);
			body.shapes.add(new Circle(Constants.FRIEND_RADIUS));
			return body;
		}
		
		/**
		 * _enemyPool 
		 */
		static private var _enemyPool : UniqueObjectPool;

		/**
		 * createEnemy 
		 * 
		 * @param type 
		 * 
		 * @return 
		 */
		static public function createEnemy() : Body {
			if (!_enemyPool) {
				_enemyPool = new UniqueObjectPool();
				// for debug view:
				ObjectPool.pools["Enemy"] = _enemyPool.pool;
			}
			/**
			 * body 
			 */
			var body : Body = _enemyPool.get(Body);
			// var body: Body = new Body(BodyType.DYNAMIC);
			if (body.shapes.empty()) {
				body.type = BodyType.DYNAMIC;
				var shape : Shape = new Circle(Constants.ENEMY_RADIUS);
				body.shapes.add(shape);
			} else {
				body.rotation = 0;
				body.angularVel = 0;
				body.velocity.x = 0;
				body.velocity.y = 0;
				// reset scale
				var scale: Number = Constants.ENEMY_RADIUS / body.shapes.at(0).castCircle.radius;
				body.scaleShapes(scale, scale);
			}
			return body;
		}

		/**
		 * disposeEnemy 
		 * 
		 * @param object 
		 * 
		 * @return 
		 */
		static public function disposeEnemy(object : Object) : void {
			_enemyPool.dispose(object);
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
		static public function createBullet() : Body {
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
	}
}
