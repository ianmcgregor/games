package me.ianmcgregor.drive {
	import me.ianmcgregor.drive.constants.State;
	import me.ianmcgregor.drive.contexts.DriveContext;
	import me.ianmcgregor.games.base.BaseGame;

	import starling.events.Event;

	/**
	 * @author McFamily
	 */
	public final class Drive extends BaseGame {

		/**
		 * Game 
		 */
		public function Drive() {
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
			_context = new DriveContext(_gameContainer);
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
