package me.ianmcgregor.template.assets {
	/**
	 * @author ianmcgregor
	 */
	public final class Levels {
		
		/**
		 * Once parsed by the OgmoParser the level names will be the class names.
		 */
		
		[Embed(source="levels/Level01.oel", mimeType="application/octet-stream")] 
		public static const Level01:Class;

//		[Embed(source="levels/Level02.oel", mimeType="application/octet-stream")] 
//		public static const Level02:Class;
	}
}
