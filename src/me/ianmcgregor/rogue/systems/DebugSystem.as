package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.debug.Logger;
	import me.ianmcgregor.rogue.components.DebugComponent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;

	import flash.utils.Dictionary;

	/**
	 * @author ianmcgregor
	 */
	public final class DebugSystem extends IntervalEntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _debugMapper : ComponentMapper;
		/**
		 * _debugComponent 
		 */
		private var _debugComponent : DebugComponent;
		/**
		 * _counter 
		 */
		private const _counter : Dictionary = new Dictionary();

		/**
		 * DebugSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function DebugSystem(g : GameContainer) {
			super(1000, DebugComponent, []);
			_g = g;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			/**
			 * _debugMapper 
			 */
			_debugMapper = new ComponentMapper(DebugComponent, _world);
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
			
			for (var i : Object in _counter) {
				_counter[i] = 0;
			}
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
//			trace("DebugSystem.processEntity(",e,")");
			_debugComponent = _debugMapper.get(e);

			var type : String = _debugComponent.entityType;
			
			if(!type) return;
			
			if (_counter[type] == null) {
				_counter[type] = 0;
			}
			
			(_counter[type])++;
		}
		
		/**
		 * end 
		 * 
		 * @return 
		 */
		override protected function end() : void {
			Logger.clear();
			var types: String = "";
			for (var i : Object in _counter) {
				if(types != "") types += "\n"; 
				types += i + ": " + _counter[i];
			}
			Logger.log("ENTITY TYPES:\n" + types);
		}

	}
}
