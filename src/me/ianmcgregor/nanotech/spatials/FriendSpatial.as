package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;
	import me.ianmcgregor.nanotech.components.FriendComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.spatials.gfx.ParticleGfx;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class FriendSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : ParticleGfx;
		/*
		 * components
		 */
		private var _physics : PhysicsComponent;
		private var _friend : FriendComponent;
		private var _health : HealthComponent;
		
		/**
		 * EnemySpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function FriendSpatial(world : World, owner : Entity) {
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
			/**
			 * mappers 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			var physicsMapper : ComponentMapper = new ComponentMapper(PhysicsComponent, _world);
			_physics = physicsMapper.get(_owner);

			var friendMapper : ComponentMapper = new ComponentMapper(FriendComponent, _world);
			_friend = friendMapper.get(_owner);

			var healthMapper : ComponentMapper = new ComponentMapper(HealthComponent, _world);
			_health = healthMapper.get(_owner);
			
			/**
			 * gfx
			 */
//			var pex : XML;
//			var texture : Texture;
////			if(MathUtils.coinToss()) {
////				pex = ParticleAssets.PARTICLE_PEX_P2;
////				texture = ParticleAssets.PARTICLE_TEX_P2;
////			} else {
//				pex = ParticleAssets.PARTICLE_PEX2;
//				texture = ParticleAssets.PARTICLE_TEX2;
////			}
//			g.addChild(_gfx = new ParticleGfx(pex, texture));
			g.addChild(_gfx = new ParticleGfx(ParticleAssets.PARTICLE_PEX2, ParticleAssets.PARTICLE_TEX2));
			_gfx.touchable = false;
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
			_gfx.x = _physics.x;
			_gfx.y = _physics.y;
			_gfx.rotation = _physics.rotation;
			_gfx.scaleX = _gfx.scaleY = _transform.scale;
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
				_gfx.stop();
				g.removeChild(_gfx);
			}
		}
	}
}
