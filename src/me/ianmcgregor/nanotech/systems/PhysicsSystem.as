package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.components.BulletComponent;
	import me.ianmcgregor.nanotech.components.HeroComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.components.SoundComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.factories.BodyFactory;
	import me.ianmcgregor.nanotech.spatials.gfx.SiONSounds;

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
		private const _enemyCollisionType : CbType = new CbType();
		private const _heroCollisionType : CbType = new CbType();
		private const _bulletCollisionType : CbType = new CbType();
		private const _wallCollisionType : CbType = new CbType();
		private const _friendCollisionType : CbType = new CbType();
		private var _heroEnemyCollisionListener : InteractionListener;
		private var _wallEnemyCollisionListener : InteractionListener;
		private var _bulletEnemyCollisionListener : InteractionListener;
		private var _bulletWallCollisionListener : InteractionListener;
		private var _friendEnemyCollisionListener : InteractionListener;
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
//
//			var w : Number = _g.getWidth();
//			var h : Number = _g.getHeight();

			// Create a new simulation Space.
			// Weak Vec2 will be automatically sent to object pool.
			// when used as argument to Space constructor.
			var gravity : Vec2 = Vec2.weak(0, 0);
			_space = new Space(gravity);

			// collisions
			_space.listeners.add(_wallEnemyCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _wallCollisionType, _enemyCollisionType, onWallEnemyCollision));
			_space.listeners.add(_bulletWallCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _bulletCollisionType, _wallCollisionType, onBulletWallCollision));
			_space.listeners.add(_heroEnemyCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _heroCollisionType, _enemyCollisionType, onHeroEnemyCollision));
			_space.listeners.add(_bulletEnemyCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _bulletCollisionType, _enemyCollisionType, onBulletEnemyCollision));
			_space.listeners.add(_friendEnemyCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _friendCollisionType, _enemyCollisionType, onFriendEnemyCollision));

			// floor
