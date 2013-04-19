package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.debug.ArtemisMonitor;
	import me.ianmcgregor.games.debug.DebugDisplay;
	import me.ianmcgregor.rogue.components.DebugComponent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;


	/**
	 * @author ianmcgregor
	 */
	public final class DebugSpatial extends Spatial {
		/**
		 * components 
		 */
		private var _transform : TransformComponent;
		/**
		 * _debugComponent 
		 */
		private var _debugComponent : DebugComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : DebugDisplay;
		
		
		/**
		 * HUDSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function DebugSpatial(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g : GameContainer) : void {
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);
			/**
			 * debugMapper 
			 */
			var debugMapper : ComponentMapper = new ComponentMapper(DebugComponent, _world);
			_debugComponent = debugMapper.get(_owner);
			/**
			 * _gfx
			 */
			if(!_gfx) {
				/**
				 * Debug
				 */
				g.addChild(_gfx = new DebugDisplay());
				/**
				 * ArtemisMonitor 
				 */
				var artemisMonitor : ArtemisMonitor;
				_gfx.addChild(artemisMonitor = new ArtemisMonitor(_world, g));
				
				_gfx.visible = false;
			}
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if(!_gfx.visible) return;
			
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;
			_gfx.update();
			
			// keep on top
			if(g.getChildIndex(_gfx) < g.numChildren - 1) {
				g.setChildIndex(_gfx, g.numChildren - 1);
			}
		}
		
		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
