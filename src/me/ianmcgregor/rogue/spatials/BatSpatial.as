package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.ui.Bar;
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
	public final class BatSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		private var _health : HealthComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		private var _healthBar : Bar;
		private var _tween : Tween;
		
		/**
		 * BatSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BatSpatial(world : World, owner : Entity) {
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
			
			var healthMapper : ComponentMapper = new ComponentMapper(HealthComponent, _world);
			_health = healthMapper.get(_owner);
			
//			g.addChild(_gfx = new MonsterGfx());
			var atlas: TextureAtlas;
			atlas = g.assets.getTextureAtlas(Constants.TILE_ATLAS);
			g.addChild(_gfx = new Sprite());
//			_gfx.addChild(new TextureSelectGfx(atlas, Constants.TEXTURE_BAT));
			_gfx.addChild(new Image(atlas.getTexture(Constants.TEXTURE_BAT)));
			_gfx.addChild(_healthBar  = new Bar(32, 3));
			_healthBar.y = -10;
			_healthBar.visible = false;
			
			_tween = new Tween(_gfx, 0.5, Transitions.EASE_IN);
			_tween.onComplete = onTweenComplete;
			_tween.onCompleteArgs = [g];
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
			_healthBar.setPercent(_health.getHealthPercentage());
//			Logger.log("NullSpatial.render()", 2, 3);
//			var d: Number = g.getTimeNow() - _health.getDamagedAt();
			// TODO: show bar when being damaged
//			if(!_healthBar.visible && d < 0.1){
//				_healthBar.visible = true;
//				_healthBar.alpha = 
//			}
		}

		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			g;
			if(_tween.isComplete)_tween.reset(_gfx, 0.5, Transitions.EASE_IN);
			_tween.animate("rotation", Math.PI * 0.5);
			Starling.juggler.add(_tween);
		}
		
		private function onTweenComplete(g : GameContainer) : void {
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
