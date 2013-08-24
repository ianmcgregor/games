package me.ianmcgregor.fight.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class BgSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		private var _staticBg : Image;
		private var _sBg1 : Image;
		private var _sBg2 : Image;
		private var _scrollDelta : Number;
		private var _scroll : Number = 0;
		private var _floor : Quad;

		/**
		 * NullSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BgSpatial(world : World, owner : Entity) {
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
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			g.addChild(_gfx = new Sprite());
			_gfx.addChild(_staticBg = new Image(g.assets.getTexture("background2")));
			_gfx.addChild(_sBg1 = new Image(g.assets.getTexture("city2")));
			_gfx.addChild(_sBg2 = new Image(g.assets.getTexture("city2")));
			
			_gfx.addChild(_floor = new Quad(g.getWidth(), 128));
			_floor.color = 0x333333;
			_floor.y = 512;

			_sBg1.y = _sBg2.y = 232;
			_sBg2.x = _sBg1.width;

			_gfx.touchable = false;
			
//			_gfx.visible = false; 
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			var s: Number = 0 - g.camera.x;
			if(s == 0) {
				_sBg1.x = 0;
				_sBg2.x = _sBg1.width;
			}
			_scrollDelta = _scroll - s;
			_scroll = s;
			
			_sBg1.x -= int(_scrollDelta);
			_sBg2.x -= int(_scrollDelta);

			if (_sBg1.x < 0 - _sBg1.width) {
				_sBg1.x = _sBg2.x + _sBg2.width;
			} else if (_sBg2.x < 0 - _sBg2.width) {
				_sBg2.x = _sBg1.x + _sBg1.width;
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
