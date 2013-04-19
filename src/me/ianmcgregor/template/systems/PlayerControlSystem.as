package me.ianmcgregor.template.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.template.components.PlayerComponent;
	import me.ianmcgregor.template.constants.KeyConstants;

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
			
			/**
			 * heroComponent 
			 */
			var playerComponent: PlayerComponent = _playerMapper.get(e);
			playerComponent;
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
			var playerComponent: PlayerComponent = _playerMapper.get(e);
			var transform: TransformComponent = _transformMapper.get(e);
			
			/**
			 * player1 
			 */
			var player1: Boolean = playerComponent.playerNum == 1;
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
			 * down 
			 */
			var down: Boolean = player1 ? _input.isDown(KeyConstants.DOWN_P1) : _input.isDown(KeyConstants.DOWN_P2);
			/**
			 * shoot 
			 */
			var shoot: Boolean = player1 ? _input.isDown(KeyConstants.SHOOT_P1) : _input.isDown(KeyConstants.SHOOT_P2);
			shoot;
			/**
			 * movement 
			 */
			var increment: Number = 2;
			
			if (left) {
				transform.addX(-increment);
			} else if (right) {
				transform.addX(increment);
			}
			if (up) {
				transform.addY(-increment);
			} else if (down) {
				transform.addY(increment);
			}
			
			/**
			 * weapon 
			 */
//			var weapon : WeaponComponent = _weaponMapper.get(e);
//			if (_input.isDown(Keyboard.SPACE)  && weapon.getShotAt() + 100 < _timeNow) {
//			if (shoot && weapon.getShotAt() + 0.1 < _timeNow) {
				/**
				 * bullet 
				 */
//				var bullet: Entity = EntityFactory.createBullet(_world, e);
//				TransformComponent(bullet.getComponent(TransformComponent)).setLocation(physicsComponent.body.position.x, physicsComponent.body.position.y);
//				bullet.refresh();
//				weapon.setShotAt(_timeNow);
//			}
		}
	}
}
