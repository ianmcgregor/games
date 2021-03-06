package me.ianmcgregor.template {
	import me.ianmcgregor.games.base.BaseGame;
	import me.ianmcgregor.template.constants.State;
	import me.ianmcgregor.template.contexts.GameContext;

	import starling.events.Event;

	/**
	 * @author McFamily
	 */
	public final class Game extends BaseGame {

		/**
		 * Game 
		 */
		public function Game() {
			super();
		}

		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		override protected function onAddedToStage(event : Event) : void {
			super.onAddedToStage(event);
			
			/**
			 * Context
			 */
			_context = new GameContext(_gameContainer);
			_context.init();
			/**
			 * Initial State
			 */
			_gameContainer.state = State.TITLES;
		}

		/**
		 * update 
		 * 
		 * @param deltaTime 
		 * 
		 * @return 
		 */
		override protected function update(deltaTime : Number) : void {
			super.update(deltaTime);
		}

		/**
		 * start 
		 * 
		 * @return 
		 */
		override public function start() : void {
			super.start();
		}

		/**
		 * stop 
		 * 
		 * @return 
		 */
		override public function stop() : void {
			super.stop();
		}
	}
}
