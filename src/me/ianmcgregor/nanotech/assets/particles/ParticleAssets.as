package me.ianmcgregor.nanotech.assets.particles {
	import starling.textures.Texture;
	/**
	 * @author McFamily
	 */
	public class ParticleAssets {
		//
		[Embed(source="texture.png")]
		private static const particleTEX : Class;
		[Embed(source="particle.pex", mimeType="application/octet-stream")]
		private static const particlePEX : Class;
		
		public static const PARTICLE_PEX:XML = XML(new particlePEX());
		public static const PARTICLE_TEX:Texture = Texture.fromBitmap(new particleTEX());
		
		//
		[Embed(source="texture2.png")]
		private static const particleTEX2 : Class;
		[Embed(source="particle2.pex", mimeType="application/octet-stream")]
		private static const particlePEX2 : Class;
		
		public static const PARTICLE_PEX2:XML = XML(new particlePEX2());
		public static const PARTICLE_TEX2:Texture = Texture.fromBitmap(new particleTEX2());
		
		//
		[Embed(source="textureP2.png")]
		private static const particleTEX_P2 : Class;
		[Embed(source="particleP2.pex", mimeType="application/octet-stream")]
		private static const particlePEX_P2 : Class;
		
		public static const PARTICLE_PEX_P2:XML = XML(new particlePEX_P2());
		public static const PARTICLE_TEX_P2:Texture = Texture.fromBitmap(new particleTEX_P2());
		
		//
		[Embed(source="bullet.png")]
		private static const bulletTEX : Class;
		[Embed(source="bullet.pex", mimeType="application/octet-stream")]
		private static const bulletPEX : Class;
		
		public static const BULLET_PEX:XML = XML(new bulletPEX());
		public static const BULLET_TEX:Texture = Texture.fromBitmap(new bulletTEX());
		
		//
		[Embed(source="enemy.png")]
		private static const enemyTEX : Class;
		[Embed(source="enemy.pex", mimeType="application/octet-stream")]
		private static const enemyPEX : Class;
		
		public static const ENEMY_PEX:XML = XML(new enemyPEX());
		public static const ENEMY_TEX:Texture = Texture.fromBitmap(new enemyTEX());
		
		//
		[Embed(source="cloud.png")]
		private static const cloudTEX : Class;
		[Embed(source="cloud.pex", mimeType="application/octet-stream")]
		private static const cloudPEX : Class;
		
		public static const CLOUD_PEX:XML = XML(new cloudPEX());
		public static const CLOUD_TEX:Texture = Texture.fromBitmap(new cloudTEX());
		
		//
		[Embed(source="cloud5.png")]
		private static const cloud2TEX : Class;
		[Embed(source="cloud5.pex", mimeType="application/octet-stream")]
		private static const cloud2PEX : Class;
		
		public static const CLOUD_2_PEX:XML = XML(new cloud2PEX());
		public static const CLOUD_2_TEX:Texture = Texture.fromBitmap(new cloud2TEX());
		
		//
		[Embed(source="thrust.png")]
		private static const thrustTEX : Class;
		[Embed(source="thrust.pex", mimeType="application/octet-stream")]
		private static const thrustPEX : Class;
		
		public static const THRUST_PEX:XML = XML(new thrustPEX());
		public static const THRUST_TEX:Texture = Texture.fromBitmap(new thrustTEX());
	}
}
