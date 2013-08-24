package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.components.PedestrianComponent;

	import soulwire.ai.Boid;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;

	/**
	 * PedestrianSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class PedestrianSystem extends AbstractBoidSystem {
		/**
		 * _mapper 
		 */
		private var _pedestrianMapper : ComponentMapper;

		/**
		 * PedestrianSystem 
		 */
		public function PedestrianSystem() {
			super(PedestrianComponent);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			super.initialize();
			_pedestrianMapper = new ComponentMapper(PedestrianComponent, _world);
		}

		/**
		 * setProperties
		 */
		override protected function setProperties(b : Boid) : void {
			super.setProperties(b);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var pedestrian : PedestrianComponent = _pedestrianMapper.get(e);
			pedestrian;		
			super.processEntity(e);
		}
		
		/**
		 * update
		 */	
		override protected function update(b : Boid) : void {
			super.update(b);
		}
	}
}