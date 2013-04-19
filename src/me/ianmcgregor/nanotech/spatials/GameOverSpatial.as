package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.nanotech.components.GameOverComponent;
	import me.ianmcgregor.nanotech.spatials.gfx.GameOverGfx;

	import starling.events.Event;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class GameOverSpatial extends Spatial {
		/**
		 * components 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gameOverComponent 
		 */
		private var _gameOverComponent : GameOverComponent;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * _gfx 
		 */
		private var _gfx : GameOverGfx;
		
		
		/**
		 * GameOverSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function GameOverSpatial(world : World, owner : Entity) {
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
			var gameOverMapper : ComponentMapper = new ComponentMapper(GameOverComponent, _world);
			_gameOverComponent = gameOverMapper.get(_owner);
			/**
			 * _gfx
			 */
			if(!_gfx)_gfx = new GameOverGfx(g.getWidth(), g.getHeight());
			g.addChild(_gfx);
			_gfx.addEventListener(Event.TRIGGERED, onTrigger);
		}

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
