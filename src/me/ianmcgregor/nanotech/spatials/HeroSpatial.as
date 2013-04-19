package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Shapes;
	import me.ianmcgregor.nanotech.components.HeroComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.constants.KeyConstants;
	import me.ianmcgregor.nanotech.spatials.gfx.HeroGfx;

	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class HeroSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : HeroGfx;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		/**
		 * _physics 
		 */
		private var _physics : PhysicsComponent;
		/**
		 * _hero 
		 */
		private var _hero : HeroComponent;
		
		/**
		 * HeroSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function HeroSpatial(world : World, owner : Entity) {
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

			/**
			 * physicsMapper 
			 */
			var physicsMapper : ComponentMapper = new ComponentMapper(PhysicsComponent, _world);
			_physics = physicsMapper.get(_owner);

			/**
			 * heroMapper 
			 */
			var heroMapper : ComponentMapper = new ComponentMapper(HeroComponent, _world);
			_hero = heroMapper.get(_owner);
			
			/**
			 * textures
			 */
			var player : String = Constants.HERO + String(_hero.player);
			if (!g.assets.getTexture(player)) {
//				var color : uint = _hero.player == 1 ? 0xFF00FF : 0x00FFFF;
				/**
				 * color 
				 */
				var color : uint = _hero.player == 1 ? 0xD31996 : 0x19DD89;
				g.assets.addTexture(player, Texture.fromBitmapData(Shapes.triangle(Constants.HERO_SIZE, Constants.HERO_SIZE, color)));	
			}
			
			/**
			 * gfx
			 */
			g.addChild(_gfx = new HeroGfx(g.assets.getTexture(player)));
//			if(_hero.player == 1) {
//				g.addChild(_gfx = new ParticleGfx(ParticleAssets.PARTICLE_PEX2, ParticleAssets.PARTICLE_TEX2));
//			} else {
//				g.addChild(_gfx = new ParticleGfx(ParticleAssets.PARTICLE_PEX_P2, ParticleAssets.PARTICLE_TEX_P2));
//			}
//			_gfx.filter = BlurFilter.createGlow();
			//_gfx.flatten();
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
			_gfx.rotation = _physics.rotation + Math.PI * 0.5;
			var isThrusting: Boolean = _hero.player == 1 ? g.getInput().isDown(KeyConstants.UP_P1) : g.getInput().isDown(KeyConstants.UP_P2);
			_gfx.updateThrust(isThrusting);
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
			}
		}
	}
}
