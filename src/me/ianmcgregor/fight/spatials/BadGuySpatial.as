package me.ianmcgregor.fight.spatials {
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.components.BadGuyComponent;
	import me.ianmcgregor.fight.components.CharacterComponent;
	import me.ianmcgregor.fight.components.PhysicsComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class BadGuySpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : DisplayObjectContainer;
		private var _run : MovieClip;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _character : CharacterComponent;
		private var _phys : PhysicsComponent;
		private var _kick : Image;
		private var _punch : Image;
		private var _dead : Image;
		private var _tween : Tween;
		
		/**
		 * HeroSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BadGuySpatial(world : World, owner : Entity) {
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
			_character = _owner.getComponent(CharacterComponent);
			_phys = _owner.getComponent(PhysicsComponent);
			var badGuy: BadGuyComponent = _owner.getComponent(BadGuyComponent);
			
			/**
			 * gfx
			 */
			g.addChild(_gfx = new Sprite());
			
			var texturePrefix: String;
			switch(badGuy.type){
				case Constants.BAD_GUY_1:
					texturePrefix = "villain2";
					break;
				case Constants.BAD_GUY_2:
					texturePrefix = "villain3";
					break;
				case Constants.BAD_GUY_3:
					texturePrefix = "villain4";
					break;
				default:
			}
			
			var runTex : Vector.<Texture> = new Vector.<Texture>();
			runTex.push(g.assets.getTexture(texturePrefix + "_stand"), g.assets.getTexture(texturePrefix + "_run"));
			_gfx.addChild(_run = new MovieClip(runTex, 5));
			Starling.current.juggler.add(_run);
			
			_gfx.addChild(_kick = new Image(g.assets.getTexture(texturePrefix + "_kick")));
			_gfx.addChild(_punch = new Image(g.assets.getTexture(texturePrefix + "_punch")));
			_gfx.addChild(_dead = new Image(g.assets.getTexture(texturePrefix + "_punch")));
			_dead.color = 0x222222;
			
			_gfx.pivotX = 32;
			_gfx.touchable = false;
			
			_tween = new Tween(_gfx, 0.5, Transitions.EASE_OUT_BOUNCE);
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
			_gfx.x = _transform.x + _gfx.pivotX - g.camera.x;
			_gfx.y = _transform.y + _gfx.pivotY - g.camera.y;
			_gfx.rotation = _transform.rotation;
			
			_dead.visible = false;
			if(_character.isDead()) {
				_kick.visible = _punch.visible = _run.visible = false;
//				_dead.visible = (Math.round(_character.deadAt * 10) % 2 == 0);
				_dead.visible = true;
				return;
			}
			
			var h: int = _character.directionH;
			var v: int = _character.directionV;
			
			_kick.visible = _character.isKicking();
			_punch.visible = _character.isPunching();
			_run.visible = !_character.isAttacking();
			
			if(h == 0 && v == 0) {
				_run.currentFrame = 0;
				//if(_run.isPlaying) _run.pause();
			} else if(v != 0) {
				_run.currentFrame = 1;
				//if(_run.isPlaying) _run.pause();
			} else {
				_gfx.scaleX = h;
				//if(!_run.isPlaying) _run.play();
			}
			
			if(_phys.body.velocity.x == 0) {
				_run.currentFrame = 0;
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
			g;
			if(_tween.isComplete)_tween.reset(_gfx, 1, Transitions.EASE_OUT_BOUNCE);
			_tween.animate("visible", 0);
			Starling.juggler.add(_tween);
		}
		
		private function onTweenComplete(g : GameContainer) : void {
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
