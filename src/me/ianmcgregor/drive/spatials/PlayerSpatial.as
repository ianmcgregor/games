package me.ianmcgregor.drive.spatials {
	import me.ianmcgregor.drive.components.CharacterComponent;
	import me.ianmcgregor.drive.components.PlayerComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Image;
	import starling.display.Sprite;
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
		private var _gfx : Sprite;
		private var _car : Image;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _player : PlayerComponent;
		private var _character : CharacterComponent;

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
//			var avatar : AvatarComponent = _owner.getComponent(AvatarComponent);

			/**
			 * gfx
			 */
			g.addChild(_gfx = new Sprite());
			_gfx.name = "Player";

			var tex : String = _player.playerNum == 1 ? "car2" : "car";
			_gfx.addChild(_car = new Image(g.assets.getTexture(tex)));
			
			_gfx.pivotX = 32;
			_gfx.pivotY = 32;
			_gfx.touchable = false;
			_gfx.flatten();
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			_gfx.x = _transform.x - g.camera.x;
			_gfx.y = _transform.y - g.camera.y;
			_gfx.rotation = _transform.rotation + Math.PI * 0.5;
			
			if (_character.damageDirection) {
				var texName : String = "damage_" + _character.damageDirection;
				if(!_gfx.getChildByName(texName)) {
					var tex : Texture = g.assets.getTexture(texName);
					var img: Image = new Image(tex);
					img.name = texName;
					_gfx.unflatten();
					_gfx.addChild(img);
					_gfx.flatten();
				}
				_character.damageDirection = null;
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
