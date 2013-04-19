package me.ianmcgregor.nanotech.spatials.gfx {
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public class ParticleGfx extends PDParticleSystem {
//		private var _particleSystem : PDParticleSystem;
		public function ParticleGfx(pex: XML, tex: Texture) {
			super(pex, tex);
			
			// create particle system
			//_particleSystem = new PDParticleSystem(pex, tex);

			// add it to the stage and the juggler
//			Starling.juggler.add(_particleSystem);
			Starling.juggler.add(this);
			
//			addChild(_particleSystem);
			
			// ps.x = _transform.x;
			// ps.y = _transform.y;
//			_particleSystem.emitterX = _transform.x;
//			_particleSystem.emitterY = _transform.y;

//			if (_life <= 0) {
//				_particleSystem.stop();
//				Starling.juggler.remove(_particleSystem);
//				g.removeChild(_particleSystem);
//			}

			// change position where particles are emitted
			// ps.emitterX = 20;
			// ps.emitterY = 40;

			// start emitting particles
//			_particleSystem.start();

			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			start();
		}
		
//		override public function set x(value : Number) : void {
//			emitterX = value;
//		}
//		
//		override public function set y(value : Number) : void {
//			emitterY = value;
//		}
		
		override public function stop(clearParticles:Boolean=false): void {
			super.stop(clearParticles);
//			_particleSystem.stop();
//			Starling.juggler.remove(_particleSystem);
			Starling.juggler.remove(this);
		}
	}
}
