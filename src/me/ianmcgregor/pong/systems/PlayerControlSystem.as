package me.ianmcgregor.pong.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.input.IKeyListener;
	import me.ianmcgregor.pong.components.Player;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import flash.ui.Keyboard;





	/**
	 * @author McFamily
	 */
	public class PlayerControlSystem extends EntityProcessingSystem implements IKeyListener {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _moveUp 
		 */
		private var _moveUp : Boolean;
		/**
		 * _moveDown 
		 */
		private var _moveDown : Boolean;
		/**
		 * PlayerControlSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function PlayerControlSystem(container : GameContainer) {
			super(TransformComponent, [Player]);
			_container = container;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_container.getInput().addKeyListener(this);
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
			 * transform 
			 */
			var transform : TransformComponent = _transformMapper.get(e);

			if (_moveUp) {
				transform.addY(_world.getDelta() * -300);
			}
			if (_moveDown) {
				transform.addY(_world.getDelta() * 300);
			}
			// clamp
			if (transform.y < 0) {
				transform.y = 0;
			} else if(transform.y > _container.getHeight() - 60) {
				transform.y = _container.getHeight() - 60;
			}
		}
		
		
		// input

		/**
		 * keyPressed 
		 * 
		 * @param key 
		 * @param c 
		 * 
		 * @return 
		 */
		public function keyPressed(key : uint, c : String) : void {
			switch(key){
				case Keyboard.W:
					_moveUp = true;
					_moveDown = false;
					break;
				case Keyboard.S:
					_moveDown = true;
					_moveUp = false;
					break;
				default:
			}
		}

		/**
		 * keyReleased 
		 * 
		 * @param key 
		 * @param c 
		 * 
		 * @return 
		 */
		public function keyReleased(key : uint, c : String) : void {
			switch(key){
				case Keyboard.W:
					_moveUp = false;
					break;
				case Keyboard.S:
					_moveDown = false;
					break;
				default:
			}
		}
		
		/**
		 * inputEnded 
		 * 
		 * @return 
		 */
		public function inputEnded() : void {
		}

		/**
		 * inputStarted 
		 * 
		 * @return 
		 */
		public function inputStarted() : void {
		}

		/**
		 * isAcceptingInput 
		 * 
		 * @return 
		 */
		public function isAcceptingInput() : Boolean {
			return true;
		}

		/**
		 * setInput 
		 * 
		 * @param input 
		 * 
		 * @return 
		 */
		public function setInput(input : IKeyInput) : void {
		}
	}
}
