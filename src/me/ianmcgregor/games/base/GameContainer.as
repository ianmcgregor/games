package me.ianmcgregor.games.base {
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.input.KeyInput;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import flash.utils.getTimer;



	/**
	 * @author McFamily
	 */
	public final class GameContainer extends DisplayObjectContainer {
		/**
		 * _width 
		 */
		private var _width : int;
		/**
		 * _height 
		 */
		private var _height : int;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * _assets 
		 */
		private var _assets: AssetManager;
		/**
		 * state 
		 */
		public var state : String;
		
		/**
		 * GameContainer 
		 * 
		 * @param width 
		 * @param height 
		 * 
		 */
		public function GameContainer(width: int, height: int) {
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return void
		 */
		private function onAddedToStage(event : Event) : void {
			event;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_input = new KeyInput(Starling.current.stage);
			_assets = new AssetManager();
		}

		/**
		 * getWidth 
		 * 
		 * @return int
		 */
		public function getWidth() : int {
			return _width;
		}

		/**
		 * getHeight 
		 * 
		 * @return int
		 */
		public function getHeight() : int {
			return _height;
		}

		/**
		 * getInput 
		 * 
		 * @return IKeyInput
		 */
		public function getInput() : IKeyInput {
			return _input;
		}

		/**
		 * assets 
		 * 
		 * @return AssetManager 
		 */
		public function get assets() : AssetManager {
			return _assets;
		}
		
		/**
		 * clear 
		 * 
		 * @return void
		 */
		public function clear(): void {
			while(numChildren){
				removeChildAt(0);
			}
		}
		
		/**
		 * getTimeNow 
		 * 
		 * @return seconds
		 */
		public function getTimeNow() : Number {
			return getTimer() * 0.001;
		}
	}
}
