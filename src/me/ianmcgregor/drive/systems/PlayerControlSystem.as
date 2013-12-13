package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.constants.State;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.drive.components.CharacterComponent;
	import me.ianmcgregor.drive.components.GameConfigComponent;
	import me.ianmcgregor.drive.components.PhysicsComponent;
	import me.ianmcgregor.drive.components.PlayerComponent;
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.constants.EntityTag;
	import me.ianmcgregor.drive.constants.KeyConstants;
	import me.ianmcgregor.drive.factories.EntityFactory;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.utils.display.LayoutUtils;
	import me.ianmcgregor.games.utils.nape.NapeUtils;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;

	import nape.geom.Vec2;
	import nape.phys.Body;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerControlSystem extends EntityProcessingSystem {
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
		private var _playerMapper : ComponentMapper;
		private var _weaponMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
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
		public function PlayerControlSystem(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
			_input = _g.getInput();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
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
			 * player 
			 */
			var physics : PhysicsComponent = e.getComponent(PhysicsComponent);
			
			var character : CharacterComponent = e.getComponent(CharacterComponent);
			character.updateTime(_timeNow);

			var health : HealthComponent = e.getComponent(HealthComponent);
			if(!health.isAlive()) {
				_g.state = State.GAME_ENDING;				
			}

			if(health.isAlive() && !character.getHurt()) updateControls(e, physics);
			
			updateCamera(physics);
		}

		private function updateControls(e : Entity, physics : PhysicsComponent) : void {
			var player : PlayerComponent = _playerMapper.get(e);
			// player1
			var player1 : Boolean = player.playerNum == 1;
			// keys
			var left : Boolean = player1 ? _input.isDown(KeyConstants.LEFT_P1) : _input.isDown(KeyConstants.LEFT_P2);
			var right : Boolean = player1 ? _input.isDown(KeyConstants.RIGHT_P1) : _input.isDown(KeyConstants.RIGHT_P2);
			var up : Boolean = player1 ? _input.isDown(KeyConstants.UP_P1) : _input.isDown(KeyConstants.UP_P2);
			var down : Boolean = player1 ? _input.isDown(KeyConstants.DOWN_P1) : _input.isDown(KeyConstants.DOWN_P2);
			var shoot : Boolean = player1 ? _input.isDown(KeyConstants.A_P1) : _input.isDown(KeyConstants.A_P2);
//			var b : Boolean = player1 ? _input.isDown(KeyConstants.B_P1) : _input.isDown(KeyConstants.B_P2);
//			var left : Boolean = _input.isDown(KeyConstants.LEFT_P1) || _input.isDown(KeyConstants.LEFT_P2);
//			var right : Boolean = _input.isDown(KeyConstants.RIGHT_P1) || _input.isDown(KeyConstants.RIGHT_P2);
//			var up : Boolean = _input.isDown(KeyConstants.UP_P1) || _input.isDown(KeyConstants.UP_P2);
//			var down : Boolean = _input.isDown(KeyConstants.DOWN_P1) || _input.isDown(KeyConstants.DOWN_P2);
//			var a : Boolean = _input.isDown(KeyConstants.A_P1) || _input.isDown(KeyConstants.A_P2);
//			var b : Boolean = _input.isDown(KeyConstants.B_P1) || _input.isDown(KeyConstants.B_P2);

			// movement vars
			const ANGULAR_DAMPENING : Number = 0.15;

			var ROTATION_INCREMENT : Number = 0.0005 * physics.body.velocity.length;
			if (ROTATION_INCREMENT > 0.08) ROTATION_INCREMENT = 0.08;

			const MAX_VELOCITY : Number = 100;
			const IMPULSE : Number = up ? 20 : 10;
			// move
			NapeUtils.move(physics.body, _world.getDelta(), left, right, up, down, ANGULAR_DAMPENING, ROTATION_INCREMENT, MAX_VELOCITY, IMPULSE);
			
			/**
			 * weapon
			 */
			 
			if(!shoot) return;
			 
			var weapon : WeaponComponent = _weaponMapper.get(e);
			// if (_input.isDown(Keyboard.SPACE)  && weapon.getShotAt() + 100 < _timeNow) {
			if (weapon.getShotAt() + 0.1 < _timeNow) {
				/**
				 * bullet 
				 */
				var bullet : Entity = EntityFactory.createBullet(_world, e);
				var bT : TransformComponent = bullet.getComponent(TransformComponent);
				bT.setLocation(physics.body.position.x, physics.body.position.y);
				var bullet2 : Entity = EntityFactory.createBullet(_world, e);
				var bT2 : TransformComponent = bullet2.getComponent(TransformComponent);
				bT2.setLocation(physics.body.position.x, physics.body.position.y);
				/**
				 * body 
				 */
				var body : Body = PhysicsComponent(bullet.getComponent(PhysicsComponent)).body;
				body.rotation = physics.body.rotation;
				var body2 : Body = PhysicsComponent(bullet2.getComponent(PhysicsComponent)).body;
				body2.rotation = physics.body.rotation;
				/**
				 * positionVec 
				 */
				var positionVec : Vec2 = physics.body.position.add(Vec2.fromPolar(Constants.HERO_SIZE * 0.5, body.rotation - 0.2));
				var positionVec2 : Vec2 = physics.body.position.add(Vec2.fromPolar(Constants.HERO_SIZE * 0.5, body.rotation + 0.2));
				bT.setLocation(positionVec.x, positionVec.y);
				bT2.setLocation(positionVec2.x, positionVec2.y);

				/**
				 * impulseVec 
				 */
				var impulseVec : Vec2 = Vec2.fromPolar(20, body.rotation);
				body.applyImpulse(impulseVec);
				body2.applyImpulse(impulseVec);
				// VelocityComponent(bullet.getComponent(VelocityComponent)).setLocation(physicsComponent.body.position.x, physicsComponent.body.position.y);

				positionVec.dispose();
				positionVec2.dispose();
				impulseVec.dispose();

				bullet.refresh();
				bullet2.refresh();
				weapon.setShotAt(_timeNow);
			}
		}

		private function updateCamera(physics : PhysicsComponent) : void {
			// level
			var gameConfig : GameConfigComponent = _world.getTagManager().getEntity(EntityTag.GAME_CONFIG).getComponent(GameConfigComponent);
			var l : OgmoLevel = gameConfig.level;

			// clamp X & Y
			var minX : Number = 32;
			var maxX : Number = l.width - 32;
			var minY : Number = 32;
			var maxY : Number = l.height - 32;
			NapeUtils.clampPosition(physics.body, minX, maxX, minY, maxY);

			// Scroll camera
			var camWidth : Number = _g.getWidth();
			LayoutUtils.scrollCameraX(_g.camera, physics.body.velocity.x, physics.body.position.x, camWidth * 0.3, camWidth * 0.7, l.width - camWidth);
			var camHeight : Number = _g.getHeight();
			LayoutUtils.scrollCameraY(_g.camera, physics.body.velocity.y, physics.body.position.y, camHeight * 0.3, camHeight * 0.7, l.height - camHeight);
		}
	}
}
