package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.components.CyclistComponent;

	import soulwire.ai.Boid;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;

	/**
	 * CyclistSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class CyclistSystem extends AbstractBoidSystem {
		/**
		 * _cyclistMapper 
		 */
		private var _cyclistMapper : ComponentMapper;

		/**
		 * CyclistSystem 
		 */
		public function CyclistSystem() {
			super(CyclistComponent);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			super.initialize();
			_cyclistMapper = new ComponentMapper(CyclistComponent, _world);
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
			var cyclist : CyclistComponent = _cyclistMapper.get(e);
			cyclist;
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