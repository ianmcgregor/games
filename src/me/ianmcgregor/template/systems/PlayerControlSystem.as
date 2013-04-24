package me.ianmcgregor.template.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.template.components.PlayerComponent;
	import me.ianmcgregor.template.components.VelocityComponent;
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
		private var _velocityMapper : ComponentMapper;
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
			_velocityMapper = new ComponentMapper(VelocityComponent, _world);
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
			var player: PlayerComponent = _playerMapper.get(e);
			var velocity: VelocityComponent = _velocityMapper.get(e);
			var transform: TransformComponent = _transformMapper.get(e);
			
			/**
			 * player1 
			 */
			var player1: Boolean = player.playerNum == 1;
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
			var shoot: Boolean = player1 ? _input.justPressed(KeyConstants.SHOOT_P1) : _input.justPressed(KeyConstants.SHOOT_P2);
			/**
			 * movement 
			 */
			var increment: Number = _world.getDelta() * 20;
			var dampening: Number = 1 - _world.getDelta() * 10;
			
			if (left) {
				if(velocity.getX() > 0) velocity.setX(0);
				velocity.addX(-increment);
			} else if (right) {
				if(velocity.getX() < 0) velocity.setX(0);
				velocity.addX(increment);
			} else {
				velocity.dampenX(dampening);
			}
			if (up) {
				if(velocity.getY() > 0) velocity.setY(0);
				velocity.addY(-increment);
			} else if (down) {
				if(velocity.getY() < 0) velocity.setY(0);
				velocity.addY(increment);
			} else {
				velocity.dampenY(dampening);
			}
			
			// update transform
			transform.addX(velocity.getX());
			transform.addY(velocity.getY());
			
			/**
			 * weapon 
			 */
//			var weapon : WeaponComponent = _weaponMapper.get(e);
			if (shoot) {//&& weapon.getShotAt() + 0.3 < _timeNow) {
			}
		}
	}
}
