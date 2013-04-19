package me.ianmcgregor.nanotech.spatials {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Shapes;
	import me.ianmcgregor.nanotech.assets.particles.ParticleAssets;
	import me.ianmcgregor.nanotech.components.EnemyComponent;
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
	public final class EnemySpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
//		private var _gfx : EnemyGfx;
		private var _gfx : ParticleGfx;
		/*
		 * components
		 */
		private var _physics : PhysicsComponent;
		private var _enemy : EnemyComponent;
		private var _health : HealthComponent;
		
		/**
		 * EnemySpatial 
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
			/**
			 * mappers 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			var physicsMapper : ComponentMapper = new ComponentMapper(PhysicsComponent, _world);
			_physics = physicsMapper.get(_owner);

			var enemyMapper : ComponentMapper = new ComponentMapper(EnemyComponent, _world);
			_enemy = enemyMapper.get(_owner);

			var healthMapper : ComponentMapper = new ComponentMapper(HealthComponent, _world);
			_health = healthMapper.get(_owner);
			
			/**
			 * textures
			 */
			var color : uint = 0x708D91;
			if(!g.assets.getTexture(Constants.ENEMY)){
				g.assets.addTexture(Constants.ENEMY, Texture.fromBitmapData(Shapes.circle(Constants.ENEMY_RADIUS, color)));	
			}
			
			/**
			 * gfx
			 */
//			g.addChild(_gfx = new EnemyGfx(g.assets.getTexture(_enemy.type)));
//			_gfx.flatten();
			g.addChild(_gfx = new ParticleGfx(ParticleAssets.ENEMY_PEX, ParticleAssets.ENEMY_TEX));
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
			
			var health : Number = _health.getHealthPercentage();
			_gfx.startColor.red = 0.72 * health;
			_gfx.endColor.red = 1.0 * health;
			_gfx.startColor.blue = 0.18 * health;
			_gfx.endColor.blue = 0.11 * health;
			//_gfx.alpha = 0.2 + 0.8 * health;
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
