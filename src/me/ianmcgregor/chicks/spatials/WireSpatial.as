package me.ianmcgregor.chicks.spatials {
	import starling.display.Sprite;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Image;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class WireSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		
		/**
		 * NullSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function WireSpatial(world : World, owner : Entity) {
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
			_gfx = new Sprite();
			var img: Image;
			_gfx.addChild( img = new Image(g.assets.getTexture("wire")) );
			_gfx.addChild( img = new Image(g.assets.getTexture("wire")) );
			img.y = 32;
			g.addChild(_gfx);
			_gfx.flatten();
			_gfx.touchable = false;
//			_gfx.pivotX = _gfx.pivotY = 16;
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			_gfx.x = _transform.x - g.camera.x;
			_gfx.y = _transform.y - g.camera.y;
			_gfx.rotation = _transform.rotation;
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
