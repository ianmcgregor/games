package me.ianmcgregor.template.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Image;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class BgSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Image;
		
		/**
		 * NullSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BgSpatial(world : World, owner : Entity) {
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
			
//			g.addChild(_gfx = new Image(g.assets.getTexture("background1")));
			g.addChild(_gfx = new Image(Texture.fromColor(g.getWidth(), g.getHeight(), 0x777777)));
			_gfx.touchable = false;
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
//			_gfx.x = _transform.x + _gfx.pivotX;
//			_gfx.y = _transform.y + _gfx.pivotY;
//			_gfx.rotation = _transform.rotation;
			
//			Logger.log("NullSpatial.render()", 2, 3);
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
