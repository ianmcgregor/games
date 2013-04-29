package me.ianmcgregor.chicks.systems {
	import me.ianmcgregor.chicks.components.SoundComponent;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class SoundSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _soundMapper : ComponentMapper;

		/**
		 * SoundSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function SoundSystem(g : GameContainer) {
			super(SoundComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_soundMapper = new ComponentMapper(SoundComponent, _world);
		}

		/**
		 * added - Play sounds when entities added e.g. bullets or explosions
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			// Could filter on group as below or specify in SoundComponent
			
			/**
			 * soundComponent 
			 */
			var soundComponent: SoundComponent = _soundMapper.get(e);
			if(soundComponent.added) {
				trigger(soundComponent.added);
			}
			
			/**
			 * group 
			 */
//			var group: String = _world.getGroupManager().getGroupOf(e);
//			switch(group){
//				case EntityGroup.NULL:
//					
//					break;
//				default:
//			}
		}

		/**
		 * removed - Play sounds when entities removed
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			/**
			 * soundComponent 
			 */
			var soundComponent: SoundComponent = _soundMapper.get(e);
			if(soundComponent.removed) {
				trigger(soundComponent.removed);
			}
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
			 * soundComponent 
			 */
			var soundComponent: SoundComponent = _soundMapper.get(e);
			if(soundComponent.trigger) {
				trigger(soundComponent.trigger);
				soundComponent.trigger = null;
			}
		}

		/**
		 * trigger 
		 * 
		 * @param trigger 
		 * 
		 * @return 
		 */
		private function trigger(name : String) : void {
			if(!name) return;
		}
	}
}
