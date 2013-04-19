package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.spatials.gfx.TextureSelectGfx;

	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class TreasureSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		
		/**
		 * TreasureSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function TreasureSpatial(world : World, owner : Entity) {
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
			
			var atlas: TextureAtlas;
			atlas = g.assets.getTextureAtlas(Constants.TILE_ATLAS);
			g.addChild(_gfx = new TextureSelectGfx(atlas, Constants.TEXTURE_TREASURE));
//			_gfx.flatten();
//			_gfx.touchable = false;
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
