package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;
	import me.ianmcgregor.nanotech.spatials.gfx.ParticleGfx;

	import starling.display.Sprite;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class WallSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
//		private var _gfx : ParticleGfx;
		
		public function WallSpatial(world : World, owner : Entity) {
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
			g.addChild(_gfx = new Sprite());
			_gfx.touchable = false;

			var pex : XML = ParticleAssets.CLOUD_PEX;
			var texture : Texture = ParticleAssets.CLOUD_TEX;
			var particleGfx : ParticleGfx;
			
			var currX: Number = _transform.x;
			if(currX < 30) currX = 30;
			if(currX > g.getWidth() + 40) currX = g.getWidth() + 40;
			var currY: Number = _transform.y;
			if(currY < 0) currY = 0;
			if(currY > g.getHeight()) currY = g.getHeight();
			var maxX: Number = _transform.width;
			var maxY: Number = _transform.height;
			var spacing : Number = 50;
			
			if(maxX > maxY) {
				while(currX < maxX) {
					_gfx.addChild(particleGfx = new ParticleGfx(pex, texture));
					particleGfx.x = currX;
					particleGfx.y = currY;
					currX += spacing;
				}
			} else {
				while(currY < maxY) {
					_gfx.addChild(particleGfx = new ParticleGfx(pex, texture));
					particleGfx.x = currX;
					particleGfx.y = currY;
					currY += spacing;
				}
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
			g;
//			_gfx.x = _transform.x;
//			_gfx.y = _transform.y;
//			_gfx.scaleX = _gfx.scaleY = _transform.scale;
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
				//_gfx.stop();
				g.removeChild(_gfx);
			}
		}
	}
}
