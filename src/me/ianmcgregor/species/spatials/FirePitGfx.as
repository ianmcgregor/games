package me.ianmcgregor.species.spatials {
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
	 * FirePitGfx 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class FirePitGfx extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _particleSystem 
		 */
		private var _particleSystem : PDParticleSystem;

		/**
		 * FirePitGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function FirePitGfx(world : World, owner : Entity) {
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
			if(!g.contains(_particleSystem))
			{
				g.addChild(_particleSystem);
			}
			
			_particleSystem.emitterX = _transform.x + 16;
			_particleSystem.emitterY = _transform.y + 16;
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