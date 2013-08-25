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
		public static function add(SoundClass: Class, loop: Boolean = false) : AudioObject {
			// sound already exists?
			/**
			 * sound 
			 */
			var sound : AudioObject = get(SoundClass);
			if (!sound) {
//				trace('SoundClass: ' + (SoundClass));
				sound = new AudioObject(new SoundClass(), loop);
				_soundObjects[SoundClass] = sound;
			}
			sound.loop = loop;
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
		public static function play(SoundClass: Class, volume: Number = 1, loop: Boolean = false) : void {
//			trace("Audio.play(",SoundClass,")");
			add(SoundClass, loop).play(0, volume);
		}
		public static function stop(SoundClass: Class) : void {
//			trace("Audio.play(",SoundClass,")");
			var sound : AudioObject = get(SoundClass);
			if (sound) sound.stop();
		}
	}
}
