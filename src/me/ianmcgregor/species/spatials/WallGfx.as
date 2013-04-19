package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.components.CollisionRect;

	import starling.display.Quad;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public class WallGfx extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Quad;
		/**
		 * _rect 
		 */
		private var _rect : CollisionRect;

		/**
		 * WallGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function WallGfx(world : World, owner : Entity) {
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
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			/**
			 * rectMapper 
			 */
			var rectMapper : ComponentMapper = new ComponentMapper(CollisionRect, _world);
			_transform = transformMapper.get(_owner);
			_rect = rectMapper.get(_owner);

			_gfx = new Quad(_rect.rect.width, _rect.rect.height);
			_gfx.color = 0xffffff;
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			/**
			 * x 
			 */
			var x : Number = _transform.x;
			/**
			 * y 
			 */
			var y : Number = _transform.y;
			_gfx.x = x;
			_gfx.y = y;
			if (!g.contains(_gfx)) {
				g.addChild(_gfx);
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
