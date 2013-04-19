package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.spatials.gfx.TextureSelectGfx;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

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
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _player : PlayerComponent;
		private var _weapon : WeaponComponent;
		private var _health : HealthComponent;
		private var _tween : Tween;
		
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

			var weaponMapper : ComponentMapper = new ComponentMapper(WeaponComponent, _world);
			_weapon = weaponMapper.get(_owner);

			var healthMapper : ComponentMapper = new ComponentMapper(HealthComponent, _world);
			_health = healthMapper.get(_owner);
			
			/**
			 * gfx
			 */
			var atlas : TextureAtlas;
			atlas = g.assets.getTextureAtlas(Constants.TILE_ATLAS);
			var texture : String = _player.playerNum == 1 ? Constants.TEXTURE_PLAYER_1 : Constants.TEXTURE_PLAYER_2;
//			g.addChild(_gfx = new PlayerGfx(_player.playerNum, texture));
			g.addChild(_gfx = new TextureSelectGfx(atlas, texture));
			
			_gfx.pivotX = _gfx.width * 0.5;
			_gfx.pivotY = _gfx.height * 0.5;
			
			
			/**
			 * tween
			 */
			_tween = new Tween(_gfx, 0.5, Transitions.EASE_IN);
			_tween.onComplete = onTweenComplete;
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
			
			if(_player.dead == Constants.DEATH_GO) {
				if(_tween.isComplete)_tween.reset(_gfx, 0.5, Transitions.EASE_IN);
				_tween.animate("rotation", Math.PI * 0.5);
				Starling.juggler.add(_tween);
				_player.dead = Constants.DEATH_PROGRESS;
			} else {
				_gfx.x = _transform.x + _gfx.pivotX;
				_gfx.y = _transform.y + _gfx.pivotY;
				_gfx.rotation = _transform.rotation;
			}
			
			if(g.state == State.INIT_LEVEL) {
				g.setChildIndex(_gfx, g.numChildren-1);
			}
		}
		
		/**
		 * reset
		 */
		private function onTweenComplete() : void {
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
