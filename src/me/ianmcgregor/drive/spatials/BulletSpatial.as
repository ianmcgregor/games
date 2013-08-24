package me.ianmcgregor.drive.spatials {
	import me.ianmcgregor.drive.constants.Constants;
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
	public final class BulletSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : Image;
//		private var _gfx : ParticleGfx;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		
		/**
		 * BulletSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BulletSpatial(world : World, owner : Entity) {
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
			 * textures
			 */
			 
			var size: Number = Constants.BULLET_SIZE;
			
			if(!g.assets.getTexture(Constants.BULLET)){
				g.assets.addTexture(Constants.BULLET, Texture.fromColor(Constants.BULLET_SIZE, Constants.BULLET_SIZE, 0xFFFFFFFF));	
			}
			
			/**
			 * gfx
			 */
			g.addChild(_gfx = new Image(g.assets.getTexture(Constants.BULLET)));
//			g.addChild(_gfx = new ParticleGfx(ParticleAssets.BULLET_PEX, ParticleAssets.BULLET_TEX));
			_gfx.touchable = false;
			_gfx.pivotX = _gfx.pivotY = size * 0.5;
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			_gfx.x = _transform.x + - g.camera.x;
			_gfx.y = _transform.y + - g.camera.y;
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
//				_gfx.stop();
				g.removeChild(_gfx);
			}
		}
	}
}
