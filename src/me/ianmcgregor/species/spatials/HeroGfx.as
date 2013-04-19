package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.assets.Assets;
	import me.ianmcgregor.species.components.Velocity;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public class HeroGfx extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
//		private var _gfx : Quad;
		/**
		 * _gfx 
		 */
		private var _gfx : MovieClip;
		/**
		 * _velocity 
		 */
		private var _velocity : Velocity;

		/**
		 * HeroGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function HeroGfx(world : World, owner : Entity) {
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
			 * velocityMapper 
			 */
			var velocityMapper : ComponentMapper = new ComponentMapper(Velocity, _world);
			_transform = transformMapper.get(_owner);
			_velocity = velocityMapper.get(_owner);
			/**
			 * textures 
			 */
			var textures : Vector.<Texture> = new Vector.<Texture>();
			textures.push(Assets.heroTexture2, Assets.heroTexture1);
			_gfx = new MovieClip(textures, 10);
			Starling.current.juggler.add(_gfx);
//			_gfx = new Quad(32, 32);
//			_gfx.color = 0x00ff00;
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
			
			if(_velocity.velocityX < 0) {
				_gfx.scaleX = -1;
			} else if(_velocity.velocityX > 0) {
				_gfx.scaleX = 1;
			}
			
			if(_gfx.scaleX == -1){
				_gfx.x +=_gfx.width;
			}
			
			if(_velocity.velocityX != 0){
				if(!_gfx.isPlaying){
					_gfx.play();
				}
			} else {
				if(_gfx.isPlaying){
					_gfx.pause();
				}
			}
			
//			showCollisionRect(g, _transform.x, _transform.y);
		}
	}
}
