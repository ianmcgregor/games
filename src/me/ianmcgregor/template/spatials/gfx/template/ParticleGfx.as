package me.ianmcgregor.template.spatials.gfx.template {
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public class ParticleGfx extends PDParticleSystem {
		public function ParticleGfx(pex: XML, tex: Texture) {
			super(pex, tex);
			Starling.juggler.add(this);

			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			start();
		}
		
		override public function stop(clearParticles:Boolean=false): void {
			super.stop(clearParticles);
			Starling.juggler.remove(this);
		}
	}
}
