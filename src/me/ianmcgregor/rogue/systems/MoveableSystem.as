package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.rogue.components.MoveableComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;

	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class MoveableSystem extends EntityProcessingSystem {
		/**
		 * MoveableSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function MoveableSystem() {
			super(MoveableComponent, []);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var v: VelocityComponent = e.getComponent(VelocityComponent);
			
			v.dampenX(0.2);
			v.dampenY(0.2);
		}
	}
}
