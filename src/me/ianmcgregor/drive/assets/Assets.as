package me.ianmcgregor.drive.assets {
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
		[Embed(source = "sounds/bullet.mp3")]
		public static const bullet : Class;
		[Embed(source = "sounds/explode.mp3")]
		public static const explode : Class;
		[Embed(source = "sounds/explode2.mp3")]
		public static const explode2 : Class;
		[Embed(source = "sounds/levelup.mp3")]
		public static const levelup : Class;
		[Embed(source = "sounds/powerup.mp3")]
		public static const powerup : Class;
		[Embed(source = "sounds/select.mp3")]
		public static const select : Class;
		/**
		 * Fonts
		 */
		[Embed(source="fonts/font.fnt", mimeType="application/octet-stream")]
		public static const fontXml : Class;
		[Embed(source = "fonts/font.png")]
		public static const font : Class;
		
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
