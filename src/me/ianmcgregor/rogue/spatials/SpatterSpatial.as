package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Shapes;
	import me.ianmcgregor.rogue.constants.Constants;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class SpatterSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		
		/**
		 * SpatterSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function SpatterSpatial(world : World, owner : Entity) {
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
//			_gfx.flatten();
			_gfx.touchable = false;
			if(!g.assets.getTexture(Constants.TEXTURE_SPATTER)) {
				g.assets.addTexture(Constants.TEXTURE_SPATTER, Texture.fromBitmapData(Shapes.rectangle(2, 2, 0xFFFF0000), false));
			}
			var texture: Texture = g.assets.getTexture(Constants.TEXTURE_SPATTER);
			var i: int = 8;
			while(--i > -1) {
				_gfx.addChild(new Image(texture));
			}
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
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;

			var l: int = _gfx.numChildren;
			var i: int = l;
			
//			_gfx.getChildAt(0).x += 0;
//			_gfx.getChildAt(0).y += -1;
//			
//			_gfx.getChildAt(1).x += -1;
//			_gfx.getChildAt(1).y += 0;
//			
//			_gfx.getChildAt(2).x += 0;
//			_gfx.getChildAt(2).y += 1;
//			
//			_gfx.getChildAt(3).x += 1;
//			_gfx.getChildAt(3).y += 0;
//			
//			_gfx.getChildAt(4).x += 1;
//			_gfx.getChildAt(4).y += 1;
//			
//			_gfx.getChildAt(5).x += -1;
//			_gfx.getChildAt(5).y += -1;
//			
//			_gfx.getChildAt(6).x += -1;
//			_gfx.getChildAt(6).y += 1;
//			
//			_gfx.getChildAt(7).x += 1;
//			_gfx.getChildAt(7).y += -1;
			
			while(--i > -1) {
				var blob: DisplayObject = _gfx.getChildAt(i);
				blob.x += i - l * 0.5;
				blob.y += i - l * 0.5;
				blob.alpha *= 0.9;
//				blob.scaleX += 0.2;
//				blob.scaleY = blob.scaleX; 
			}
			
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
				g.removeChild(_gfx);
			}
		}
		
		
		//		protected var _rectQuad : Quad;
//		protected function showCollisionRect(g : Canvas, transformX: Number, transformY: Number): void {
//			var rectMapper : ComponentMapper = new ComponentMapper(CollisionRect, _world);
//			var r: CollisionRect = rectMapper.get(_owner);
//			if(r) {
//				if (!g.contains(_rectQuad)) {
//						_rectQuad = new Quad(r.rect.width, r.rect.height);
//						_rectQuad.color = 0x00FFFF;
//						_rectQuad.alpha = 0.6;
//						g.addChild(_rectQuad);
//				}
//				_rectQuad.x = transformX + r.rect.x;
//				_rectQuad.y = transformY + r.rect.y;
//				
////				if (!g.contains(_gfx) && g.contains(_rect)) {
////					g.removeChild(_rect);
////				}
//			}
//		}
	}
}