//			var wallDistance : Number = 100; // 200
//			addWall(-wallDistance, h + wallDistance, w + wallDistance * 2, 10);
//			// left
//			addWall(-wallDistance, -wallDistance, 10, h + wallDistance * 2);
//			// right
//			addWall(w + wallDistance * 2, -wallDistance, 10, h + wallDistance * 2);
//			// ceiling
//			addWall(-wallDistance, -wallDistance, w + wallDistance * 2, 10);

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
		 * onWallEnemyCollision 
		 * 
		 * @param collision 
		 * 
		 * @return 
		 */
		private function onWallEnemyCollision(collision:InteractionCallback) : void {
//			trace('onWallEnemyCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			/**
			 * enemy 
			 */
			var enemy: Entity = collision.int2.userData["entity"];
			_world.deleteEntity(enemy);
		}

		/**
		 * onWallEnemyCollision 
		 * 
		 * @param collision 
		 * 
		 * @return 
		 */
		private function onBulletWallCollision(collision:InteractionCallback) : void {
//			trace('onBulletWallCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			var e: Entity = collision.int1.userData["entity"];
			_world.deleteEntity(e);
		}
		
		/**
		 * onHeroEnemyCollision 
		 * 
		 * @param collision 
		 * 
		 * @return 
		 */
		private function onHeroEnemyCollision(collision:InteractionCallback) : void {
//			trace('onEnemyHeroCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			
			/**
			 * hero 
			 */
			var hero: Entity = collision.int1.userData["entity"];
			/**
			 * enemy 
			 */
			var enemy: Entity = collision.int2.userData["entity"];
			
			// removing health
			var heroHealth: HealthComponent = hero.getComponent(HealthComponent);
			if(heroHealth.getDamagedAt() + 0.2 < _timeNow) {
				// trigger damage sound
				heroHealth.addDamage(0.01);
				heroHealth.setDamagedAt(_timeNow);
			}

			addEnemyDamage(enemy, Body(collision.int2), Constants.ENEMY_DAMAGE_AMOUNT, SiONSounds.ENEMY_COLLISION);
		}

		private function addEnemyDamage(e : Entity, b: Body, amount: Number, soundTrigger: String = SiONSounds.ENEMY_DAMAGE) : uint {
//			var pointsScored : uint;
			var kill : uint;
			var enemyHealth : HealthComponent = e.getComponent(HealthComponent);
			if (enemyHealth.getDamagedAt() + 0.1 < _timeNow) {
				// TODO: trigger damage sound
				enemyHealth.addDamage(amount);
				// add points
//				pointsScored = 1;
				
				// scale down shapes
				var scale : Number = Constants.ENEMY_MIN_SCALE + (1 - Constants.ENEMY_MIN_SCALE) * enemyHealth.getHealthPercentage();
				var transform: TransformComponent = e.getComponent(TransformComponent);
				transform.scale = scale;
				scaleBody(scale, b, Constants.ENEMY_RADIUS);

				// sound
				var enemySound : SoundComponent = e.getComponent(SoundComponent);
				enemySound.trigger = soundTrigger;
				enemySound.arg = enemyHealth.getHealthPercentage();
				enemyHealth.setDamagedAt(_timeNow);
				
				// is enemy still alive?
				if (!enemyHealth.isAlive()) {
					// TODO: trigger die sound
					enemySound.trigger = SiONSounds.ENEMY_KILL;
					_world.deleteEntity(e);
					// add points
//					pointsScored = 10;
					kill = 1;
				}
			}
//			return pointsScored;
			return kill;
		}

		private function scaleBody(scale : Number, b : Body, originalRadius: Number) : void {
			var currentScale : Number = b.shapes.at(0).castCircle.radius / originalRadius;
			var newScale : Number = scale / currentScale;
			b.scaleShapes(newScale, newScale);
		}

		
		/**
		 * onBulletEnemyCollision 
		 * 
		 * @param collision 
		 * 
		 * @return 
		 */
		private function onBulletEnemyCollision(collision:InteractionCallback) : void {
//			trace('onBulletEnemyCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			
			/**
			 * bullet 
			 */
			var bullet: Entity = collision.int1.userData["entity"];
			/**
			 * enemy 
			 */
			var enemy: Entity = collision.int2.userData["entity"];
			
			// damage			
			var enemyDamaged: uint = addEnemyDamage(enemy, Body(collision.int2), 0.2);
			if(enemyDamaged > 0) {
				var bulletComponent: BulletComponent = bullet.getComponent(BulletComponent);
				var heroComponent: HeroComponent = bulletComponent.owner.getComponent(HeroComponent);
				heroComponent.addScore(enemyDamaged);
			}
			_world.deleteEntity(bullet);
		}
		
		/**
		 * onFriendEnemyCollision 
		 * 
		 * @param collision 
		 * 
		 * @return 
		 */
		private function onFriendEnemyCollision(collision:InteractionCallback) : void {
//			trace('onFriendEnemyCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			
			/**
			 * Friend 
			 */
			var friend: Entity = collision.int1.userData["entity"];
			/**
			 * enemy 
			 */
			var enemy: Entity = collision.int2.userData["entity"];
			
			// damage			
			var friendHealth : HealthComponent = friend.getComponent(HealthComponent);
			if (friendHealth.getDamagedAt() + 0.2 < _timeNow) {
				// TODO: trigger damage sound
				friendHealth.addDamage(Constants.FRIEND_DAMAGE_AMOUNT);
				// is friend still alive?
				if (!friendHealth.isAlive()) {
					// TODO: trigger die sound
					_world.deleteEntity(friend);
				} else {
					// scale down shapes
					var remainingHealth: Number = friendHealth.getHealthPercentage();
					var scale : Number = Constants.FRIEND_MIN_SCALE + (1 - Constants.FRIEND_MIN_SCALE) * remainingHealth;
					var transform : TransformComponent = friend.getComponent(TransformComponent);
					transform.scale = scale;
					scaleBody(scale, collision.int1 as Body, Constants.FRIEND_RADIUS);
					// sound
					var friendSound : SoundComponent = friend.getComponent(SoundComponent);
					friendSound.trigger = SiONSounds.FRIEND_DAMAGE;
					friendSound.arg = remainingHealth;
					friendHealth.setDamagedAt(_timeNow);
				}
			
				// restore enemy
				var enemyHealth : HealthComponent = enemy.getComponent(HealthComponent);
				if (enemyHealth.getDamagedAt() + 0.2 < _timeNow && enemyHealth.getHealth() < enemyHealth.getMaximumHealth()) {
					enemyHealth.restoreHealth(Constants.ENEMY_RESTORE_HEALTH);
					scaleBody(enemyHealth.getHealthPercentage(), collision.int2 as Body, Constants.ENEMY_RADIUS);
				}
			}
		}

		
		/**
		 * New physics entity added
		 */
		override protected function added(e : Entity) : void {
			super.added(e);

			/**
			 * physicsComponent 
			 */
			var physicsComponent : PhysicsComponent = _physicsMapper.get(e);
			/**
			 * transformComponent 
			 */
			var transformComponent : TransformComponent = _transformMapper.get(e);
			
			/**
			 * body 
			 */
			var body : Body = physicsComponent.body;

			switch(physicsComponent.name){
				case Constants.WALL:
					body.cbTypes.add(_wallCollisionType);
					break;
				case Constants.HERO:
					body.cbTypes.add(_heroCollisionType);
					break;
				case Constants.BULLET:
					body.cbTypes.add(_bulletCollisionType);
					break;
				case Constants.ENEMY:
					body.cbTypes.add(_enemyCollisionType);
					break;
				case Constants.FRIEND:
					body.cbTypes.add(_friendCollisionType);
					break;
				default:
			}
			
			body.position.setxy(transformComponent.x, transformComponent.y);
			body.space = _space;
			// ref entity in body userdata for collision detection
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

			/**
			 * physicsComponent 
			 */
			var physicsComponent : PhysicsComponent = _physicsMapper.get(e);

			// remove from physics world
			_space.bodies.remove(physicsComponent.body);
//			ObjectPool.dispose(physicsComponent.body);
			switch(physicsComponent.name){
				case Constants.ENEMY:
					BodyFactory.disposeEnemy(physicsComponent.body);
					break;
				case Constants.BULLET:
					BodyFactory.disposeBullet(physicsComponent.body);
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

		/**
		 * addWall 
		 * 
		 * @param x 
		 * @param y 
		 * @param width 
		 * @param height 
		 * 
		 * @return 
		 */
//		private function addWall(x : Number, y : Number, width : Number, height : Number) : Body {
//			/**
//			 * body 
//			 */
//			var body : Body = BodyFactory.createWall(x, y, width, height);
//			body.cbTypes.add(_wallCollisionType);
//			body.space = _space;
//			return body;
//		}
	}
}
