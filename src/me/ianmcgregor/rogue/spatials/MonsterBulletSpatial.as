package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Shapes;
	import me.ianmcgregor.rogue.constants.Constants;

	import starling.display.Image;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class MonsterBulletSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Image;
		
		/**
		 * MonsterBulletSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function MonsterBulletSpatial(world : World, owner : Entity) {
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
			
			var texture: Texture = g.assets.getTexture(Constants.TEXTURE_ENEMY_BULLET);
			if(!texture) {
				g.assets.addTexture(Constants.TEXTURE_ENEMY_BULLET, Texture.fromBitmapData(Shapes.circle(4, 0xFFFF0000), false));
				texture = g.assets.getTexture(Constants.TEXTURE_ENEMY_BULLET);
			}
			g.addChild(_gfx = new Image(texture));
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
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;
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
