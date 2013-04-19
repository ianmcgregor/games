package me.ianmcgregor.racer {
	import me.ianmcgregor.games.base.BaseGame;
	import me.ianmcgregor.games.debug.ArtemisMonitor;
	import me.ianmcgregor.games.debug.DebugDisplay;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.contexts.RacerContext;

	import starling.events.Event;



	/**
	 * @author McFamily
	 */
	public final class Racer extends BaseGame {
		private var _debug : DebugDisplay;
		/**
		 * Racer 
		 */
		public function Racer() {
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
			
			_gameContainer.state = State.TITLES;
			
			_context = new RacerContext(_gameContainer);
			_context.init();
			
			/**
			 * _debug 
			 */
			
			addChild(_debug = new DebugDisplay());
			/**
			 * _artemisMonitor 
			 */
			var _artemisMonitor : ArtemisMonitor;
			_debug.addChild(_artemisMonitor = new ArtemisMonitor(_context.world));
			_artemisMonitor.gameContainer = _gameContainer;
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
			_debug.update();
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
