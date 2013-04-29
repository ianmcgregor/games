package me.ianmcgregor.chicks.assets {
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
		
		[Embed(source = "sounds/chick_fall.mp3")]
		public static const chick_fall:Class;
		
		[Embed(source = "sounds/chick_tweet_tweet.mp3")]
		public static const chick_tweet_tweet:Class;
		
		[Embed(source = "sounds/chick_tweet.mp3")]
		public static const chick_tweet:Class;
		
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
			var atlas: TextureAtlas = new TextureAtlas(texture, xml);
			System.disposeXML(xml);
			return atlas;
		}
	}
}
