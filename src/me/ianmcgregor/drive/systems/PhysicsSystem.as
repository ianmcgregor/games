package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.components.BulletComponent;
	import me.ianmcgregor.drive.components.CharacterComponent;
	import me.ianmcgregor.drive.components.PhysicsComponent;
	import me.ianmcgregor.drive.components.PlayerComponent;
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.constants.State;
	import me.ianmcgregor.drive.factories.BodyFactory;
	import me.ianmcgregor.drive.factories.EntityFactory;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.games.utils.nape.NapeUtils;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Mat23;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
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
		private const _bossCollisonType : CbType = new CbType();
		private const _enemyCollisonType : CbType = new CbType();
		private const _bulletCollisionType : CbType = new CbType();
		private const _pedestrianCollisionType : CbType = new CbType();
		private const _cyclistCollisionType : CbType = new CbType();
		private const _bombCollisionType : CbType = new CbType();
		private const _slickCollisionType : CbType = new CbType();
		private const _roadBlockCollisionType : CbType = new CbType();
		private const _treeCollisionType : CbType = new CbType();
		private const _truckCollisionType : CbType = new CbType();
		private var _playerEnemyCollisionListener : InteractionListener;
		private var _bulletEnemyCollisionListener : InteractionListener;
		private var _playerBossCollisionListener : InteractionListener;
		private var _playerPedestrianCollisionListener : InteractionListener;
		private var _playerCyclistCollisionListener : InteractionListener;
		private var _playerBombCollisionListener : InteractionListener;
		private var _playerSlickCollisionListener : InteractionListener;
		private var _playerRoadBlockCollisionListener : InteractionListener;
		private var _playerTreeCollisionListener : InteractionListener;
		private var _enemyTreeCollisionListener : InteractionListener;
		private var _playerTruckCollisionListener : InteractionListener;
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
			
			// drag
			var dragpoly: Polygon = new Polygon(Polygon.rect(-10000,-10000,20000,20000));
			dragpoly.fluidEnabled = true;
			dragpoly.fluidProperties.viscosity = 1.8;
			var dragbody: Body = new Body(BodyType.STATIC);
			dragpoly.body = dragbody;
			dragbody.space = _space;

			// collisions
			_space.listeners.add(_playerEnemyCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _enemyCollisonType, onPlayerEnemyCollision));
			_space.listeners.add(_playerBossCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _bossCollisonType, onPlayerBossCollision));
			_space.listeners.add(_bulletEnemyCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _bulletCollisionType, _enemyCollisonType, onBulletEnemyCollision));
			_space.listeners.add(_playerPedestrianCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _pedestrianCollisionType, onPlayerPedestrianCollision));
			_space.listeners.add(_playerCyclistCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _cyclistCollisionType, onPlayerCyclistCollision));
			_space.listeners.add(_playerBombCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _bombCollisionType, onPlayerBombCollision));
			_space.listeners.add(_playerSlickCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _slickCollisionType, onPlayerSlickCollision));
			_space.listeners.add(_playerRoadBlockCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _roadBlockCollisionType, onPlayerRoadBlockCollision));
			_space.listeners.add(_playerTreeCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _treeCollisionType, onPlayerTreeCollision));
			_space.listeners.add(_enemyTreeCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _enemyCollisonType, _treeCollisionType, onEnemyTreeCollision));
			_space.listeners.add(_playerTruckCollisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _playerCollisionType, _truckCollisionType, onPlayerTruckCollision));

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
		private function onPlayerEnemyCollision(collision:InteractionCallback) : void {
//			trace('onPlayerEnemyCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			
			// damage
			var c1: CharacterComponent = e1.getComponent(CharacterComponent);
			if(!c1.getHurt())c1.setHurt();
			addDamage(e1, 0.02, null);
			var angle: Number = NapeUtils.getAngle(b2, b1);
			var d : String = getAngleAsDirection(angle);
			c1.damageDirection = d;
			
			// TODO: use dot product to get direction

			var c2: CharacterComponent = e2.getComponent(CharacterComponent);
			if(!c2.getHurt())c2.setHurt();
			addDamage(e2, 0.02, e1.getComponent(PlayerComponent));

			// bump!
			NapeUtils.push(b2, b1, 1000);
			NapeUtils.push(b1, b2, 500);
		}
		
		private function getAngleAsDirection(rads : Number) : String {
//			trace("PhysicsSystem.getAngleAsDirection(",rads,")");
			
			var d: String = "";
			const RIGHT : Number = -0.7853981633974483;
			const DOWN : Number = 0.7853981633974483;
			const LEFT : Number = 2.356194490192345;
			const UP : Number = -2.356194490192345;
			if (rads >= RIGHT && rads < DOWN) {
				d = "right";
			} else if (rads >= DOWN && rads < LEFT) {
				d = "down";
			} else if ((rads >= LEFT && rads <= Math.PI) || (rads >= -Math.PI && rads < UP)) {
				d = "left";
			} else if (rads >= UP && rads < RIGHT) {
				d = "up";
			}
			return d;
		}

		private function addDamage(e : Entity, damage: Number, player: PlayerComponent) : Boolean {
			var success: Boolean;
			var health : HealthComponent = e.getComponent(HealthComponent);
			if (health.getDamagedAt() + 0.2 < _timeNow) {
				health.addDamage(damage);
				health.setDamagedAt(_timeNow);
				if(player) player.score += 100;
				
				var c: CharacterComponent = e.getComponent(CharacterComponent);
				c.setHurt();
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
			var b2: Body = collision.int2 as Body;
			var enemy: Entity = b2.userData["entity"];
			
			// damage			
			var enemyDamaged: uint = addEnemyDamage(enemy, 0.1, false);
			if(enemyDamaged > 0) {
				var bulletComponent: BulletComponent = bullet.getComponent(BulletComponent);
				var playerComponent: PlayerComponent = bulletComponent.owner.getComponent(PlayerComponent);
				playerComponent.score += enemyDamaged;
				EntityFactory.createExplosion(_world, b2.position.x, b2.position.y);
			}
			_world.deleteEntity(bullet);
		}
		
		private function addEnemyDamage(e : Entity, amount: Number, deleteOnKilled: Boolean = true) : uint {
			var kill : uint;
			var enemyHealth : HealthComponent = e.getComponent(HealthComponent);
			if (enemyHealth.getDamagedAt() + 0.1 < _timeNow) {
				enemyHealth.addDamage(amount);
				// health
				enemyHealth.setDamagedAt(_timeNow);
				// is enemy still alive?
				if (!enemyHealth.isAlive()) {
					if(deleteOnKilled) _world.deleteEntity(e);
					kill = 1;
				}
			}
			return kill;
		}
		
		/**
		 * onPlayerBossCollision
		 */
		private function onPlayerBossCollision(collision:InteractionCallback) : void {
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
			
//			_g.state = State.GAME_ENDING;
		}
		/**
		 * onPlayerPedestrianCollision
		 */
		private function onPlayerPedestrianCollision(collision:InteractionCallback) : void {
			trace('onPlayerPedestrianCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
		}
		/**
		 * onPlayerCyclistCollision
		 */
		private function onPlayerCyclistCollision(collision:InteractionCallback) : void {
			trace('onPlayerCyclistCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
		}
		/**
		 * onPlayerBombCollision
		 */
		private function onPlayerBombCollision(collision:InteractionCallback) : void {
			trace('onPlayerBombCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			
			//var t: TransformComponent = e2.getComponent(TransformComponent);
		}
		/**
		 * onPlayerSlickCollision
		 */
		private function onPlayerSlickCollision(collision:InteractionCallback) : void {
			trace('onPlayerSlickCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			
			// TODO: make car skid or spin: maybe set a var to disable control and add some rotation depending on what velocity is
		}
		/**
		 * onPlayerRoadBlockCollision
		 */
		private function onPlayerRoadBlockCollision(collision:InteractionCallback) : void {
//			trace('onPlayerRoadBlockCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));

			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			
			addDamage(e1, 0.01, null);
		}
		/**
		 * onPlayerTreeCollision
		 */
		private function onPlayerTreeCollision(collision:InteractionCallback) : void {
//			trace('onPlayerTreeCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			
			var char: CharacterComponent = e1.getComponent(CharacterComponent);
			char.setHurt();
			
			addDamage(e1, 0.01, null);
		}
		/**
		 * onEnemyTreeCollision
		 */
		private function onEnemyTreeCollision(collision:InteractionCallback) : void {
//			trace('onEnemyTreeCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			
			// TODO: get away from tree!
			
//			var enemy: EnemyComponent = e1.getComponent(EnemyComponent);
			var health: HealthComponent = e1.getComponent(HealthComponent);
			var char: CharacterComponent = e1.getComponent(CharacterComponent);
			
			//cause damage, stop attack, evade tree 
			char.setHurt();
			
			addEnemyDamage(e1, 0.1, false);
			EntityFactory.createExplosion(_world, b1.position.x, b1.position.y);
			
			// steer away from tree
			if(health.isAlive()) {
				var angle: Number = NapeUtils.getAngle(b1, b2) + Math.PI;
				angle = MathUtils.rotateToRAD(b1.rotation, angle);
				angle = MathUtils.lerp(b1.rotation, angle, 0.2);
				b1.rotation = angle;
			}
		}

		/**
		 * onPlayerTruckCollision
		 */
		private function onPlayerTruckCollision(collision:InteractionCallback) : void {
			trace('onPlayerTruckCollision:', 'collision.int1: ', (collision.int1), 'collision.int2: ', (collision.int2));
			// e1 
			var b1: Body = collision.int1 as Body;
			var e1: Entity = collision.int1.userData.entity;
			// e2 
			var b2: Body = collision.int2 as Body;
			var e2: Entity = collision.int2.userData.entity;
			// temp
			b1, b2, e1, e2;
			
			_g.state = State.LEVEL_COMPLETE;
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
				case Constants.BULLET:
					body.cbTypes.add(_bulletCollisionType);
					break;
				case Constants.BOSS:
					body.cbTypes.add(_bossCollisonType);
					break;
				case Constants.ENEMY:
					body.cbTypes.add(_enemyCollisonType);
					break;
				case Constants.PEDESTRIAN:
					body.cbTypes.add(_pedestrianCollisionType);
					break;
				case Constants.CYCLIST:
					body.cbTypes.add(_cyclistCollisionType);
					break;
				case Constants.BOMB:
					body.cbTypes.add(_bombCollisionType);
					break;
				case Constants.SLICK:
					body.cbTypes.add(_slickCollisionType);
					break;
				case Constants.ROAD_BLOCK:
					body.cbTypes.add(_roadBlockCollisionType);
					break;
				case Constants.TREE:
					body.cbTypes.add(_treeCollisionType);
					break;
				case Constants.TRUCK:
					body.cbTypes.add(_truckCollisionType);
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
			var p : PhysicsComponent = _physicsMapper.get(e);

			// remove from physics world
			_space.bodies.remove(p.body);
//			ObjectPool.dispose(physicsComponent.body);
			switch(p.name){
				case Constants.BULLET:
					BodyFactory.disposeBullet(p.body);
					break;
				default:
			}
			p.body = null;
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
//						p.body.rotation += Math.PI * 0.01;
						break;
//					case Constants.HERO:
//					case Constants.BAD_GUY:
//						var c: CharacterComponent = e.getComponent(CharacterComponent);
//						if(c.isAttacking()) {
//							p.body.shapes.add(p.body.userData.fist);
//						} else {
//							p.body.shapes.remove(p.body.userData.fist);
//						}
//						break;
//					case Constants.EGG:
//						var posY: Number = p.body.position.y;
//						if(posY > _g.getHeight() + 64) {
//							_world.deleteEntity(e);
//						}	
//						break;
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
