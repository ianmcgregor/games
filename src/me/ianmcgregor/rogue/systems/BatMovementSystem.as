package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.rogue.components.BatComponent;

	import soulwire.ai.Boid;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.geom.Vector3D;

	/**
	 * @author ianmcgregor
	 */
	public final class BatMovementSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
//		private var _nullMapper : ComponentMapper;
		private var _boids : Vector.<Boid> = new Vector.<Boid>();
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;

		/**
		 * NullSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function BatMovementSystem(g : GameContainer) {
			super(BatComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
//			_nullMapper = new ComponentMapper(NullComponent, _world);
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
			
			var bat: BatComponent = e.getComponent(BatComponent);
			var transform: TransformComponent = e.getComponent(TransformComponent);
			bat.boid = createBoid(); 		
			bat.boid.boundsCentre.x = transform.x;
			bat.boid.boundsCentre.y = transform.y;
			//Starling.current.nativeOverlay.addChild(bat.boid.renderData);
		}
		
		private function createBoid() : Boid
		{
			var boid : Boid = new Boid();
			
			setProperties(boid);
		//	boid.renderData = boid.createDebugShape(Math.random() * 0xFFFFFF, 4.0, 2.0);
			
			_boids[_boids.length] = boid;
//			_boidHolder.addChild(boid.renderData);
			
			return boid;
		}
		
		private function setProperties(boid : Boid) : void
		{
			var minForce: Number = 3.0;
			var maxForce: Number = 6.0;
			var minSpeed: Number = 6.0;
			var maxSpeed: Number = 12.0;
			var minWanderDistance: Number = 10.0;
			var maxWanderDistance: Number = 100.0;
			var minWanderRadius: Number = 5.0;
			var maxWanderRadius: Number = 20.0;
			var minWanderStep: Number = 0.1;
			var maxWanderStep: Number = 0.9;
//			var boundsRadius: Number = _g.getWidth() * 0.6;
			var boundsRadius: Number = 80;
			
			boid.edgeBehavior = Boid.EDGE_BOUNCE;
			boid.maxForce = MathUtils.random(minForce, maxForce);
			boid.maxSpeed = MathUtils.random(minSpeed, maxSpeed);
			boid.wanderDistance = MathUtils.random(minWanderDistance, maxWanderDistance);
			boid.wanderRadius = MathUtils.random(minWanderRadius, maxWanderRadius);
			boid.wanderStep = MathUtils.random(minWanderStep, maxWanderStep);
			boid.boundsRadius = boundsRadius;
			boid.boundsCentre = new Vector3D(_g.getWidth() >> 1, _g.getHeight() >> 1, 0.0);
			
			if(boid.x == 0 && boid.y == 0)
			{
				boid.x = boid.boundsCentre.x + MathUtils.random(-100, 100);
				boid.y = boid.boundsCentre.y + MathUtils.random(-100, 100);
				boid.z = MathUtils.random(-100, 100);
				
				var vel : Vector3D = new Vector3D(MathUtils.random(-2, 2), MathUtils.random(-2, 2), MathUtils.random(-2, 2));
				boid.velocity.incrementBy(vel);
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
			
			
			var batComponent: BatComponent = e.getComponent(BatComponent);
			//Starling.current.nativeOverlay.removeChild(batComponent.boid.renderData);
			var index: int = _boids.indexOf(batComponent.boid);
			_boids.splice(index, 1);
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
			var batComponent: BatComponent = e.getComponent(BatComponent);
			var transform: TransformComponent = _transformMapper.get(e);
			updateBoid(batComponent.boid, transform);
		}
		
		private function updateBoid(boid : Boid, transform: TransformComponent) : void
		{
			// Add some wander to keep things interesting
			boid.wander(0.3);
			
			// Add a mild attraction to the centre to keep them on screen
			boid.seek(boid.boundsCentre, 0.1);
			
			// Flock
			boid.flock(_boids);
			
			boid.update();
			boid.render();
			
			transform.x = boid.x;
			transform.y = boid.y;
			
		}
	}
}
