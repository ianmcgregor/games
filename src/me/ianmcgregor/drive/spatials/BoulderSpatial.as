package me.ianmcgregor.drive.spatials {
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.spatials.gfx.template.ImageGfx;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class BoulderSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : ImageGfx;
		/*
		 * components
		 */
		private var _transform : TransformComponent;

		/**
		 * Spatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BoulderSpatial(world : World, owner : Entity) {
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
			 * mappers 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			/**
			 * gfx
			 */
			g.addChild(_gfx = new ImageGfx(g.assets.getTexture(Constants.BOULDER)));
			_gfx.name = Constants.TREE;
			_gfx.pivotX = 32;
			_gfx.pivotY = 32;
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
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
