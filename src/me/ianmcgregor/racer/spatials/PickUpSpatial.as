package me.ianmcgregor.racer.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;

	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public class PickUpSpatial extends Spatial {
		/**
		 * PickUpSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function PickUpSpatial(world : World, owner : Entity) {
			super(world, owner);
		}
	}
}
