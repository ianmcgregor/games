package me.ianmcgregor.games.base {
	import flash.geom.Rectangle;
	/**
	 * @author ianmcgregor
	 */
	public interface IStartupImage {
		/**
		 * init 
		 * 
		 * @param viewPort 
		 * @param isHD 
		 * 
		 * @return 
		 */
		function init(viewPort : Rectangle): void;
		
		/**
		 * remove 
		 * 
		 * @return 
		 */
		function remove() : void;
	}
}
