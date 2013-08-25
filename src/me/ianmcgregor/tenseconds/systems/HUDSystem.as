package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.tenseconds.components.HUDComponent;
	import me.ianmcgregor.tenseconds.components.PlayerComponent;
	import me.ianmcgregor.tenseconds.constants.EntityTag;

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
			var h: HealthComponent = _healthMapper.get(e);
			if(_hudComponent)_hudComponent.player[p.playerNum].health = h.getHealthPercentage();
		}
	}
}