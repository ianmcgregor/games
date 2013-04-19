package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.SwordComponent;
	import me.ianmcgregor.rogue.constants.Constants;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class SwordSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		private var _sword : SwordComponent;
		private var _playerTransform : TransformComponent;
		private var _player : PlayerComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		private var _img : Image;
		private const SWORD_ROTATION : Number = Math.PI * 0.75;
		private var _tween : Tween;
		
		/**
		 * WeaponSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function SwordSpatial(world : World, owner : Entity) {
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
			

			var swordMapper : ComponentMapper = new ComponentMapper(SwordComponent, _world);
			_sword = swordMapper.get(_owner);

			_player = _sword.owner.getComponent(PlayerComponent);
			_playerTransform = _sword.owner.getComponent(TransformComponent);
			
			var atlas: TextureAtlas;
			atlas = g.assets.getTextureAtlas(Constants.TILE_ATLAS);
			g.addChild(_gfx = new Sprite());
			
			_gfx.addChild(_img = new Image(atlas.getTexture(Constants.TEXTURE_SWORD)));
			_img.pivotX = 32;
			_img.rotation = SWORD_ROTATION;
			_img.x = Constants.TILE_SIZE * 1.2;
			_img.y = Constants.TILE_SIZE * 0.8;
			_gfx.touchable = false;
			
			_tween = new Tween(_img, 0.5, Transitions.EASE_IN);
		}
		
		/**
		 * reset
		 */
		private function onTweenComplete() : void {
			_player.attack = Constants.ATTACK_READY;
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
			_gfx.x = _playerTransform.x - Constants.TILE_SIZE;
			_gfx.y = _transform.y;
			
			if (_player.attack == Constants.ATTACK_GO) {
				if(_tween.isComplete)_tween.reset(_img, 0.5, Transitions.EASE_IN);
				_tween.onComplete = onTweenComplete;
				_tween.animate("rotation", SWORD_ROTATION + Math.PI * 4);
				Starling.juggler.add(_tween);
				_player.attack = Constants.ATTACK_PROGRESS;
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
