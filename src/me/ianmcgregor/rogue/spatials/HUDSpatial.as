package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.HUDComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.spatials.gfx.HUDGfx;

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
		private var _hudComponent : HUDComponent;
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
			_hudComponent = hudMapper.get(_owner);
			/**
			 * players
			 */
			var isTwoPlayer: Boolean = _world.getTagManager().getEntity(EntityTag.PLAYER_2) != null;
			/**
			 * _gfx
			 */
//			if(!_gfx)_gfx = new HUDGfx(g.getWidth(), g.getHeight(), g.assets.getTextureAtlas(Constants.TILE_ATLAS));
			if(!_gfx)_gfx = new HUDGfx(g.getWidth(), g.getHeight(), g.assets.getTextureAtlas(Constants.TILE_ATLAS), isTwoPlayer);
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
			
			if(_hudComponent.player[1].inventory) {
				_gfx.update(1, _hudComponent.player[1].health, _hudComponent.player[1].inventory);
				
				if(_hudComponent.player[2].inventory)
					_gfx.update(2, _hudComponent.player[2].health, _hudComponent.player[2].inventory);
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
