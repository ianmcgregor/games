package me.ianmcgregor.games.debug {
	import starling.core.Starling;

	import flash.system.System;
	import flash.utils.getTimer;


	/**
	 * FPS 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public final class FPS extends AbstractDebugPanel implements IUpdateable {

		/**
		 * FPS 
		 */
		public function FPS() {
			super(getInfo(0));
		}

		/**
		 * update 
		 * 
		 * @return 
		 */
		public function update() : void {
			updateFps();
			updateMem();

			/**
			 * frameRate 
			 */
			var frameRate : Number = Starling.current.nativeStage.frameRate;
			this.text = getInfo(frameRate);
		}

		/**
		 * getInfo 
		 * 
		 * @param frameRate 
		 * 
		 * @return 
		 */
		private function getInfo( frameRate : Number ) : String {
			/**
			 * info 
			 */
			var info : String = "";
			info += "FPS: " + _currentFps + "/" + frameRate + "\n";
			info += "AVE: " + _averageFps + "/" + frameRate + "\n";
			info += "MEM: " + _mem + "\n";
			info += "MAX: " + _memMax + "\n";
			return info;
		}

		// FPS
		/**
		 * _timer 
		 */
		private var _timer : uint;
		/**
		 * _ms 
		 */
		private var _ms : uint;
		/**
		 * _fps 
		 */
		private var _fps : uint;
		/**
		 * _currentFps 
		 */
		private var _currentFps : uint;
		/**
		 * _averageFps 
		 */
		private var _averageFps : uint;
		/**
		 * _ticks 
		 */
		private var _ticks : uint;
		/**
		 * _total 
		 */
		private var _total : uint;

		/**
		 * updateFps 
		 * 
		 * @return 
		 */
		private function updateFps() : void {
			_timer = getTimer();

			if (_timer - 1000 > _ms) {
				_ms = _timer;
				_currentFps = _fps;
				_fps = 0;
				
				if (_currentFps > 1) {
					_ticks ++;
					_total += _currentFps;
					_averageFps = Math.round(_total / _ticks);
				}
			}

			_fps++;
		}

		// MEMORY
		/**
		 * _mem 
		 */
		private var _mem : Number = 0;
		/**
		 * _memMax 
		 */
		private var _memMax : Number = 0;

		/**
		 * updateMem 
		 * 
		 * @return 
		 */
		private function updateMem() : void {
			_mem = Number((System.totalMemory * 0.000000954).toFixed(3));
			_memMax = _memMax > _mem ? _memMax : _mem;
		}
	}
}