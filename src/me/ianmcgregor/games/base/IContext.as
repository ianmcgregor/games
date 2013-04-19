package me.ianmcgregor.games.base {
	import com.artemis.World;
	/**
	 * @author McFamily
	 */
	public interface IContext {

		/**
		 * init 
		 * 
		 * @return 
		 */
		function init() : void;

		/**
		 * update 
		 * 
		 * @param deltaTime 
		 * 
		 * @return 
		 */
		function update(deltaTime : Number) : void;
		
		/**
		 * world 
		 */
		function get world(): World;
	}
}
