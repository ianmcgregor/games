package me.ianmcgregor.template.systems {
	import me.ianmcgregor.chicks.components.PhysicsComponent;
	import me.ianmcgregor.chicks.constants.Constants;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;
	import nape.util.BitmapDebug;

	import starling.core.Starling;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.ui.Keyboard;

	/**
	 * @author ianmcgregor
	 */
	public final class PhysicsSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _physicsMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		/**
		 * space 
		 */
		private var _space : Space;
		/**
		 * collisions
		 */
		private const _firstCollisionType : CbType = new CbType();
		private const _secondCollisionType : CbType = new CbType();
		private var _collisionListener : InteractionListener;
		/**
		 * debug
		 */
		private var _debugger : BitmapDebug;
		private var _debug : Boolean;
		/**
		 * _timeNow 
		 */
		private var _timeNow : Number;

		/**
		 * PhysicsSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function PhysicsSystem(g : GameContainer) {
			super(PhysicsComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_physicsMapper = new ComponentMapper(PhysicsComponent, _world);

			// Create a new simulation Space.
			// Weak Vec2 will be automatically sent to object pool.
			// when used as argument to Space constructor.
			var gravity : Vec2 = Vec2.weak(0, 0);
			_space = new Space(gravity);

			// collisions
			_space.listeners.add(_collisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _firstCollisionType, _secondCollisionType, onCollision));

			// debug
//			_debug = true;
			if (_debug) {
				addDebug();

			}
		}

		private function addDebug() : void {
			if(_debugger) return;
			_debugger = new BitmapDebug(_g.getWidth(), _g.getHeight(), 0x000000);
			_debugger.drawConstraints = true;
			_debugger.display.alpha = .5;
			Starling.current.nativeStage.addChild(_debugger.display);
		}

		private function removeDebug() : void {
			if(!_debugger) return;
			_debugger.clear();
			Starling.current.nativeStage.removeChild(_debugger.display);
			_debugger = null;
		}
		
		/**
		 * Collision handlers
		 */

		/**
		 * onCollision 
		 * 
		 * @param collision 
		 * 
		 * @return 
		 */
		private function onCollision(collision:InteractionCallback) : void {
//			trace('onCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			// damage
			/*
			var health : HealthComponent = e1.getComponent(HealthComponent);
			if (health.getDamagedAt() + 0.2 < _timeNow) {
				health.addDamage(Constants.DAMAGE_AMOUNT);
				health.setDamagedAt(_timeNow);
				if (!health.isAlive()) {
					_world.deleteEntity(e1);
				}
			}
			*/
		}

		
		/**
		 * New physics entity added
		 */
		override protected function added(e : Entity) : void {
			super.added(e);

			// physicsComponent 
			var physicsComponent : PhysicsComponent = _physicsMapper.get(e);
			// transformComponent 
			var transformComponent : TransformComponent = _transformMapper.get(e);
			
			// add body to space 
			var body : Body = physicsComponent.body;

			switch(physicsComponent.name){
				case Constants.NULL:
					body.cbTypes.add(_firstCollisionType);
					break;
				default:
			}
			
			body.position.setxy(transformComponent.x, transformComponent.y);
			body.space = _space;
			// ref entity in body userdata for collision reactions
			body.userData["entity"] = e;
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

			// physicsComponent 
			var physicsComponent : PhysicsComponent = _physicsMapper.get(e);

			// remove from physics world
			_space.bodies.remove(physicsComponent.body);
//			ObjectPool.dispose(physicsComponent.body);
			switch(physicsComponent.name){
				case Constants.NULL:
					break;
				default:
			}
			physicsComponent.body = null;
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_timeNow = _g.getTimeNow();
			
			if (_g.getInput().justPressed(Keyboard.MINUS)) {
				if(_debug) {
					removeDebug();
				} else {
					addDebug();
				}
				_debug = !_debug;
			}
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
		}

		/**
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;

			// step physics world
			_space.step(_world.getDelta());

			// debug
			if (_debug) {
				_debugger.clear();
				_debugger.draw(_space);
				_debugger.flush();
			}
		}
	}
}
