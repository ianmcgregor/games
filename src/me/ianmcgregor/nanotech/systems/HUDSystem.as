package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.components.HUDComponent;
	import me.ianmcgregor.nanotech.components.HeroComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.constants.EntityGroup;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _hudMapper : ComponentMapper;
		/**
		 * _heroMapper 
		 */
		private var _heroMapper : ComponentMapper;
		/**
		 * _physicsMapper 
		 */
		private var _physicsMapper : ComponentMapper;
		/**
		 * _healthMapper 
		 */
		private var _healthMapper : ComponentMapper;

		/**
		 * SoundSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function HUDSystem(g : GameContainer) {
			super(HUDComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_hudMapper = new ComponentMapper(HUDComponent, _world);
			_heroMapper = new ComponentMapper(HeroComponent, _world);
			_physicsMapper = new ComponentMapper(PhysicsComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
			
			/**
			 * hudComponent 
			 */
			var hudComponent: HUDComponent = _hudMapper.get(e);
			hudComponent;
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * hudComponent 
			 */
			var hudComponent: HUDComponent = _hudMapper.get(e);
			
			var heroes: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.HERO);
			var l: int = heroes.size();
			for (var i : int = 0; i < l; ++i) {
				var heroEntity: Entity = heroes.get(i);
//				var physicsComponent: PhysicsComponent = _physicsMapper.get(heroEntity);
				var heroComponent: HeroComponent = _heroMapper.get(heroEntity);
				var healthComponent: HealthComponent = _healthMapper.get(heroEntity);
				var player: uint = heroComponent.player;
				
				hudComponent.player[player].health = healthComponent.getHealthPercentage();
				hudComponent.player[player].score = heroComponent.getScore();
			}
			
		}
	}
}
