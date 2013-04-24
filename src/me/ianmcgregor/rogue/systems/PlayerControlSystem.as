package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.rogue.components.InventoryComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.KeyConstants;

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
		private var _inventoryMapper : ComponentMapper;
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
			_inventoryMapper = new ComponentMapper(InventoryComponent, _world);
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
			var player: PlayerComponent = _playerMapper.get(e);
			if( player.dead != Constants.DEATH_NONE ) return;
			
			var velocity: VelocityComponent = _velocityMapper.get(e);
			
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
			var increment: Number = _world.getDelta() * Constants.PLAYER_VELOCITY;
			var dampening: Number = 1 - _world.getDelta() * Constants.PLAYER_VELOCITY_DAMPENING;
			
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
			/**
			 * weapon 
			 */
//			var weapon : WeaponComponent = _weaponMapper.get(e);
			if (shoot && player.attack == Constants.ATTACK_READY) {//&& weapon.getShotAt() + 0.3 < _timeNow) {
				var inventory: InventoryComponent = _inventoryMapper.get(e);
				if(inventory.weapon) player.attack = Constants.ATTACK_GO;
				
//				var inventory: InventoryComponent = _inventoryMapper.get(e);
//				var tag : String = player.playerNum == 1 ? EntityTag.WEAPON_PLAYER_1 : EntityTag.WEAPON_PLAYER_2;
//				var s: Entity = _world.getTagManager().getEntity(tag);
//				var sword: SwordComponent = s.getComponent(SwordComponent);
//				if(sword.brandished < 0) {
//					sword.brandished = 20;
//					weapon.setShotAt(_timeNow);
//				}
//				switch(inventory.weapon){
//					case null:
//						break;
//					default:
//				}
//				fireArrow(e, weapon);

			}
		}

		/**
		 * arrow 
		 */
//		private function fireArrow(e : Entity, weapon : WeaponComponent) : void {
//			var bullet : Entity = EntityFactory.createBullet(_world, e);
//			TransformComponent(bullet.getComponent(TransformComponent)).setLocation(physicsComponent.body.position.x, physicsComponent.body.position.y);
//			bullet.refresh();
//			weapon.setShotAt(_timeNow);
//		}
	}
}
