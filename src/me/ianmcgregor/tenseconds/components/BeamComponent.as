package me.ianmcgregor.tenseconds.components {
	import flash.media.Sound;
	import me.ianmcgregor.games.audio.AudioObject;
	import me.ianmcgregor.games.audio.Audio;

	import com.artemis.Component;

	/**
	 * @author McFamily
	 */
	public class BeamComponent extends Component {
		
		public var rotation : Number = 0;
		private var _on : Boolean;
		private var audio : AudioObject;
		public var id : int;

		public function BeamComponent(id : int) {
			this.id = id;
			var sound : Sound = id % 2 == 0 ? new laser1() : new laser2();
			audio = new AudioObject(sound, true);
		}
		
		public function setOn(b: Boolean): void {
			if(b == _on) return;
			_on = b;
			if(_on) {
				audio.play(0, 0.3);
			} else {
				audio.stop();
			}
		}
		
		public function getOn() : Boolean {
			return _on;	
		}
	}
}
