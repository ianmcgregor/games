package me.ianmcgregor.species.factories {
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.species.assets.Sounds;
	/**
	 * @author McFamily
	 */
	public class SoundFactory {
		private static const _explosions : Array = [Sounds.Explosion11, Sounds.explode, Sounds.Explosion4];
		private static const _bullets : Array = [Sounds.Laser_Shoot14, Sounds.Laser_Shoot36];
		private static const _acheivement : Array = [Sounds.Default, Sounds.Randomize29, Sounds.Randomize28];

		/**
		 * getRandom 
		 * 
		 * @param array 
		 * 
		 * @return 
		 */
		private static function getRandom(array : Array) : Class {
			return array[Math.floor( array.length * Math.random() )];
		}
		
		/**
		 * explode 
		 * 
		 * @return 
		 */
		public static function explode(): void {
			Audio.play(getRandom(_explosions));
		}
		/**
		 * shoot 
		 * 
		 * @return 
		 */
		public static function shoot(): void {
			Audio.play(getRandom(_bullets));
		}
		/**
		 * startLevel 
		 * 
		 * @return 
		 */
		public static function startLevel(): void {
			Audio.play(getRandom(_acheivement));
		}
		/**
		 * grapple 
		 * 
		 * @return 
		 */
		public static function grapple(): void {
			Audio.play(Sounds.Randomize20);
		}
	}
}
