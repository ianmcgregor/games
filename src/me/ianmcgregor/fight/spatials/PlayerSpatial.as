package me.ianmcgregor.fight.spatials {
	import me.ianmcgregor.fight.components.AvatarComponent;
	import me.ianmcgregor.fight.components.CharacterComponent;

	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.DisplayObjectContainer;

	import me.ianmcgregor.fight.components.PlayerComponent;
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
		private var _gfx : DisplayObjectContainer;
		private var _run : MovieClip;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _player : PlayerComponent;
		private var _character : CharacterComponent;
		private var _kick : Image;
		private var _punch : Image;

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
			_character = _owner.getComponent(CharacterComponent);
			var avatar : AvatarComponent = _owner.getComponent(AvatarComponent);

			/**
			 * gfx
			 */
			g.addChild(_gfx = new Sprite());

			var runTex : Vector.<Texture> = new Vector.<Texture>();
			runTex.push(g.assets.getTexture(avatar.texturePrefix + "_stand"), g.assets.getTexture(avatar.texturePrefix + "_run"));
			_gfx.addChild(_run = new MovieClip(runTex, 5));
			Starling.current.juggler.add(_run);

			_gfx.addChild(_kick = new Image(g.assets.getTexture(avatar.texturePrefix + "_kick")));
			_gfx.addChild(_punch = new Image(g.assets.getTexture(avatar.texturePrefix + "_punch")));

			_gfx.pivotX = 32;
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

			var h : int = _character.directionH;
			var v : int = _character.directionV;

			_kick.visible = _character.isKicking();
			_punch.visible = _character.isPunching();
			_run.visible = !_character.isAttacking();

			if (h == 0 && v == 0) {
				_run.currentFrame = 0;
				// if(_run.isPlaying) _run.pause();
			} else if (v != 0) {
				_run.currentFrame = 1;
				// if(_run.isPlaying) _run.pause();
				if (h != 0) _gfx.scaleX = h;
			} else {
				_gfx.scaleX = h;
				// if(!_run.isPlaying) _run.play();
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
			trace("PlayerSpatial.remove(",g,")");
			if (g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
