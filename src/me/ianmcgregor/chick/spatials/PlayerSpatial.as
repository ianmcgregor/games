package me.ianmcgregor.chick.spatials {
	import me.ianmcgregor.chick.components.PlayerComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : MovieClip;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _player : PlayerComponent;
		
		/**
		 * HeroSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function PlayerSpatial(world : World, owner : Entity) {
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

			var playerMapper : ComponentMapper = new ComponentMapper(PlayerComponent, _world);
			_player = playerMapper.get(_owner);
			
			/**
			 * gfx
			 */
			var textures : Vector.<Texture> = new Vector.<Texture>();
			textures.push(g.assets.getTexture("chick"), g.assets.getTexture("chick3"));
			g.addChild(_gfx = new MovieClip(textures, 5));
			Starling.current.juggler.add(_gfx);
			_gfx.pivotX = 16;
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
			_gfx.x = _transform.x + _gfx.pivotX - g.camera.x;
			_gfx.y = _transform.y + _gfx.pivotY - g.camera.y;
			_gfx.rotation = _transform.rotation;
			if(_player.direction != 0) {
				_gfx.scaleX = _player.direction;
				if(!_gfx.isPlaying){
					_gfx.play();
				}
			} else {
				if(_gfx.isPlaying){
					_gfx.pause();
				}
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
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
