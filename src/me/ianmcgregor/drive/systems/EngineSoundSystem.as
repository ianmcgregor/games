package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.audio.EngineAudio;
	import me.ianmcgregor.drive.components.PhysicsComponent;
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.constants.State;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class EngineSoundSystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private const MIN_HZ : Number = 20;
		private var _minVolume : Number;
		
		private var _engineAudio: EngineAudio;

		/**
		 * EngineSoundSystem 
		 */
		public function EngineSoundSystem(g : GameContainer) {
			super(PhysicsComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_engineAudio = new EngineAudio();
			_engineAudio.play();
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_minVolume = 0.1;
			_engineAudio.hz = 0;
			_engineAudio.vol = 0;
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			if(_g.state != State.PLAY) {
				_engineAudio.hz = MIN_HZ;
				_engineAudio.vol = 0;
				return;
			}
			var p : PhysicsComponent = e.getComponent(PhysicsComponent);
			switch(p.name) {
				case Constants.HERO:
//				case Constants.ENEMY:
//				case Constants.ENEMY_1:
//				case Constants.ENEMY_2:
//				case Constants.ENEMY_3:
					var vel : Number = p.body.velocity.length;
					_engineAudio.hz = MIN_HZ + vel * 0.05;
					_engineAudio.vol = _minVolume + vel * 0.0001;
					break;
				default:
			}
		}

		
	}
}
