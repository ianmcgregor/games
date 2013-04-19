package me.ianmcgregor.games.base {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * @author ian
	 */
	public class BasicGame extends Sprite {
		/**
		 * _time 
		 */
		private var _time : int;
		/**
		 * _width 
		 */
		private var _width : int;
		/**
		 * _height 
		 */
		private var _height : int;

		/**
		 * BasicGame 
		 * 
		 * @param width 
		 * @param height 
		 * 
		 * @return 
		 */
		public function BasicGame(width : int, height : int) {
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onAddedToStage(event : Event) : void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;
			
			init();

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		/**
		 * onEnterFrame 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onEnterFrame(event : Event) : void {
			/**
			 * time 
			 */
			var time : int = getTimer();
			/**
			 * delta 
			 */
			var delta : int = time - _time;
			_time = time;
			update(delta);
		}

		/**
		 * init 
		 * 
		 * @return 
		 */
		public function init() : void {
		}

		/**
		 * update 
		 * 
		 * @param delta 
		 * 
		 * @return 
		 */
		public function update(delta : int) : void {
		}
	}
}
