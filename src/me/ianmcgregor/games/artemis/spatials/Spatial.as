package me.ianmcgregor.games.artemis.spatials {
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * Spatial 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class Spatial {
		/**
		 * _world 
		 */
		protected var _world : World;
		/**
		 * _owner 
		 */
		protected var _owner : Entity;

		/**
		 * Spatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function Spatial(world : World, owner : Entity) {
			_world = world;
			_owner = owner;
		}

		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function initalize(g : GameContainer) : void {
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function render(g : GameContainer) : void {
		}

		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function remove(g : GameContainer) : void {
		}
	}
}