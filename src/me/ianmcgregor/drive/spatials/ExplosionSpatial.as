package me.ianmcgregor.drive.spatials {
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.spatials.gfx.template.MovieClipGfx;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class ExplosionSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : MovieClipGfx;
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
		public function ExplosionSpatial(world : World, owner : Entity) {
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
			var textures : Vector.<Texture> = g.assets.getTextures(Constants.EXPLOSION);
			g.addChild(_gfx = new MovieClipGfx(textures));
			_gfx.name = Constants.EXPLOSION;
			_gfx.pivotX = 32;
			_gfx.pivotY = 32;
			_gfx.touchable = false;
			_gfx.loop = false;
//			Starling.juggler.add(_gfx);
			_gfx.play();
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
			
			_gfx.advanceTime(_world.getDelta());
			if(_gfx.isComplete) {
				_world.deleteEntity(_owner);
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
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
//				Starling.juggler.remove(_gfx);
			}
		}
	}
}
