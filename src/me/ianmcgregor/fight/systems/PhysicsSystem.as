package me.ianmcgregor.fight.systems {
	import me.ianmcgregor.fight.components.CharacterComponent;
	import me.ianmcgregor.fight.components.PhysicsComponent;
	import me.ianmcgregor.fight.components.PlayerComponent;
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.State;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Mat23;
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
		private const _groundCollisionType : CbType = new CbType();
		private const _playerCollisionType : CbType = new CbType();
		private const _mamaCollisonType : CbType = new CbType();
		private const _badGuyCollisonType : CbType = new CbType();
		private var _collisionListener : InteractionListener;
		private var _playerMamaCollisionListener : InteractionListener;
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
			var gravity : Vec2 = Vec2.weak(0, 600);
			_space = new Space(gravity);

			// collisions
			_space.listeners.add(_collisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _badGuyCollisonType, onPlayerBadGuyCollision));
			_space.listeners.add(_playerMamaCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _mamaCollisonType, onPlayerMamaCollision));

			// debug
			//_debug = true;
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
			if(Starling.current.nativeStage.contains(_debugger.display))
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
		private function onPlayerBadGuyCollision(collision:InteractionCallback) : void {
//			trace('onCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
//			b1, b2, e1, e2;
			
			// damage
			var c1: CharacterComponent = e1.getComponent(CharacterComponent);
			if( c1.isAttacking() ) {
				var p: PlayerComponent = e1.getComponent(PlayerComponent);
				var damaged: Boolean = addDamage(e2, 0.2, p);
				if(damaged) {
					var direction : int = b1.position.x < b2.position.x ? 1 : -1;
					b2.applyImpulse(Vec2.weak(500 * direction,0));
				}
			}
			var c2: CharacterComponent = e2.getComponent(CharacterComponent);
			if( c2.isAttacking() ) {
				addDamage(e1, 0.02, null);
			}
		}

		private function addDamage(e : Entity, damage: Number, player: PlayerComponent) : Boolean {
			var success: Boolean;
			var health : HealthComponent = e.getComponent(HealthComponent);
			if (health.getDamagedAt() + 0.2 < _timeNow) {
				health.addDamage(damage);
				health.setDamagedAt(_timeNow);
				if(player) player.score += 100;
				
				var c: CharacterComponent = e.getComponent(CharacterComponent);
				c.hurtAt = _timeNow;
				c.isHurt = true;
				success = true;
//				trace(health.getHealthPercentage());
				if (!health.isAlive()) {
					//_world.deleteEntity(e1);
					c.setDead(_timeNow);
					if(player) player.score += 1000;
				}
			}
			return success;
		}
		private function onPlayerMamaCollision(collision:InteractionCallback) : void {
//			trace('onCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			//b1.applyImpulse(Vec2.weak(0, -1000));
			b2.applyImpulse(Vec2.weak(0, -1000));
			
			_g.state = State.GAME_ENDING;
		}

		
		/**
		 * New physics entity added
		 */
		override protected function added(e : Entity) : void {
			super.added(e);

			// physicsComponent 
			var physicsComponent : PhysicsComponent = _physicsMapper.get(e);
//			trace('physicsComponent.name: ' + (physicsComponent.name));
			// transformComponent 
			var transformComponent : TransformComponent = _transformMapper.get(e);
			
			// add body to space 
			var body : Body = physicsComponent.body;

			switch(physicsComponent.name){
				case Constants.GROUND:
					body.cbTypes.add(_groundCollisionType);
					break;
				case Constants.HERO:
					body.cbTypes.add(_playerCollisionType);
					break;
				case Constants.BOSS:
					body.cbTypes.add(_mamaCollisonType);
					break;
				case Constants.BAD_GUY:
					body.cbTypes.add(_badGuyCollisonType);
					break;
				default:
			}
			
			body.position.setxy(transformComponent.x, transformComponent.y);
			body.space = _space;
			// ref entity in body userdata for collision reactions
			body.userData.entity = e;
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
			var t: TransformComponent = e.getComponent(TransformComponent);
			if( t ) {
				var p : PhysicsComponent = _physicsMapper.get(e);
				
//				trace('p.body.position: ' + (p.body.position));
//				if (isNaN(p.body.position.x)) p.body.position.x = t.x;
//				if(isNaN(p.body.position.y)) p.body.position.y = t.y;
//				if(isNaN(p.body.rotation)) p.body.rotation = 0;
				
				t.x = p.body.position.x;
				t.y = p.body.position.y;
				t.rotation = p.body.rotation;
				
				switch(p.name){
					case Constants.HERO:
					case Constants.BAD_GUY:
						var c: CharacterComponent = e.getComponent(CharacterComponent);
						if(c.isAttacking()) {
							p.body.shapes.add(p.body.userData.fist);
						} else {
							p.body.shapes.remove(p.body.userData.fist);
						}
						break;
					default:
				}
			}
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
			super.processEntities(entities);
			// step physics world
			if(_world.getDelta() > 0)
				_space.step(_world.getDelta());

			// debug
			if (_debug) {
				_debugger.transform = Mat23.translation(-_g.camera.x,-_g.camera.y);
				_debugger.clear();
				_debugger.draw(_space);
				_debugger.flush();
			}
		}
	}
}
