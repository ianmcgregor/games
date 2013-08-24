package me.ianmcgregor.drive.audio {
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author McFamily
	 */
	public class EngineAudio {
		/**
		 * _sound 
		 */
		private var _sound : Sound;
		/**
		 * _isPlaying 
		 */
		private var _isPlaying : Boolean;
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
		 * 
		 */
		private const PIx2 : Number = Math.PI * 2;
		private var _phase : int;
		private var _hz : Number = 0;
		private var _vol : Number = 0;

		/**
		 * AudioEngine 
		 * 
		 * @param sound 
		 * @param loop 
		 * @param volume 
		 * @param pan 
		 * 
		 * @return 
		 */
		public function EngineAudio(volume : Number = 1, pan : Number = 0) {
			_sound = new Sound();
			_volume = volume;
			_pan = pan;
			_soundTransform = new SoundTransform(_volume, _pan);

			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			_sound.play();
		}

		/**
		 * onSampleData
		 */
		private function onSampleData(event : SampleDataEvent) : void {
			// trace("AudioTest.onSampleData()");
			/**
			 * rate 
			 */
			var rate : Number = 44100;
			// var samples : uint = 4096;
			/**
			 * samples 
			 */
			var samples : uint = 2048;
			// var samples : uint = 8192;
			/**
			 * i 
			 */
			for (var i : int = 0; i < samples; ++i) {
				_phase = i + event.position;
				/**
				 * phase 
				 */
				var phase : Number = _phase / rate;

				/**
				 * sampleL 
				 */
				var sampleL : Number = getEngineSound(phase * _hz, _vol);
				/**
				 * sampleR 
				 */
				var sampleR : Number = getEngineSound(phase * _hz, _vol);

				// left
				event.data.writeFloat(sampleL);
				// right
				event.data.writeFloat(sampleR);

				_phase++;
			}
		}

		/**
		 * getEngineSound 
		 * 
		 * @param theta 
		 * @param volume 
		 * 
		 * @return 
		 */
		private function getEngineSound(theta : Number, volume : Number) : Number {
			/**
			 * sine 
			 */
			var sine : Number = Math.sin(theta * PIx2);
			/**
			 * square 
			 */
			var square : Number = sgn(sine);
			/**
			 * sawtooth 
			 */
//			var sawtooth : Number = theta - Math.floor(theta + 0.5);

			/**
			 * sample 
			 */
			var sample : Number = square;
			sample *= volume;

			return sample;
		}

		/**
		 * sgn 
		 * 
		 * @param x 
		 * 
		 * @return 
		 */
		[Inline]
		private function sgn(x : Number) : Number {
			return x == 0 ? 0 : x < 0 ? -1 : 1;
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
		public function play(startTime : Number = 0, volume : Number = 1) : SoundChannel {
			_isPlaying = true;
			if (_channel) stop();

			/**
			 * loops 
			 */
			_soundTransform.volume = volume;
			_channel = _sound.play(0, 0, _soundTransform);

			if (startTime > _sound.length) {
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
			play();
		}

		/**
		 * pause 
		 * 
		 * @return 
		 */
		public function pause() : void {
			stop();
		}

		/**
		 * @private
		 */
		public function set volume(value : Number) : void {
			if (isNaN(value)) return;
			if (_volume == value) return;

			_volume = _soundTransform.volume = value;
			if (_channel) {
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
			if (_channel) {
				_channel.soundTransform = _soundTransform;
			}
		}

		public function set hz(hz : Number) : void {
			_hz = hz;
		}

		public function set vol(vol : Number) : void {
			if(vol > 1) vol = 1;
			if(vol < 0) vol = 0;
			_vol = vol;
		}
	}
}
