package me.ianmcgregor.pong.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Quad;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;



	/**
	 * @author McFamily
	 */
	public class Paddle extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _quad 
		 */
		private var _quad : Quad;
//		private var _bitmapData : BitmapData;
		
		/**
		 * Paddle 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function Paddle(world : World, owner : Entity) {
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
			g;
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

//			_bitmapData = new BitmapData(20, 60, false, 0xff0000);
			
			_quad = new Quad(20, 60);
			_quad.color = 0xff0000;
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
//			g.blit(_bitmapData, x, y);
			_quad.x = x;
			_quad.y = y;
			g.addChild(_quad);
		}
	}
}
