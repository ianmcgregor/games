package me.ianmcgregor.rogue {
	import me.ianmcgregor.games.base.BaseGame;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.contexts.RogueContext;

	import starling.events.Event;

	/**
	 * @author McFamily
	 */
	public final class Rogue extends BaseGame {

		/**
		 * Game 
		 */
		public function Rogue() {
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
			_context = new RogueContext(_gameContainer);
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
