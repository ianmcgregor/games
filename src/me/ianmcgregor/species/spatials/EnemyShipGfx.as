package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import flash.display.BitmapData;

	/**
	 * @author McFamily
	 */
	public class EnemyShipGfx extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : MovieClip;

		/**
		 * EnemyShipGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function EnemyShipGfx(world : World, owner : Entity) {
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
			_transform = transformMapper.get(_owner);
			/**
			 * textures 
			 */
			var textures : Vector.<Texture> = new Vector.<Texture>();
//			if (weapon != null) {
//				textures.push(Assets.enemyGunTexture1, Assets.enemyGunTexture2);
//			} else {
//				textures.push(Assets.enemyMoustacheTexture1, Assets.enemyMoustacheTexture2);
//			}
			textures.push( Texture.fromBitmapData( new BitmapData(64, 48, true, 0xFFFF0000)));

			// _gfx = new Quad(32, 32);
			// _gfx.color = 0xff0000;

			_gfx = new MovieClip(textures, 10);
			Starling.current.juggler.add(_gfx);
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
//			trace("EnemyShipGfx.render(",g,")");
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
//			trace("EnemyShipGfx.remove(",g,")");
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
				Starling.current.juggler.remove(_gfx);
			}
		}
	}
}
