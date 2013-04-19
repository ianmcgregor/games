package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.assets.Assets;

	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * ExplosionGfx 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class ExplosionGfx extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _expires 
		 */
		private var _expires : ExpiresComponent;
		/**
		 * _initialLifeTime 
		 */
		private var _initialLifeTime : int;
		/**
		 * _life 
		 */
		private var _life : Number;
		/**
		 * _particleSystem 
		 */
		private var _particleSystem : PDParticleSystem;

		/**
		 * ExplosionGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function ExplosionGfx(world : World, owner : Entity) {
			super(world, owner);
		}

		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g: GameContainer) : void {
			g;
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			var expiresMapper : ComponentMapper = new ComponentMapper(ExpiresComponent, _world);
			_expires = expiresMapper.get(_owner);
			_initialLifeTime = _expires.getLifeTime();

			// instantiate embedded objects
			var pex : XML = Assets.explodePex;
			var texture : Texture = Assets.explodeTexture;

			// create particle system
			_particleSystem = new PDParticleSystem(pex, texture);
			// ps.x = 160;
			// ps.y = 240;

			// add it to the stage and the juggler
		//	Starling.current.stage.addChild(ps);
			Starling.juggler.add(_particleSystem);

			// change position where particles are emitted
			// ps.emitterX = 20;
			// ps.emitterY = 40;

			// start emitting particles
			_particleSystem.start();

			// emit particles for two seconds, then stop
			// ps.start(2.0);
			 
			// stop emitting particles
			// ps.stop();
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			_life = _expires.getLifeTime() / _initialLifeTime;
			
			if(!g.contains(_particleSystem))
			{
				g.addChild(_particleSystem);
			}
			
			// ps.x = _transform.x;
			// ps.y = _transform.y;
			_particleSystem.emitterX = _transform.x;
			_particleSystem.emitterY = _transform.y;

			if (_life <= 0) {
				_particleSystem.stop();
				Starling.juggler.remove(_particleSystem);
				g.removeChild(_particleSystem);
			}
		}
		
		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if (g.contains(_particleSystem)) {
				_particleSystem.stop();
				g.removeChild(_particleSystem);
				Starling.juggler.remove(_particleSystem);
			}
		}
	}
}