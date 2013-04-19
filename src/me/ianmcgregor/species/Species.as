package me.ianmcgregor.species {
	import me.ianmcgregor.games.base.BaseGame;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.games.debug.ArtemisMonitor;
	import me.ianmcgregor.games.debug.DebugDisplay;
	import me.ianmcgregor.species.constants.StateConstants;
	import me.ianmcgregor.species.contexts.GameCompleteContext;
	import me.ianmcgregor.species.contexts.GameOverContext;
	import me.ianmcgregor.species.contexts.PlayContext;
	import me.ianmcgregor.species.contexts.TitlesContext;

	import starling.events.Event;

	import flash.utils.Dictionary;



	/**
	 * @author McFamily
	 */
	
	/**
	 * Species 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class Species extends BaseGame {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _artemisMonitor 
		 */
		private var _artemisMonitor : ArtemisMonitor;
		/**
		 * _state 
		 */
		private var _state : IContext;
		/**
		 * _states 
		 */
		private var _states : Dictionary;
		/**
		 * _debug 
		 */
		private var _debug : DebugDisplay;
		
		/**
		 * Species 
		 */
		public function Species() {
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
			trace("Species.onAddedToStage(",event,")");
			super.onAddedToStage(event);
			
			_states = new Dictionary();
			_states[StateConstants.TITLES] = TitlesContext;
			_states[StateConstants.PLAY] = PlayContext;
			_states[StateConstants.GAME_OVER] = GameOverContext;
			_states[StateConstants.WON] = GameCompleteContext;

			changeState(StateConstants.TITLES);
			
			addChild(_debug = new DebugDisplay());
			_debug.addChild(_artemisMonitor = new ArtemisMonitor(_state.world));
		}

		/**
		 * changeState 
		 * 
		 * @param state 
		 * 
		 * @return 
		 */
		public function changeState(state: String) : void {
			//if(state == _state) return;
			_container.clear();
			_state = new _states[state](_container, this);
			_state.init();
			if(_artemisMonitor && _state.world) _artemisMonitor.world = _state.world;
		}
		
		/**
		 * update 
		 * 
		 * @param delta 
		 * 
		 * @return 
		 */
		override protected function update(deltaTime : Number) : void {
			_state.update(deltaTime);
			_debug.update();
		}
	}
}
