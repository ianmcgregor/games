package me.ianmcgregor.fight {
	import me.ianmcgregor.fight.constants.State;
	import me.ianmcgregor.fight.contexts.FightContext;
	import me.ianmcgregor.games.base.BaseGame;

	import starling.events.Event;

	/**
	 * @author McFamily
	 */
	public final class Fight extends BaseGame {

		/**
		 * Game 
		 */
		public function Fight() {
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
			_context = new FightContext(_gameContainer);
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
