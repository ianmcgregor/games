package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.nanotech.components.HeroComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.constants.KeyConstants;
	import me.ianmcgregor.nanotech.factories.EntityFactory;

	import nape.geom.Vec2;
	import nape.phys.Body;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class HeroControlSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * mappers 
		 */
		private var _heroMapper : ComponentMapper;
		private var _physicsMapper : ComponentMapper;
		private var _weaponMapper : ComponentMapper;
		/**
		 * _timeNow
		 */
		private var _timeNow : Number;

		/**
		 * HeroControlSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function HeroControlSystem(g : GameContainer) {
			super(HeroComponent, []);
			_g = g;
			_input = _g.getInput();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_heroMapper = new ComponentMapper(HeroComponent, _world);
			_physicsMapper = new ComponentMapper(PhysicsComponent, _world);
			_weaponMapper = new ComponentMapper(WeaponComponent, _world);
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
			
			/**
			 * heroComponent 
			 */
			var heroComponent: HeroComponent = _heroMapper.get(e);
			heroComponent;
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
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_timeNow = _g.getTimeNow();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * heroComponent 
			 */
			var heroComponent: HeroComponent = _heroMapper.get(e);
			/**
			 * physicsComponent 
			 */
			var physicsComponent: PhysicsComponent = _physicsMapper.get(e);
			
			/**
			 * player1 
			 */
			var player1: Boolean = heroComponent.player == 1;
			/**
			 * left 
			 */
			var left: Boolean = player1 ? _input.isDown(KeyConstants.LEFT_P1) : _input.isDown(KeyConstants.LEFT_P2);
			/**
			 * right 
			 */
			var right: Boolean = player1 ? _input.isDown(KeyConstants.RIGHT_P1) : _input.isDown(KeyConstants.RIGHT_P2);
			/**
			 * up 
			 */
			var up: Boolean = player1 ? _input.isDown(KeyConstants.UP_P1) : _input.isDown(KeyConstants.UP_P2);
			/**
			 * shoot 
			 */
			var shoot: Boolean = player1 ? _input.isDown(KeyConstants.SHOOT_P1) : ( _input.isDown(KeyConstants.SHOOT_P2) || _input.isDown(KeyConstants.SHOOT_P2_B) );
			
			/**
			 * rotationIncrement 
			 */
			if (left) {
				// rotate left
				physicsComponent.body.angularVel *= Constants.ANGULAR_DAMPENING;
				physicsComponent.body.rotation -= Constants.ROTATION_INCREMENT;
			} else if (right) {
				// rotate right
				physicsComponent.body.angularVel *= Constants.ANGULAR_DAMPENING;
				physicsComponent.body.rotation += Constants.ROTATION_INCREMENT;
			}
			if (up) {
				var mass : Number = physicsComponent.body.mass;
				/**
				 * maxVelocity 
				 */
				var maxVelocity : Number = mass * Constants.MAX_VELOCITY;
				/**
				 * impulseStrength 
				 */
				var impulseStrength : Number = mass * Constants.IMPULSE;
//				if (physicsComponent.body.velocity.length > maxVelocity) impulseStrength = maxVelocity;
				/**
				 * vec2 
				 */
				var vec2 : Vec2 = Vec2.fromPolar(impulseStrength, physicsComponent.body.rotation);
				physicsComponent.body.applyImpulse(vec2);
				vec2.dispose();
				/**
				 * limit
				 */
				if (physicsComponent.body.velocity.length > maxVelocity) {
					physicsComponent.body.velocity.length = maxVelocity;
				}
			} else {
				// dampening: 1 = no dampening 0 = total dampening
				/**
				 * dampening 
				 */
				var dampening : Number = 0.5;
				/**
				 * damp 
				 */
				var damp : Number = Math.pow(dampening, _world.getDelta());
				physicsComponent.body.velocity.muleq(damp);
				physicsComponent.body.angularVel *= damp;
			}
			
			/**
			 * weapon 
			 */
			var weapon : WeaponComponent = _weaponMapper.get(e);
//			if (_input.isDown(Keyboard.SPACE)  && weapon.getShotAt() + 100 < _timeNow) {
			if (shoot && weapon.getShotAt() + 0.1 < _timeNow) {
				/**
				 * bullet 
				 */
				var bullet: Entity = EntityFactory.createBullet(_world, e);
				TransformComponent(bullet.getComponent(TransformComponent)).setLocation(physicsComponent.body.position.x, physicsComponent.body.position.y);
				/**
				 * body 
				 */
				var body : Body = PhysicsComponent(bullet.getComponent(PhysicsComponent)).body;
				body.rotation = physicsComponent.body.rotation;
				/**
				 * positionVec 
				 */
				var positionVec: Vec2 = physicsComponent.body.position.add(Vec2.fromPolar(Constants.HERO_SIZE * 0.5, body.rotation));
				TransformComponent(bullet.getComponent(TransformComponent)).setLocation(positionVec.x, positionVec.y);
				
				/**
				 * impulseVec 
				 */
				var impulseVec : Vec2 = Vec2.fromPolar(40, body.rotation);
				body.applyImpulse(impulseVec);
				//VelocityComponent(bullet.getComponent(VelocityComponent)).setLocation(physicsComponent.body.position.x, physicsComponent.body.position.y);
				
				positionVec.dispose();
				impulseVec.dispose();
				
				bullet.refresh();
				weapon.setShotAt(_timeNow);
			}
			/**
			 * Keep on screen
			 */
			if(physicsComponent.body.position.x < 20 || physicsComponent.body.position.x > _g.getWidth() - 20 || physicsComponent.body.position.y < 20 || physicsComponent.body.position.y > _g.getHeight() - 20) {
				/**
				 * vector to go towards
				 */
				var xPos : Number = _g.getWidth() * 0.5 - physicsComponent.body.position.x;
	    		var yPos : Number = _g.getHeight() * 0.5 - physicsComponent.body.position.y;
				/**
				 * impulseVec 
				 */
				var impulseVec2 : Vec2 = Vec2.get(xPos, yPos);
				impulseVec2.length = 20 * physicsComponent.body.mass;
				physicsComponent.body.applyImpulse(impulseVec2);
				impulseVec2.dispose();
			}
		}
	}
}
