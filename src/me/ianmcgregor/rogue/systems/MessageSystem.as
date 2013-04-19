package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.MessageComponent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class MessageSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _messageMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;

		/**
		 * MessageSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function MessageSystem(g : GameContainer) {
			super(MessageComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_messageMapper = new ComponentMapper(MessageComponent, _world);
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
			
			// TODO: can check if same already exists?
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
			 * Component 
			 */
			// remove dupes?
			var currentMessages: Object = new Object();
			var message: MessageComponent = _messageMapper.get(e);
			if(currentMessages[message.text]) {
				_world.deleteEntity(e);
			} else {
				currentMessages[message.text] = message;
			}
			/**
			 * transformComponent 
			 */
			var transformComponent: TransformComponent = _transformMapper.get(e);
			transformComponent;
			
		}
	}
}
