package me.ianmcgregor.games.base {
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;


	/**
	 * BaseGame 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class BaseGame extends Sprite {
		/**
		 * _gameContainer 
		 */
		protected var _gameContainer : GameContainer;
		/**
		 * _context 
		 */
		protected var _context : IContext;
		
		/**
		 * BaseGame 
		 */
		public function BaseGame() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		protected function onAddedToStage(event : Event) : void {
			event;
			
			addChild(_gameContainer = new GameContainer(Starling.current.viewPort.width, Starling.current.viewPort.height));
			_gameContainer.clear();
		}
		
		/**
		 * onEnterFrame 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		protected function onEnterFrame(event : EnterFrameEvent) : void {
			update(event.passedTime);
		}

		/**
		 * update 
		 * 
		 * @param delta 
		 * 
		 * @return 
		 */
		protected function update(deltaTime : Number) : void {
			_context.update(deltaTime);
		}

		/**
		 * onRemovedFromStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		protected function onRemovedFromStage(event : Event) : void {
			event;
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}

		/**
		 * Called from BaseStartup when native app
		 */

		/**
		 * start 
		 * 
		 * @return 
		 */
		public function start() : void {
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}

		/**
		 * stop 
		 * 
		 * @return 
		 */
		public function stop() : void {
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}

		/**
		 * toggleMenu 
		 * 
		 * @return 
		 */
		public function toggleMenu() : void {
		}

		/**
		 * get gameContainer 
		 * 
		 * @return GameContainer
		 */
		public function get gameContainer() : GameContainer {
			return _gameContainer;
		}
	}
}