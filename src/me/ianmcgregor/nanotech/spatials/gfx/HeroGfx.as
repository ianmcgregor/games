package me.ianmcgregor.nanotech.spatials.gfx {
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public final class HeroGfx extends Sprite {
		private var _thrust : ParticleGfx;
		private var _maxParticles : int;
		private var _lifespan : Number;
		/**
		 * HeroGfx 
		 */
		public function HeroGfx(texture : Texture) {
			super();
			
			/**
			 * gfx 
			 */
			var gfx: Image = new Image(texture);
			addChild(gfx);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
//			addChild(_thrust = new ParticleGfx(ParticleAssets.BULLET_PEX, ParticleAssets.BULLET_TEX));
			addChildAt(_thrust = new ParticleGfx(ParticleAssets.THRUST_PEX, ParticleAssets.THRUST_TEX), 0);
			_thrust.rotation = Math.PI * 0.5;
			_thrust.x = 15;
			_thrust.y = 65;
			
			_maxParticles = _thrust.maxNumParticles;
			_lifespan = _thrust.lifespan;
			
//			flatten();
			
		}
		
		public function updateThrust(isThrusting: Boolean): void {
			_thrust.maxNumParticles = isThrusting ? _maxParticles : 1; 
			_thrust.lifespan = isThrusting ? _lifespan : 0.1; 
		}
	}
}
