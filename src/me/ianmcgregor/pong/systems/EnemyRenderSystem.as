package me.ianmcgregor.pong.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.pong.components.Enemy;
	import me.ianmcgregor.pong.spatials.Paddle;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;



	/**
	 * EnemyRenderSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class EnemyRenderSystem extends EntityProcessingSystem {
		/**
		 * _spatials 
		 */
		private var _spatials : Bag;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _container 
		 */
		private var _container : GameContainer;

		/**
		 * EnemyRenderSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function EnemyRenderSystem(container : GameContainer) {
			super(TransformComponent, [Enemy]);
			_container = container;

			_spatials = new Bag();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
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
			// trace("RenderSystem.processEntities(",entities,")");
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
			/**
			 * transform 
			 */
			var transform : TransformComponent = _transformMapper.get(e);

			if (transform.y >= 0 
				&& transform.y <= _container.getHeight()
				&& spatial != null) {
				spatial.render(_container);
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
			/**
			 * spatial 
			 */
			var spatial : Spatial = new Paddle(_world, e);
			spatial.initalize(_container);
			_spatials.set(e.getId(), spatial);
		}

		/**
		 * removed 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			_spatials.set(e.getId(), null);
		}

		/**
		 * change 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override public function change(e : Entity) : void {
			super.change(e);
		}
	}
}