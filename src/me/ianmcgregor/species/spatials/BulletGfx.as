package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Quad;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;



	/**
	 * BulletGfx 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class BulletGfx extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _quad 
		 */
		private var _quad : Quad;
		/**
		 * _expires 
		 */
		private var _expires : ExpiresComponent;
		/**
		 * _initialLifeTime 
		 */
		private var _initialLifeTime : int;

		/**
		 * BulletGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BulletGfx(world : World, owner : Entity) {
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
			
			_quad = new Quad(2, 2);
			_quad.color = 0xffffff;
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			_quad.alpha = _expires.getLifeTime() / _initialLifeTime;
			_quad.x = x;
			_quad.y = y;
			if(!g.contains(_quad)){
				g.addChild(_quad);
			}
			
			if (_expires.getLifeTime() / _initialLifeTime <= 0) {
				g.removeChild(_quad);
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
			if (g.contains(_quad)) {
				g.removeChild(_quad);
			}
		}

	}
}