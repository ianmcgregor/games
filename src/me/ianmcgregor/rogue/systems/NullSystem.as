package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.NullComponent;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.ui.Keyboard;

	/**
	 * @author ianmcgregor
	 */
	public final class NullSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _nullMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;

		/**
		 * NullSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function NullSystem(g : GameContainer) {
			super(NullComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_nullMapper = new ComponentMapper(NullComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
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
			// _someComponent = _someMapper.get(_world.getTagManager().getEntity(EntityTag.SOME_TAG));
			// var bag: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.SOME_GROUP);
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
			 * nullComponent 
			 */
			var nullComponent: NullComponent = _nullMapper.get(e);
			nullComponent;
			/**
			 * transformComponent 
			 */
			var transformComponent: TransformComponent = _transformMapper.get(e);
			transformComponent;
			
			/**
			 * E.g. back to titles
			 */
			if(_g.state == State.PLAY && _g.getInput().isDown(Keyboard.LEFT)) {
				_g.state = State.TITLES;
				EntityFactory.createTitles(_world);
			}
			if(_g.state == State.PLAY && _g.getInput().isDown(Keyboard.RIGHT)) {
				_g.state = State.GAME_OVER;
				EntityFactory.createGameOver(_world);
			}
		}
	}
}
