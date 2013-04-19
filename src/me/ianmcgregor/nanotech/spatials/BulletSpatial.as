package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Shapes;
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;
	import me.ianmcgregor.nanotech.components.BulletComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.spatials.gfx.ParticleGfx;

	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class BulletSpatial extends Spatial {
		/**
		 * _gfx 
		 */
//		private var _gfx : Image;
		private var _gfx : ParticleGfx;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		/**
		 * _physics 
		 */
		private var _physics : PhysicsComponent;
		/**
		 * _bullet 
		 */
		private var _bullet : BulletComponent;
		
		/**
		 * BulletSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BulletSpatial(world : World, owner : Entity) {
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
			 * bulletMapper 
			 */
			var bulletMapper : ComponentMapper = new ComponentMapper(BulletComponent, _world);
			_bullet = bulletMapper.get(_owner);
			
			/**
			 * textures
			 */
			if(!g.assets.getTexture(Constants.BULLET)){
				g.assets.addTexture(Constants.BULLET, Texture.fromBitmapData(Shapes.rectangle(Constants.BULLET_SIZE, Constants.BULLET_SIZE, 0xFFFFFFFF)));	
			}
			
			/**
			 * gfx
			 */
			//g.addChild(_gfx = new Image(g.assets.getTexture(Constants.BULLET)));
			g.addChild(_gfx = new ParticleGfx(ParticleAssets.BULLET_PEX, ParticleAssets.BULLET_TEX));
			_gfx.touchable = false;
			_gfx.pivotX = _gfx.pivotY = Constants.BULLET_SIZE * 0.5;
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
			
//			Logger.log("NullSpatial.render()", 2, 3);
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
