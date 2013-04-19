package me.ianmcgregor.nanotech.spatials.gfx {
	/**
	 * @author McFamily
	 */
	public class SiONSoundVO {
		public var name: String;
		public var category: String;
		public var voice : int;
		public var note : int;
		public var length : int;
		public var volume : Number;

		public function SiONSoundVO(name : String, category : String, voice : int, note : int = 60, length : int = 1, volume: Number = 1) {
			this.name = name;
			this.category = category;
			this.voice = voice;
			this.note = note;
			this.length = length;
			this.volume = volume;
		}

	}
}
