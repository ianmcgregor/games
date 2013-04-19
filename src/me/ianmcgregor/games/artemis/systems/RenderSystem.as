package me.ianmcgregor.games.artemis.systems {
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;


	/**
	 * RenderSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class RenderSystem extends EntityProcessingSystem {
		/**
		 * _spatials 
		 */
		private var _spatials : Bag;
		/**
		 * _spatialFormMapper 
		 */
		private var _spatialFormMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _gameContainer 
		 */
		private var _gameContainer : GameContainer;

		/**
		 * RenderSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function RenderSystem(container : GameContainer) {
			super(TransformComponent, [SpatialFormComponent]);
			_gameContainer = container;
			_spatials = new Bag();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_spatialFormMapper = new ComponentMapper(SpatialFormComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
		}

		/**
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
//			 trace("RenderSystem.processEntities(",entities,")");
			super.processEntities(entities);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			// trace("RenderSystem.processEntity(",e,")");
			/**
			 * spatial 
			 */
			var spatial : Spatial = _spatials.get(e.getId());
//			trace('spatial: ' + (spatial));
//			var transform : TransformComponent = _transformMapper.get(e);

//			if (transform.x >= 0 
//				&& transform.y >= 0 
//				&& transform.x < _gameContainer.getWidth() 
//				&& transform.y < _gameContainer.getHeight() 
//				&& spatial != null) {
//				spatial.render(_gameContainer);
//			}
			if (spatial != null) {
				spatial.render(_gameContainer);
			}
		}

		/**
		 * added 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			// trace("RenderSystem.added(",e,")");
			/**
			 * spatial 
			 */
			var spatial : Spatial = createSpatial(e);
			if (spatial != null) {
				spatial.initalize(_gameContainer);
				_spatials.set(e.getId(), spatial);
			}
		}

		/**
		 * removed 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			/**
			 * spatial 
			 */
			var spatial : Spatial = _spatials.get(e.getId());
			spatial.remove(_gameContainer);
			_spatials.set(e.getId(), null);
		}

		/**
		 * createSpatial 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		private function createSpatial(e : Entity) : Spatial {
			// trace("RenderSystem.createSpatial(",e,")");
			/**
			 * spatialForm 
			 */
			var spatialForm : SpatialFormComponent = _spatialFormMapper.get(e);
			/**
			 * SpatialFormClass 
			 */
			var SpatialFormClass : Class = spatialForm.getSpatialFormFile();
			return new SpatialFormClass(_world, e);
		}

		/**
		 * change 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override public function change(e : Entity) : void {
			// trace("RenderSystem.change(",e,")");
			super.change(e);
		}
	}
}