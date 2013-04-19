package me.ianmcgregor.species.assets {
	import starling.textures.Texture;

	import flash.display.BitmapData;
	/**
	 * @author McFamily
	 */
	public class Assets {
		
//		[Embed(source = "tiles/trimmed/assets.png")]
//		public static const SpriteSheet : Class;
//		[Embed(source="tiles/trimmed/assets.xml", mimeType="application/octet-stream")] 
//		public static const SpriteSheetXML:Class;
		
		///// PARTICLES
		
		// embed configuration XML
		[Embed(source="particles/explode.pex", mimeType="application/octet-stream")]
		private static const ExplodePex:Class;
		// embed particle texture
		[Embed(source = "particles/explode.png")]
		private static const ExplodeTexture:Class;
		
		public static const explodePex:XML = XML(new ExplodePex());
		public static const explodeTexture:Texture = Texture.fromBitmap(new ExplodeTexture());
		
		[Embed(source="particles/bomb.pex", mimeType="application/octet-stream")]
		public static const BombPex:Class;
		[Embed(source = "particles/bomb.png")]
		public static const BombTexture:Class;

		[Embed(source="particles/fireball.pex", mimeType="application/octet-stream")]
		public static const FireBallPex:Class;
		 
		[Embed(source = "particles/fireball.png")]
		public static const FireBallTexture:Class;
		
		[Embed(source="particles/fireball2.pex", mimeType="application/octet-stream")]
		private static const FireBall2Pex:Class;
		[Embed(source = "particles/fireball2.png")]
		private static const FireBall2Texture:Class;
		
		public static const fireBall2Pex:XML = XML(new FireBall2Pex());
		public static const fireBall2Texture:Texture = Texture.fromBitmap(new FireBall2Texture());
				
		///// TILEMAPS
		
		[Embed(source="tilemaps/Level_1.oel", mimeType="application/octet-stream")] 
		private static const Level1:Class;

		[Embed(source="tilemaps/Level_2.oel", mimeType="application/octet-stream")] 
		private static const Level2:Class;

		[Embed(source="tilemaps/Level_3.oel", mimeType="application/octet-stream")] 
		private static const Level3:Class;
		
		[Embed(source="tilemaps/Level_4.oel", mimeType="application/octet-stream")] 
		private static const Level4:Class;
		
		[Embed(source="tilemaps/Level_5.oel", mimeType="application/octet-stream")] 
		private static const Level5:Class;
		
		/**
		 * getLevel 
		 * 
		 * @param num 
		 * 
		 * @return 
		 */
		public static function getLevel(num: int): XML {
			switch(num){
				case 1:
					return XML(new Level1());
					break;
				case 2:
					return XML(new Level2());
					break;
				case 3:
					return XML(new Level3());
					break;
				case 4:
					return XML(new Level4());
					break;
				case 5:
					return XML(new Level5());
					break;
				default:
			}
			return null;
		}
		
		public static const tiles: Array = [Texture.fromBitmapData(new BitmapData(16, 16, false, 0xFF444444)), Texture.fromBitmapData(new BitmapData(16, 16, false, 0xFF6C340B))];
		
		[Embed(source = "characters/LD24_assets0001.png")]
		private static const HeroTexture1:Class;
		[Embed(source = "characters/LD24_assets0002.png")]
		private static const HeroTexture2:Class;

		public static const heroTexture1:Texture = Texture.fromBitmap(new HeroTexture1());
		public static const heroTexture2:Texture = Texture.fromBitmap(new HeroTexture2());
		
		[Embed(source = "characters/LD24_assets0003.png")]
		private static const FriendTexture1:Class;
		[Embed(source = "characters/LD24_assets0004.png")]
		private static const FriendTexture2:Class;

		public static const friendTexture1:Texture = Texture.fromBitmap(new FriendTexture1());
		public static const friendTexture2:Texture = Texture.fromBitmap(new FriendTexture2());

		[Embed(source = "characters/LD24_assets0005.png")]
		private static const EnemyGunTexture1:Class;
		[Embed(source = "characters/LD24_assets0006.png")]
		private static const EnemyGunTexture2:Class;

		public static const enemyGunTexture1:Texture = Texture.fromBitmap(new EnemyGunTexture1());
		public static const enemyGunTexture2:Texture = Texture.fromBitmap(new EnemyGunTexture2());

		[Embed(source = "characters/LD24_assets0007.png")]
		private static const EnemyMoustacheTexture1:Class;
		[Embed(source = "characters/LD24_assets0008.png")]
		private static const EnemyMoustacheTexture2:Class;
		
		public static const enemyMoustacheTexture1:Texture = Texture.fromBitmap(new EnemyMoustacheTexture1());
		public static const enemyMoustacheTexture2:Texture = Texture.fromBitmap(new EnemyMoustacheTexture2());
	}
}
