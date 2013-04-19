package me.ianmcgregor.nanotech.spatials.gfx {
	/**
	 * @author McFamily
	 */
	public class SiONSounds {
		
		public static const HERO : String = "HERO";
		public static const BULLET : String = "BULLET";
		public static const ENEMY : String = "ENEMY";
		public static const ENEMY_DAMAGE : String = "ENEMY_DAMAGE";
		public static const ENEMY_COLLISION : String = "ENEMY_COLLISION";
		public static const FRIEND_DAMAGE : String = "FRIEND_DAMAGE";
		public static const ENEMY_KILL : String = "ENEMY_KILL";
		public static const FRIEND_KILL : String = "FRIEND_KILL";
		
		public static var BPM : int = 88;
		public static var KICK_VOICE : int = 4;
		public static var KICK_PATTERN : int = 21;
		public static var SNARE_VOICE : int = 3;
		public static var SNARE_PATTERN : int = 3;
		public static var HIHAT_VOICE : int = 4;
		public static var HIHAT_PATTERN : int = 4;
		
		static public var LIST : Vector.<SiONSoundVO> = Vector.<SiONSoundVO>([
			new SiONSoundVO(BULLET, "valsound.brass", 2, 16, 1, 0.5),
			
			new SiONSoundVO(ENEMY, "valsound.strpad", 20, 20, 4),
			
//			new SiONSoundVO(ENEMY_DAMAGE, "valsound.strpad", 14, 40, 1),
//			new SiONSoundVO(ENEMY_DAMAGE, "valsound.world", 3, 60, 2),
			new SiONSoundVO(ENEMY_DAMAGE, "valsound.world", 4, 40, 2),
			new SiONSoundVO(ENEMY_KILL, "valsound.special", 3, 30, 2),
			
			new SiONSoundVO(ENEMY_COLLISION, "valsound.strpad", 12, 28, 2),

//			new SiONSoundVO(FRIEND_DAMAGE, "valsound.world", 3, 30, 4)
			new SiONSoundVO(FRIEND_DAMAGE, "valsound.world", 3, 22, 4),
			new SiONSoundVO(FRIEND_KILL, "valsound.se", 1, 26, 2)
		]);
		
		//new SiONSoundVO(ENEMY_KILL, "valsound.special", 3, 30, 2),
		//new SiONSoundVO(FRIEND_KILL, "valsound.world", 3, 22, 4)
		
		static public function byName(name: String) : SiONSoundVO {
			var l: int = LIST.length;
			for (var i : int = 0; i < l; ++i) {
				if(LIST[i].name == name) {
					return LIST[i];
				}
			}
			return null;
		}
		
		static public function toString() : String {
			 var s: String = "";
			 var l: int = LIST.length;
			 for (var i : int = 0; i < l; ++i) {
				if(s != "") s += ",\n";
			 	var t: SiONSoundVO = LIST[i];
				s += "new SiONSoundVO(" + t.name + ", \"" + t.category + "\", " + t.voice + ", " + t.note + ", " + t.length + ")";
			 }
			 return s;
		}
	}
}
