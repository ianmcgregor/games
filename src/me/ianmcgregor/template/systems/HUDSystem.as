package me.ianmcgregor.template.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.template.components.HUDComponent;

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

		/**
		 * SoundSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function HUDSystem(g : GameContainer) {
			super(HUDComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_hudMapper = new ComponentMapper(HUDComponent, _world);
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
			var hudComponent: HUDComponent = _hudMapper.get(e);
			hudComponent;
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
			 * hudComponent 
			 */
			var hudComponent: HUDComponent = _hudMapper.get(e);
			hudComponent;
		}
	}
}
