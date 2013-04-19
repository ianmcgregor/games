package me.ianmcgregor.racer.contexts {
	import me.ianmcgregor.games.artemis.components.SpatialFormComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.systems.RenderSystem;
	import me.ianmcgregor.games.audio.AudioObject;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.racer.components.BuilderComponent;
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.HUDComponent;
	import me.ianmcgregor.racer.components.SoundComponent;
	import me.ianmcgregor.racer.components.TitlesComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.EntityGroup;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.spatials.BuilderSpatial;
	import me.ianmcgregor.racer.spatials.CarSpatial;
	import me.ianmcgregor.racer.spatials.ControlSpatial;
	import me.ianmcgregor.racer.spatials.HUDSpatial;
	import me.ianmcgregor.racer.spatials.TitlesSpatial;
	import me.ianmcgregor.racer.spatials.TrackSpatial;
	import me.ianmcgregor.racer.systems.BuilderSystem;
	import me.ianmcgregor.racer.systems.CarSystem;
	import me.ianmcgregor.racer.systems.HUDSystem;
	import me.ianmcgregor.racer.systems.SoundSystem;
	import me.ianmcgregor.racer.systems.TitlesSystem;
	import me.ianmcgregor.racer.systems.TrackInitializeSystem;
	import me.ianmcgregor.racer.systems.TrackSystem;

	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class RacerContext implements IContext {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _world 
		 */
		private var _world : World;
		/**
		 * _trackInitializeSystem 
		 */
		private var _trackInitializeSystem : EntitySystem;
		/**
		 * _hudSystem 
		 */
		private var _hudSystem : EntitySystem;
		/**
		 * _carSystem 
		 */
		private var _carSystem : EntitySystem;
		/**
		 * _trackSystem 
		 */
		private var _trackSystem : EntitySystem;
		/**
		 * _renderSystem 
		 */
		private var _renderSystem : EntitySystem;
		/**
		 * _soundSystem 
		 */
		private var _soundSystem : EntitySystem;
		/**
		 * _builderSystem 
		 */
		private var _builderSystem : EntitySystem;
		/**
		 * _menuSystem 
		 */
		private var _titlesSystem : EntitySystem;

		/**
		 * RacerContext 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function RacerContext(container : GameContainer) {
			super();
			_container = container;
		}

		/**
		 * init 
		 * 
		 * @return 
		 */
		public function init() : void {
			_world = new World();

			// set systems

			/**
			 * systemManager 
			 */
			var systemManager : SystemManager = _world.getSystemManager();
			
			_renderSystem = systemManager.setSystem(new RenderSystem(_container));
			_trackInitializeSystem = systemManager.setSystem(new TrackInitializeSystem(_container));
			_hudSystem = systemManager.setSystem(new HUDSystem(_container));
			_trackSystem = systemManager.setSystem(new TrackSystem(_container));
			_carSystem = systemManager.setSystem(new CarSystem(_container));
			_soundSystem = systemManager.setSystem(new SoundSystem());
			_builderSystem = systemManager.setSystem(new BuilderSystem(_container));
			_titlesSystem = systemManager.setSystem(new TitlesSystem(_container));
			
			// init systems
			systemManager.initializeAll();

			// init entities
			createEntities();
		}

		/**
		 * createEntities 
		 * 
		 * @return 
		 */
		private function createEntities() : void {

			/**
			 * e 
			 */
			var e : Entity;
			
			e = _world.createEntity();
			e.setTag(EntityTag.MENU);
			e.addComponent(new TitlesComponent());
			e.addComponent(new SpatialFormComponent(TitlesSpatial));
			e.addComponent(new TransformComponent());
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.GAME);
			e.addComponent(new GameComponent());
			e.refresh();

			e = _world.createEntity();
			e.setTag(EntityTag.TRACK);
			e.addComponent(new SpatialFormComponent(TrackSpatial));
			e.addComponent(new TrackComponent());
			e.addComponent(new TransformComponent(0,0));
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.CAR_ONE);
			e.setGroup(EntityGroup.CARS);
			e.addComponent(new SpatialFormComponent(CarSpatial));
			e.addComponent(new CarComponent(1));
			e.addComponent(new TransformComponent());
//			e.addComponent(new SoundComponent(new AudioObject(new engine(), true, 0, -0.9)));
			e.refresh();

			e = _world.createEntity();
			e.setTag(EntityTag.CAR_TWO);
			e.setGroup(EntityGroup.CARS);
			e.addComponent(new SpatialFormComponent(CarSpatial));
			e.addComponent(new CarComponent(2));
			e.addComponent(new TransformComponent());
//			e.addComponent(new SoundComponent(new AudioObject(new engine(), true, 0, 0.9)));
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.HUD);
			e.addComponent(new SpatialFormComponent(HUDSpatial));
			e.addComponent(new HUDComponent());
			e.addComponent(new TransformComponent((_container.getWidth() - 360)*0.5, 0));
			e.addComponent(new SoundComponent(new AudioObject(null)));
			e.refresh();
			
//			if(Environment.isMobile) {
				e = _world.createEntity();
				e.addComponent(new SpatialFormComponent(ControlSpatial));
				e.addComponent(new TransformComponent());
				e.refresh();
//			}
			
			
			e = _world.createEntity();
			e.setTag(EntityTag.BUILDER);
			e.addComponent(new SpatialFormComponent(BuilderSpatial));
			e.addComponent(new BuilderComponent());
			e.addComponent(new TransformComponent(300,0));
			e.refresh();
		}

		/**
		 * update 
		 * 
		 * @param delta 
		 * 
		 * @return 
		 */
		public function update(delta : Number) : void {
			_world.loopStart();
			_world.setDelta(delta);

			// process systems
			
			
			_trackInitializeSystem.process();
			_trackSystem.process();
			
			switch(_container.state){
				case State.TITLES:
					_titlesSystem.process();
					break;
				case State.PLAY:
					_carSystem.process();
					_hudSystem.process();
					_soundSystem.process();
					break;
				case State.BUILD:
					_builderSystem.process();
					break;
				default:
			}
			_renderSystem.process();
		}

		/**
		 * world 
		 */
		public function get world() : World {
			return _world;
		}
	}
}
