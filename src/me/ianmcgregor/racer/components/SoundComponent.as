package me.ianmcgregor.racer.components {
	import me.ianmcgregor.games.audio.AudioObject;

	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public class SoundComponent extends Component {
		
		/**
		 * _sound 
		 */
		private var _sound: AudioObject;
		/**
		 * startTime 
		 */
		public var startTime : Number;

		/**
		 * SoundComponent 
		 * 
		 * @param audioObject 
		 * 
		 * @return 
		 */
		public function SoundComponent(audioObject : AudioObject) {
			_sound = audioObject;
		}
		
		/**
		 * play 
		 * 
		 * @param startTime 
		 * @param volume 
		 * 
		 * @return 
		 */
		public function play(startTime : Number, volume : Number) : void {
			this.startTime = startTime;
//			trace("SoundComponent.play(", startTime, volume, ")");
			_sound.volume = volume;
			_sound.play(startTime);
		}
	}
}
