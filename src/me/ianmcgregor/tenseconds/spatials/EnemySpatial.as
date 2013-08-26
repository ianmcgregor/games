package me.ianmcgregor.tenseconds.spatials {
	import me.ianmcgregor.games.utils.collections.ObjectPool;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.tenseconds.spatials.gfx.template.ParticleGfx;

	import starling.events.Event;

	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class EnemySpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : ParticleGfx;
		private var _explodeGfx : ParticleGfx;
		
		/**
		 * NullSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function EnemySpatial(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g : GameContainer) : void {
			_transform = _owner.getComponent(TransformComponent);
			if(!_gfx) _gfx = new ParticleGfx(g.assets.getXml("enemyPex"), g.assets.getTexture("enemyTex"), false);
			if(!_explodeGfx) _explodeGfx = new ParticleGfx(g.assets.getXml("explodePex"), g.assets.getTexture("explodeTex"), false);
			g.addChild(_gfx);
			g.addChild(_explodeGfx);
			_gfx.start();
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			g;
			_gfx.x = _transform.x;// - g.camera.x;
			_gfx.y = _transform.y;// - g.camera.y;
//			_gfx.rotation = _transform.rotation + Math.PI * 0.5;
		}

		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
				_gfx.stop(false);
				
				Audio.play(Explosion14, 0.5);
				_explodeGfx.start(0.4);
				_explodeGfx.x = _gfx.x;
				_explodeGfx.y = _gfx.y;
				_explodeGfx.addEventListener(Event.COMPLETE, onExplodeComplete);
			}
		}

		private function onExplodeComplete(event : Event) : void {
			event;
			_explodeGfx.removeEventListener(Event.COMPLETE, onExplodeComplete);
			_explodeGfx.stop(true);
			_explodeGfx.parent.removeChild(_explodeGfx);
			
			ObjectPool.dispose(this);
		}
	}
}
