package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.components.HUDComponent;
	import me.ianmcgregor.nanotech.spatials.gfx.HUDGfx;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSpatial extends Spatial {
		/**
		 * components 
		 */
		private var _transform : TransformComponent;
		/**
		 * _hudComponent 
		 */
		private var _hud : HUDComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : HUDGfx;
		
		
		/**
		 * HUDSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function HUDSpatial(world : World, owner : Entity) {
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
			 * titlesMapper 
			 */
			var hudMapper : ComponentMapper = new ComponentMapper(HUDComponent, _world);
			_hud = hudMapper.get(_owner);
			/**
			 * _gfx
			 */
			if(!_gfx)_gfx = new HUDGfx(g.getWidth(), g.getHeight());
			g.addChild(_gfx);
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
			
			var hudText: String = "PLAYER 1 " + _hud.player[1].toString();
			hudText += "     PLAYER 2 " + _hud.player[2].toString();

			var friendshealth : Number = _hud.getFriendHealthPercent() * 100;
			hudText += "     CELLS: " + friendshealth.toFixed() + "%";
			
			_gfx.text = hudText;
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
