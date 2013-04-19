package me.ianmcgregor.rogue.assets {
	/**
	 * @author ianmcgregor
	 */
	public final class Levels {
		
		/**
		 * Once parsed by the OgmoParser the level names will be the class names.
		 */
		
		[Embed(source="maps/Level4.oel", mimeType="application/octet-stream")] 
		public static const Level4:Class;
		
		[Embed(source="maps/Level3.oel", mimeType="application/octet-stream")] 
		public static const Level3:Class;
		
		
		[Embed(source="maps/Level0.oel", mimeType="application/octet-stream")] 
		public static const Level0:Class;
		
		[Embed(source="maps/Level1.oel", mimeType="application/octet-stream")] 
		public static const Level1:Class;
		
		[Embed(source="maps/Level.oel", mimeType="application/octet-stream")] 
		public static const Level:Class;

		[Embed(source="maps/Level2.oel", mimeType="application/octet-stream")] 
		public static const Level2:Class;
		
	}
}
