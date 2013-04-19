package me.ianmcgregor.racer.assets {
	/**
	 * @author McFamily
	 */
	public class Assets {
		/**
		 * Classes for embedded images should have the exact same name as the file, without extension. 
		 * This is required so that references from XMLs (atlas, bitmap font) won't break.
		 * 
		 * This name is also used to retrieve the TextureAtlas via GameContainer.assets.getTextureAtlas(name)
		 */
		 
		// ui
		[Embed(source="images/ui/onegame.png")]
		public static const OneGameLogo : Class;
		// tiles
		[Embed(source="images/tiles/tiles.png")]
		public static const tiles : Class;
		[Embed(source="images/tiles/tiles.xml", mimeType="application/octet-stream")]
		public static const tilesXML : Class;
		// cars
		[Embed(source="images/cars/cars.png")]
		public static const cars : Class;
		[Embed(source="images/cars/cars.xml", mimeType="application/octet-stream")]
		public static const carsXML : Class;
		// lights
		[Embed(source="images/lights/lights_off.png")]
		public static const LIGHTS_OFF : Class;
		[Embed(source="images/lights/lights_red.png")]
		public static const LIGHTS_RED : Class;
		[Embed(source="images/lights/lights_amber.png")]
		public static const LIGHTS_AMBER : Class;
		[Embed(source="images/lights/lights_green.png")]
		public static const LIGHTS_GREEN : Class;
	}
}
