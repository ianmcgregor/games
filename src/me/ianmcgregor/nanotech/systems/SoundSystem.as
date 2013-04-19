package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.nanotech.components.GameConfigComponent;
	import me.ianmcgregor.nanotech.components.HUDComponent;
	import me.ianmcgregor.nanotech.components.SoundComponent;
	import me.ianmcgregor.nanotech.constants.EntityTag;
	import me.ianmcgregor.nanotech.spatials.gfx.SiONSoundVO;
	import me.ianmcgregor.nanotech.spatials.gfx.SiONSounds;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.si.sion.SiONDriver;
	import org.si.sion.SiONVoice;
	import org.si.sion.events.SiONTrackEvent;
	import org.si.sion.utils.SiONPresetVoice;
	import org.si.sound.DrumMachine;

	/**
	 * @author ianmcgregor
	 */
	public final class SoundSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _soundMapper : ComponentMapper;
		
		/**
		 * SiON
		 */
		
        /**
         * driver 
         */
        private var _driver:SiONDriver = new SiONDriver();
        
        /**
         * presetVoice 
         */
        private var _presetVoice:SiONPresetVoice = new SiONPresetVoice();
        
        /**
         *  voices, notes and tracks
         */
//        private var _voices:Vector.<SiONVoice> = new Vector.<SiONVoice>(16);
//        private var _notes :Vector.<int> = Vector.<int>([36,48,60,72, 43,48,55,60, 65,67,70,72, 77,79,82,84]);
//        private var _length:Vector.<int> = Vector.<int>([ 1, 1, 1, 1,  1, 1, 1, 1,  4, 4, 4, 4,  4, 4, 4, 4]);
        
        /**
         * beatCounter 
         */
		private var _beatCounter : int;
		private var _drums : DrumMachine;
		private var _gameConfigMapper : ComponentMapper;

		/**
		 * SoundSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function SoundSystem(g : GameContainer) {
			super(SoundComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_soundMapper = new ComponentMapper(SoundComponent, _world);
			_gameConfigMapper = new ComponentMapper(GameConfigComponent, _world);
			initSiON();
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
			
			// Play sounds when entities added e.g. bullets or explosions
			// Could filter on group as below or specify in SoundComponent
			
			/**
			 * soundComponent 
			 */
			var soundComponent: SoundComponent = _soundMapper.get(e);
			//var group: String = _world.getGroupManager().getGroupOf(e);
			if(soundComponent.added) {
				trigger(soundComponent.added);
			}
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
			
			/**
			 * soundComponent 
			 */
			var soundComponent: SoundComponent = _soundMapper.get(e);
			if(soundComponent.removed) {
				trigger(soundComponent.removed);
			}
		}
		
		// noteOn(note:int, voice:SiONVoice = null, length:Number = 0, delay:Number = 0, quant:Number = 0, trackID:int = 0, isDisposable:Boolean = true):SiMMLTrack
		
		private function playSoundbyName(name: String, note: int = -1) : void {
//			trace("SoundSystem.playSoundbyName(",name, note,")");
			var s: SiONSoundVO = SiONSounds.byName(name);
			if(!s) return;
			if(note == -1) note = s.note;
			var voice: SiONVoice = _presetVoice[s.category + String(s.voice)];
			if(voice) {
				voice.velocity = int(256 * s.volume);
				voice.updateVolumes = true;
				_driver.noteOn(note, voice, s.length);
			}
		}	

//		private function playSound(i : int, note: int = -1) : void {
//			var s: SiONSoundVO = SiONSounds.LIST[i];
//			if(note == -1) note = s.note;
//			var voice: SiONVoice = _presetVoice[s.category + String(s.voice)];
//			if(voice) {
//				voice.velocity = int(256 * s.volume);
//				voice.updateVolumes = true;
//				_driver.noteOn(note, voice, s.length);
//			}
//		}	

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			
			_drums.snareVoiceNumber = SiONSounds.SNARE_VOICE;
			_drums.snarePatternNumber = SiONSounds.SNARE_PATTERN;
			
			_drums.bassVoiceNumber = SiONSounds.KICK_VOICE;
			_drums.bassPatternNumber = SiONSounds.KICK_PATTERN;
			
			_drums.hihatVoiceNumber = SiONSounds.HIHAT_VOICE;
			_drums.hihatPatternNumber = SiONSounds.HIHAT_PATTERN;
			
