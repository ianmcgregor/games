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
	 * BombGfx 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class BombGfx extends Spatial {
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
		 * _particleSystem 
		 */
		private var _particleSystem : PDParticleSystem;
		/**
		 * _life 
		 */
		private var _life : Number;

		/**
		 * BombGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BombGfx(world : World, owner : Entity) {
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
			
//			_quad = new Quad(4, 4);
//			_quad.color = 0xff2222;
			
			var pex : XML =Assets.fireBall2Pex;
			var texture : Texture = Assets.fireBall2Texture;
			_particleSystem = new PDParticleSystem(pex, texture);
			Starling.juggler.add(_particleSystem);
			_particleSystem.start();
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
			
			_particleSystem.emitterX = _transform.x;
			_particleSystem.emitterY = _transform.y + 10;

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
				g.removeChild(_particleSystem);
				_particleSystem.stop();
				Starling.juggler.remove(_particleSystem);
			}
		}

	}
}