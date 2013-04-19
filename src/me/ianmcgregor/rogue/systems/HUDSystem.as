package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.HUDComponent;
	import me.ianmcgregor.rogue.components.InventoryComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _hudMapper : ComponentMapper;
		private var _hudComponent : HUDComponent;
		private var _inventoryMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;
		private var _playerMapper : ComponentMapper;

		/**
		 * SoundSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function HUDSystem(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_hudMapper = new ComponentMapper(HUDComponent, _world);
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
			_inventoryMapper = new ComponentMapper(InventoryComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
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
			 * hudComponent 
			 */
//			_hudComponent = _hudMapper.get(e);
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
			_hudComponent = _hudMapper.get(_world.getTagManager().getEntity(EntityTag.HUD));
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var p: PlayerComponent = _playerMapper.get(e);
			var i: InventoryComponent = _inventoryMapper.get(e);
			var h: HealthComponent = _healthMapper.get(e);
			_hudComponent.player[p.playerNum].health = h.getHealthPercentage();
			_hudComponent.player[p.playerNum].inventory = i;
		}
	}
}
