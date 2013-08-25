package me.ianmcgregor.tenseconds.assets {
	/**
	 * @author ianmcgregor
	 */
	public final class Levels {
		
		/**
		 * Once parsed by the OgmoParser the level names will be the class names.
		 */
		
		[Embed(source="levels/Level.oel", mimeType="application/octet-stream")] 
		public static const Level:Class;

	}
}
