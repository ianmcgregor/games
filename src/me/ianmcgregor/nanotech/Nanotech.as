package me.ianmcgregor.nanotech {
	import me.ianmcgregor.games.base.BaseGame;
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;
	import me.ianmcgregor.nanotech.constants.State;
	import me.ianmcgregor.nanotech.contexts.NanotechContext;
	import me.ianmcgregor.nanotech.spatials.gfx.ParticleGfx;

	import starling.events.Event;

	/**
	 * @author McFamily
	 */
	public final class Nanotech extends BaseGame {
		/**
		 * Game 
		 */
		public function Nanotech() {
			super();
		}

		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		override protected function onAddedToStage(event : Event) : void {
			super.onAddedToStage(event);
			
			_context = new NanotechContext(_gameContainer);
			_context.init();
			
			_gameContainer.state = State.TITLES;

			var p : ParticleGfx;
			addChild(p = new ParticleGfx(ParticleAssets.CLOUD_2_PEX, ParticleAssets.CLOUD_2_TEX));
			
			p.x = _gameContainer.getWidth() * 0.5;
			p.y = _gameContainer.getHeight() * 0.5;
		}

		/**
		 * update 
		 * 
		 * @param deltaTime 
		 * 
		 * @return 
		 */
		override protected function update(deltaTime : Number) : void {
			super.update(deltaTime);
		}

		/**
		 * start 
		 * 
		 * @return 
		 */
		override public function start() : void {
			super.start();
		}

		/**
		 * stop 
		 * 
		 * @return 
		 */
		override public function stop() : void {
			super.stop();
		}
	}
}
