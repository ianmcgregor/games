package me.ianmcgregor.fight.assets {
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import flash.display.Bitmap;
	import flash.system.System;

	/**
	 * @author McFamily
	 */
	public final class Assets {
		/**
		 * Classes for embedded images should have the exact same name as the file, without extension. 
		 * This is required so that references from XMLs (atlas, bitmap font) won't break.
		 * 
		 * This name is also used to retrieve the TextureAtlas via GameContainer.assets.getTextureAtlas(name)
		 */
		[Embed(source="sprites.png")]
		public static const sprites : Class;
		[Embed(source="sprites.xml", mimeType="application/octet-stream")]
		public static const spritesXML : Class;
		/**
		 * Sounds
		 */
		[Embed(source = "sounds/Explosion19.mp3")]
		public static const Explosion19 : Class;
		[Embed(source = "sounds/Explosion20.mp3")]
		public static const Explosion20 : Class;
		[Embed(source = "sounds/Hit_Hurt28.mp3")]
		public static const Hit_Hurt28 : Class;
		[Embed(source = "sounds/Hit_Hurt36.mp3")]
		public static const Hit_Hurt36 : Class;
		[Embed(source = "sounds/Hit_Hurt39.mp3")]
		public static const Hit_Hurt39 : Class;
		[Embed(source = "sounds/Hit_Hurt52.mp3")]
		public static const Hit_Hurt52 : Class;
		[Embed(source = "sounds/Hit_Hurt57.mp3")]
		public static const Hit_Hurt57 : Class;
		[Embed(source = "sounds/Jump23.mp3")]
		public static const Jump23 : Class;
		[Embed(source = "sounds/Jump24.mp3")]
		public static const Jump24 : Class;
		[Embed(source = "sounds/Pickup_Coin19.mp3")]
		public static const Pickup_Coin19 : Class;
		[Embed(source = "sounds/Powerup24.mp3")]
		public static const Powerup24 : Class;
		[Embed(source = "sounds/Powerup26.mp3")]
		public static const Powerup26 : Class;
		[Embed(source = "sounds/Randomize50.mp3")]
		public static const Randomize50 : Class;
		[Embed(source = "sounds/Randomize51.mp3")]
		public static const Randomize51 : Class;
		/**
		 * Fonts
		 */
		[Embed(source="fonts/fightfont.fnt", mimeType="application/octet-stream")]
		public static const fightfontXml : Class;
		[Embed(source = "fonts/fightfont.png")]
		public static const fightfont : Class;
		
		/**
		 * createTextureAtlas 
		 * 
		 * @param SpriteSheetClass 
		 * @param XMLClass 
		 * 
		 * @return 
		 */
		public static function createTextureAtlas(SpriteSheetClass : Class, XMLClass : Class) : TextureAtlas {
			/**
			 * texture 
			 */
			var texture : Texture = Texture.fromBitmap(new SpriteSheetClass as Bitmap);
			/**
			 * xml 
			 */
			var xml : XML = XML(new XMLClass());
			/**
			 * atlas 
			 */
			var atlas : TextureAtlas = new TextureAtlas(texture, xml);
			System.disposeXML(xml);
			return atlas;
		}
	}
}
