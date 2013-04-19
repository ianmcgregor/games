package me.ianmcgregor.games.audio {
	import flash.utils.Dictionary;

	/**
	 * @author McFamily
	 */
	public class Audio {
		private static const _soundObjects : Dictionary = new Dictionary();

		/**
		 * add 
		 * 
		 * @param SoundClass 
		 * 
		 * @return 
		 */
		public static function add(SoundClass: Class) : AudioObject {
			// sound already exists?
			/**
			 * sound 
			 */
			var sound : AudioObject = get(SoundClass);
			if (!sound) {
//				trace('SoundClass: ' + (SoundClass));
				sound = new AudioObject(new SoundClass());
				_soundObjects[SoundClass] = sound;
			}
			return sound;
		}
		
		/**
		 * get 
		 * 
		 * @param SoundClass 
		 * 
		 * @return 
		 */
		public static function get(SoundClass: Class) : AudioObject {
			return _soundObjects[SoundClass];
		}

		/**
		 * play 
		 * 
		 * @param SoundClass 
		 * 
		 * @return 
		 */
		public static function play(SoundClass: Class) : void {
//			trace("Audio.play(",SoundClass,")");
			add(SoundClass).play();
		}
//		public static function add(id : String, data : Sound) : AudioObject {
//			// sound already exists?
//			var sound : AudioObject = get(id);
//			if (!sound) {
//				_soundObjects[id] = new AudioObject(id, data);
//			}
//			return sound;
//		}
//		
//		public static function get(id: String) : AudioObject {
//			return _soundObjects[id];
//		}
	}
}
