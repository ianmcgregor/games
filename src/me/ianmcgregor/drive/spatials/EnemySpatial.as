package me.ianmcgregor.drive.spatials {
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.spatials.gfx.template.SpriteGfx;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Image;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class EnemySpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : SpriteGfx;
		private var _damaged : Image;
		private var _destroyed : Image;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _health : HealthComponent;

		/**
		 * Spatial 
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
			_health = _owner.getComponent(HealthComponent);

			/**
			 * gfx
			 */
			g.addChild(_gfx = new SpriteGfx(g.assets.getTexture("car3")));
			_gfx.addChild(_damaged = new Image(g.assets.getTexture("car3")));
			_gfx.addChild(_destroyed = new Image(g.assets.getTexture("enemy_destroyed")));
			_damaged.visible = _destroyed.visible = false;
			_gfx.name = Constants.ENEMY;
			_gfx.pivotX = 32;
			_gfx.pivotY = 32;
			_gfx.touchable = false;
			_gfx.flatten();
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			_gfx.x = _transform.x - g.camera.x;
			_gfx.y = _transform.y - g.camera.y;
			_gfx.rotation = _transform.rotation + Math.PI * 0.5;
			
			// add damage gfx
			if(!_damaged.visible && _health.getHealthPercentage() < 0.5) {
				_gfx.unflatten();
				_damaged.visible = true;
				_gfx.flatten();
			}
			if(!_destroyed.visible && !_health.isAlive()) {
				_gfx.unflatten();
				_destroyed.visible = true;
				_gfx.flatten();
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
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
