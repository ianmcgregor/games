package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.rogue.components.TitlesComponent;
	import me.ianmcgregor.rogue.spatials.gfx.TitlesGfx;

	import starling.events.Event;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class TitlesSpatial extends Spatial {
		/**
		 * components 
		 */
		private var _transform : TransformComponent;
		/**
		 * _titlesComponent 
		 */
		private var _titlesComponent : TitlesComponent;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * _gfx 
		 */
		private var _gfx : TitlesGfx;
		
		
		/**
		 * TitlesSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function TitlesSpatial(world : World, owner : Entity) {
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
			 * input
			 */
			_input = g.getInput();
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);
			/**
			 * titlesMapper 
			 */
			var titlesMapper : ComponentMapper = new ComponentMapper(TitlesComponent, _world);
			_titlesComponent = titlesMapper.get(_owner);
			/**
			 * _gfx
			 */
			if(!_gfx)_gfx = new TitlesGfx(g.getWidth(), g.getHeight());
			g.addChild(_gfx);
			_gfx.addEventListener(Event.TRIGGERED, onTrigger);
			
			// FIXME:
//			g.visible = false;
		}

		/**
		 * onTrigger 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */

		private function onTrigger(event : Event) : void {
			event.stopImmediatePropagation();
			_gfx.removeEventListener(Event.TRIGGERED, onTrigger);
			_input.setKeyDown(event.data as uint);
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			g;
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;
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
