package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.InventoryComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.Constants;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerHealthSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _playerMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _inventoryMapper : ComponentMapper;
		/**
		 * _timeNow
		 */
		private var _timeNow : Number;
		private var _deadTime : Number;

		/**
		 * HeroControlSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function PlayerHealthSystem(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
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
			_healthMapper = new ComponentMapper(HealthComponent, _world);
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
			var velocity: VelocityComponent = _velocityMapper.get(e);
			var health: HealthComponent = _healthMapper.get(e);
			var transform: TransformComponent = _transformMapper.get(e);
			if(!health.isAlive()) {
				if(isNaN(_deadTime)){
					_deadTime = _timeNow;
				}
				player.dead = Constants.DEATH_GO;
				velocity.setX(0);
				velocity.setY(0);
//				transform.rotation += Math.PI * 0.125;
				if(_timeNow - 4 > _deadTime) {
					// reset player
					var inventory: InventoryComponent = e.getComponent(InventoryComponent);
					inventory.treasure = 0;
					inventory.emptyItems();
					health.restoreHealth(NaN);
					transform.rotation = 0;	
					player.dead = Constants.DEATH_NONE;
					_deadTime = NaN;
				}
			}
			
		}
	}
}
