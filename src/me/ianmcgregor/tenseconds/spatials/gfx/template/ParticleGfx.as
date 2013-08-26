package me.ianmcgregor.tenseconds.spatials.gfx.template {
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public final class ParticleGfx extends PDParticleSystem {
		public function ParticleGfx(pex: XML, tex: Texture, startNow: Boolean = true, duration:Number=Number.MAX_VALUE) {
			super(pex, tex);

			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			if(startNow) {
				start(duration);
			}
		}
		
		override public function start(duration : Number = Number.MAX_VALUE) : void {
			Starling.juggler.add(this);
			super.start(duration);
		}
		
		override public function stop(clearParticles:Boolean=false): void {
			super.stop(clearParticles);
			Starling.juggler.remove(this);
		}
	}
}