//			var config: GameConfigComponent = _gameConfigMapper.get(_world.getTagManager().getEntity(EntityTag.GAME_CONFIG));
//			var progress: Number = config.getProgress();
//			var bpm : Number = SiONSounds.BPM + 100 * progress;
//			_driver.bpm = bpm;

			var hudEntity : Entity = _world.getTagManager().getEntity(EntityTag.HUD);
			if(hudEntity) {
				var hud : HUDComponent = hudEntity.getComponent(HUDComponent);
				var bpm : int = SiONSounds.BPM + 80 - int(80 * hud.getFriendHealthPercent());
				_driver.bpm = bpm;
			} else if(_driver.bpm > SiONSounds.BPM) {
				_driver.bpm -= 1;
			}
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * soundComponent 
			 */
			var soundComponent: SoundComponent = _soundMapper.get(e);
			if(soundComponent.trigger) {
				trigger(soundComponent.trigger, soundComponent.arg);
				soundComponent.trigger = null;
			}
		}

		/**
		 * trigger 
		 * 
		 * @param name 
		 * 
		 * @return 
		 */
		private function trigger(name : String, arg: * = null) : void {
			switch(name){
				case SiONSounds.ENEMY_DAMAGE:
					var initialNote: int = SiONSounds.byName(name).note;
					var p: Number = Number(arg);
					if (isNaN(p)) p = 1;
					var note: int = Math.floor(MathUtils.interpolate(initialNote, initialNote - 32, p));
					note = MathUtils.roundToNearest(note, 4);
					playSoundbyName(SiONSounds.ENEMY_DAMAGE, note);
					break;
				default:
					playSoundbyName(name);
					break;
			}
		}
		
		/**
		 * SiON
		 */
		private function initSiON() : void {
            // listen
            _driver.setBeatCallbackInterval(1);
            _driver.addEventListener(SiONTrackEvent.BEAT, _onBeat);
            _driver.setTimerInterruption(1, _onTimerInterruption);
            
            // start streaming
            _beatCounter = 0;
            _driver.play();
			
			_drums = new DrumMachine();
			_drums.snareVoiceNumber = SiONSounds.SNARE_VOICE;
			_drums.snarePatternNumber = SiONSounds.SNARE_PATTERN;
			
			_drums.bassVoiceNumber = SiONSounds.KICK_VOICE;
			_drums.bassPatternNumber = SiONSounds.KICK_PATTERN;
			
			_drums.hihatVoiceNumber = SiONSounds.HIHAT_VOICE;
			_drums.hihatPatternNumber = SiONSounds.HIHAT_PATTERN;
			_drums.hihatVolume = 0.5;
			
//			_drums.effectors = [new SiEffectDistortion()];
			_drums.volume = 1;
			_drums.play();
			_driver.bpm = SiONSounds.BPM;
        }
        
        
        // _onBeat (SiONTrackEvent.BEAT) is called back in each beat at the sound timing.
        /**
         * _onBeat 
         * 
         * @param e 
         * 
         * @return 
         */
        private function _onBeat(e:SiONTrackEvent) : void 
        {
//            trace("SoundSystem._onBeat(",e,")");
			//matrixPad.beat(e.eventTriggerID & 15);
            // Could do something on the beats?
        }
        
        
        // _onTimerInterruption (SiONDriver.setTimerInterruption) is called back in each beat at the buffering timing.
        /**
         * _onTimerInterruption 
         * 
         * @return 
         */
        private function _onTimerInterruption() : void
        {
//			trace("SoundSystem._onTimerInterruption()", _beatCounter);
//            var beatIndex:int = beatCounter & 15;
            /**
             * i 
             */
            for (var i:int=0; i<16; i++) {
            //    if (matrixPad.sequences[i] & (1<<beatIndex)) driver.noteOn(notes[i], voices[i], length[i]);
            }
            _beatCounter++;
        }
	}
}
