package me.ianmcgregor.racer.spatials.gfx {
	/**
	 * @author ianmcgregor
	 */
	public interface ITileGfx {
		/**
		 * draw 
		 * 
		 * @param row 
		 * @param col 
		 * @param z 
		 * 
		 * @return 
		 */
		function draw(row: Number, col: Number, z: Number) : void;
	}
}
