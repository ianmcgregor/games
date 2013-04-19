package me.ianmcgregor.games.audio {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author McFamily
	 */
	public class AudioObject {
		/**
		 * _sound 
		 */
		private var _sound : Sound;
		/**
		 * _loop 
		 */
		private var _loop : Boolean;
		/**
		 * _isPlaying 
		 */
		private var _isPlaying : Boolean;
		/**
		 * _startTime 
		 */
		private var _startTime : Number = 0;
		/**
		 * _channel 
		 */
		private var _channel : SoundChannel;
		/**
		 * _soundTransform 
		 */
		private var _soundTransform : SoundTransform;
		/**
		 * _volume 
		 */
		private var _volume : Number = 1;
		/**
		 * _pan 
		 */
		private var _pan : Number = 0;

		/**
		 * AudioObject 
		 * 
		 * @param sound 
		 * @param loop 
		 * @param volume 
		 * @param pan 
		 * 
		 * @return 
		 */
		public function AudioObject(sound : Sound, loop : Boolean = false, volume: Number = 1, pan: Number = 0) {
			_loop = loop;
			_sound = sound;
			_volume = volume;
			_pan = pan;
			_soundTransform = new SoundTransform(_volume, _pan);
		}

		/**
		 * isPlaying 
		 */
		public function get isPlaying() : Boolean {
			return _isPlaying;
		}

		/**
		 * play 
		 * 
		 * @param startTime 
		 * 
		 * @return 
		 */
		public function play(startTime : Number = 0) : SoundChannel {
			if (!_sound) return null;
			_startTime = startTime;
			_isPlaying = true;
			if (_channel) stop();

			/**
			 * loops 
			 */
			var loops : int = _loop ? 99999 : 0;
			_channel = _sound.play(_startTime, loops, _soundTransform);

			if(startTime > _sound.length) {
				trace("[WARNING] AudioObject.play => startTime > length: " + startTime + "/" + _sound.length);
			} else if (!_channel) {
				trace("[WARNING] AudioObject.play => run out of SoundChannel");
				_isPlaying = false;
			}

			return _channel;
		}

		/**
		 * stop 
		 * 
		 * @return 
		 */
		public function stop() : void {
			_isPlaying = false;

			if (_channel) {
				_channel.stop();
			}
		}

		/**
		 * resume 
		 * 
		 * @return 
		 */
		public function resume() : void {
			play(_startTime);
		}

		/**
		 * pause 
		 * 
		 * @return 
		 */
		public function pause() : void {
			stop();

			if (_channel) {
				_startTime = _channel.position;
			}
		}

		/**
		 * @private
		 */
		public function set volume(value : Number) : void {
			if (isNaN(value)) return;
			if (_volume == value) return;

			_volume = _soundTransform.volume = value;
			if(_channel) {
				_channel.soundTransform = _soundTransform;
			}
		}

		/**
		 * @private
		 */
		public function set pan(value : Number) : void {
			if (isNaN(value)) return;
			if (_pan == value) return;

			_pan = _soundTransform.pan = value;
			if(_channel) {
				_channel.soundTransform = _soundTransform;
			}
		}
	}
}
