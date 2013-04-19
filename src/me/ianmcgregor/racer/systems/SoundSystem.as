package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.SoundComponent;
	import me.ianmcgregor.racer.constants.EntityGroup;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameState;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.events.SampleDataEvent;
	import flash.media.Sound;

	/**
	 * @author ianmcgregor
	 */
	public final class SoundSystem extends EntityProcessingSystem {
		/**
		 * TODO: 
		 * 
		 * implement engine for both cars (use panning)
		 * 
		 * crash sound using noise with envelope
		 * 
		 * start sound using sines
		 * 
		 * optimise
		 * 
		 */
		
		/**
		 * _soundMapper 
		 */
		private var _soundMapper : ComponentMapper;
		/**
		 * _carMapper 
		 */
		private var _carMapper : ComponentMapper;
		
		private const PIx2 : Number = Math.PI * 2;
		/**
		 * _phase 
		 */
		private var _phase : int;
		private static const MIN_HZ : Number = 20;
		/**
		 * _hzCarOne 
		 */
		private var _hzCarOne : Number = MIN_HZ;
		/**
		 * _volumeCarOne 
		 */
		private var _volumeCarOne : Number = 0;
		/**
		 * _hzCarTwo 
		 */
		private var _hzCarTwo : Number = MIN_HZ;
		/**
		 * _volumeCarTwo 
		 */
		private var _volumeCarTwo : Number = 0;
		/**
		 * _gameMapper 
		 */
		private var _gameMapper : ComponentMapper;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		
		
		/**
		 * SoundSystem 
		 */
		public function SoundSystem() {
			super(SoundComponent, []);
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_soundMapper = new ComponentMapper(SoundComponent, _world);
			_carMapper = new ComponentMapper(CarComponent, _world);
			_gameMapper = new ComponentMapper(GameComponent, _world);
			
			/**
			 * sound 
			 */
			var sound : Sound = new Sound();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			sound.play();
		}
		
		
		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_game = _gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
		}
		

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			super.processEntity(e);
			
			/**
			 * cars 
			 */
			var cars: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.CARS);
			/**
			 * l 
			 */
			var l: int = cars.size();
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				/**
				 * carEntity 
				 */
				var carEntity : * = cars.get(i);
				/**
				 * car 
				 */
				var car: CarComponent = _carMapper.get(carEntity);
//				var sound: SoundComponent = _soundMapper.get(carEntity);
//				var volume: Number = 0.4 + 0.4 * car.speed + 0.2 * car.z;
//				var startTime : uint = car.speed * 100;
//				if(startTime != sound.startTime) sound.play(startTime, volume);
				
				/**
				 * minVolume 
				 */
				var minVolume : Number = 0.2;
				if (_game.state == GameState.TITLES || _game.state == GameState.GAME_OVER) {
					minVolume = 0;
				}	
				
				if (car.id == 1) {
					_hzCarOne = getFrequency(car);
					_volumeCarOne = minVolume + getVolume(car);
				} else if(car.id == 2) {
					_hzCarTwo = getFrequency(car);
					_volumeCarTwo = minVolume + getVolume(car);
				}
			}
		}
		
		// helper methods for freq and vol

		/**
		 * getFrequency 
		 * 
		 * @param car 
		 * 
		 * @return 
		 */
		private function getFrequency(car : CarComponent) : Number {
			return MIN_HZ + car.speed * 500;
		}

		/**
		 * getVolume 
		 * 
		 * @param car 
		 * 
		 * @return 
		 */
		private function getVolume(car : CarComponent) : Number {
			return car.speed * 3;
		}
		
		// write samples
		
		/**
		 * onSampleData 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onSampleData(event : SampleDataEvent) : void {
//			trace("AudioTest.onSampleData()");
			/**
			 * rate 
			 */
			var rate : Number = 44100;
//			var samples : uint = 4096;
			/**
			 * samples 
			 */
			var samples : uint = 2048;
//			var samples : uint = 8192;
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
				var sampleL : Number = getEngineSound(phase * _hzCarOne, _volumeCarOne);
				/**
				 * sampleR 
				 */
				var sampleR : Number = getEngineSound(phase * _hzCarTwo, _volumeCarTwo);
				
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
		private function getEngineSound(theta: Number, volume: Number): Number {
			/**
			 * sine 
			 */
			var sine: Number = Math.sin(theta * PIx2);
			/**
			 * square 
			 */
			var square: Number = sgn(sine);
			/**
			 * sawtooth 
			 */
			var sawtooth: Number = theta - Math.floor( theta + 0.5 );
			
			/**
			 * sample 
			 */
			var sample : Number = square + sawtooth;
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
		private function sgn(x: Number) : Number {
			return x == 0 ? 0 : x < 0 ? -1 : 1;
		}
	}
}
