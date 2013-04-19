package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.species.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;


	/**
	 * HealthComponentBarRenderSystem 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class HealthBarRenderSystem extends EntityProcessingSystem {
		/**
		 * _healthMapper 
		 */
		private var _healthMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;

		/**
		 * HealthComponentBarRenderSystem 
		 */
		public function HealthBarRenderSystem() {
			super(HealthComponent, [TransformComponent]);
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_healthMapper = new ComponentMapper(HealthComponent, _world);
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
//			trace("HealthComponentBarRenderSystem.processEntities(",entities,entities.size(),")");
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
//			trace("HealthComponentBarRenderSystem.processEntity(",e,")");
			e;
			
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			var heroHealthComponent : HealthComponent = _healthMapper.get(hero);

			var bar : Entity = _world.getTagManager().getEntity(EntityTag.HEALTH_BAR);
			var barHealthComponent : HealthComponent = _healthMapper.get(bar);

			barHealthComponent.setHealth(heroHealthComponent.getHealth());
		}
	}
}