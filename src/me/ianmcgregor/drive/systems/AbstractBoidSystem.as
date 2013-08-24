package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.components.BoidComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.utils.math.MathUtils;

	import soulwire.ai.Boid;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.geom.Vector3D;

	/**
	 * AbstractBoidSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class AbstractBoidSystem extends EntityProcessingSystem {
		/**
		 * boids
		 */
		private var _boids : Vector.<Boid> = new Vector.<Boid>();
		/**
		 * _mapper 
		 */
		private var _mapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;

		/**
		 * AbstractBoidSystem 
		 */
		public function AbstractBoidSystem(type: Class) {
			super(BoidComponent, [TransformComponent, type]);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_mapper = new ComponentMapper(BoidComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
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

			var b : BoidComponent = e.getComponent(BoidComponent);
			var transform : TransformComponent = e.getComponent(TransformComponent);

			b.boid = createBoid();
			b.boid.boundsCentre.x = transform.x;
			b.boid.boundsCentre.y = transform.y;

			// Starling.current.nativeOverlay.addChild(b.boid.renderData);
			// b.renderData = b.createDebugShape(Math.random() * 0xFFFFFF, 4.0, 2.0);
			// _boidHolder.addChild(b.renderData);
		}

		/**
		 * createBoid
		 */
		protected function createBoid() : Boid {
			var boid : Boid = new Boid();
			_boids[_boids.length] = boid;

			setProperties(boid);

			return boid;
		}

		/**
		 * setProperties - override
		 */
		protected function setProperties(b : Boid) : void {
			var minForce : Number = 3.0;
			var maxForce : Number = 6.0;
			var minSpeed : Number = 6.0;
			var maxSpeed : Number = 12.0;
			var minWanderDistance : Number = 10.0;
			var maxWanderDistance : Number = 100.0;
			var minWanderRadius : Number = 5.0;
			var maxWanderRadius : Number = 20.0;
			var minWanderStep : Number = 0.1;
			var maxWanderStep : Number = 0.9;
			// var boundsRadius: Number = _g.getWidth() * 0.6;
			var boundsRadius : Number = 80;

			b.edgeBehavior = Boid.EDGE_BOUNCE;
			b.maxForce = MathUtils.random(minForce, maxForce);
			b.maxSpeed = MathUtils.random(minSpeed, maxSpeed);
			b.wanderDistance = MathUtils.random(minWanderDistance, maxWanderDistance);
			b.wanderRadius = MathUtils.random(minWanderRadius, maxWanderRadius);
			b.wanderStep = MathUtils.random(minWanderStep, maxWanderStep);
			b.boundsRadius = boundsRadius;
			b.boundsCentre = new Vector3D(200, 200, 0.0);

			if (b.x == 0 && b.y == 0) {
				b.x = b.boundsCentre.x + MathUtils.random(-100, 100);
				b.y = b.boundsCentre.y + MathUtils.random(-100, 100);
				b.z = MathUtils.random(-100, 100);

				var vel : Vector3D = new Vector3D(MathUtils.random(-2, 2), MathUtils.random(-2, 2), MathUtils.random(-2, 2));
				b.velocity.incrementBy(vel);
			}
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

			var b : BoidComponent = _mapper.get(e);
			// Starling.current.nativeOverlay.removeChild(b.boid.renderData);
			var index : int = _boids.indexOf(b.boid);
			_boids.splice(index, 1);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var b : BoidComponent = _mapper.get(e);
			var t : TransformComponent = _transformMapper.get(e);
			update(b.boid);
			render(b.boid, t);

			// if (powerUp.isExpired()) {
			// _world.deleteEntity(e);
			// }
		}

		/**
		 * update
		 */
		protected function update(b : Boid) : void {
			// Add some wander to keep things interesting
			b.wander(0.3);

			// Add a mild attraction to the centre to keep them on screen
			b.seek(b.boundsCentre, 0.1);

			// Flock
			b.flock(_boids);
		}

		/**
		 * render
		 */
		protected function render(b : Boid, t : TransformComponent) : void {
			b.update();
			b.render();

			t.x = b.x;
			t.y = b.y;
		}
	}
}