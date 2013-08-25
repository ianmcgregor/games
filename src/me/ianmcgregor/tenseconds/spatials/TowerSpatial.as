package me.ianmcgregor.tenseconds.spatials {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.ui.Bar;
	import me.ianmcgregor.tenseconds.components.BeamComponent;
	import me.ianmcgregor.tenseconds.components.TowerComponent;
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.tenseconds.spatials.gfx.template.ImageGfx;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class TowerSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _beam : BeamComponent;
		private var _beamGfx : Image;
		private var _timeLeft: Bar;
		private var _text : TextField;
		private var _textSecs : TextField;
		private var _health : HealthComponent;
		private var _towerGfx : ImageGfx;
		private var _selectedGfx1 : ImageGfx;
		private var _tower : TowerComponent;
		private var _selectedGfx2 : ImageGfx;
		
		/**
		 * HeroSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function TowerSpatial(world : World, owner : Entity) {
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
			// components 
			_transform = _owner.getComponent(TransformComponent);
			_beam = _owner.getComponent(BeamComponent);
			_health = _owner.getComponent(HealthComponent);
			_tower = _owner.getComponent(TowerComponent);
			//
			if(!g.assets.getTexture(Constants.TEXTURE_TOWER)) {
				g.assets.addTexture(Constants.TEXTURE_TOWER, Texture.fromColor(64, 64, 0xFFFF00FF));
			}
			if(!g.assets.getTexture(Constants.TEXTURE_TOWER_SELECTED_1)) {
				g.assets.addTexture(Constants.TEXTURE_TOWER_SELECTED_1, Texture.fromColor(64, 64, 0xFFFFFF00));
			}
			if(!g.assets.getTexture(Constants.TEXTURE_TOWER_SELECTED_2)) {
				g.assets.addTexture(Constants.TEXTURE_TOWER_SELECTED_2, Texture.fromColor(64, 64, 0xFF00FFFF));
			}
			// gfx
			g.addChild(_gfx = new Sprite());
			_gfx.touchable = false;
			_gfx.addChild(_towerGfx = new ImageGfx(g.assets.getTexture(Constants.TEXTURE_TOWER)));
			_gfx.addChild(_selectedGfx1 = new ImageGfx(g.assets.getTexture(Constants.TEXTURE_TOWER_SELECTED_1)));
			_gfx.addChild(_selectedGfx2 = new ImageGfx(g.assets.getTexture(Constants.TEXTURE_TOWER_SELECTED_2)));
			_selectedGfx1.visible = false;
			_gfx.addChild(_beamGfx = new Image(Texture.fromColor(1, 1000, 0xFFFFFF00)));
			_beamGfx.pivotY = _beamGfx.height;
			_gfx.addChild(_timeLeft = new Bar(68, 8, 0x00FFFF, 0xFF00FF));
			_timeLeft.pivotX = _timeLeft.width * 0.5;
			_timeLeft.y = 34;
			_gfx.addChild(_text = new TextField(28, 10, "", Constants.FONT, -1, 0xFFFF00));
			_text.hAlign = "left";
			_gfx.addChild(_textSecs = new TextField(42, 10, "SECONDS", Constants.FONT, -1, 0xFFFF00));
			//_text.pivotX = _text.width * 0.5;
			_text.x = -34;
			_textSecs.x = -7;
			_text.y = _textSecs.y = _timeLeft.y + _timeLeft.height;
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
			_beamGfx.rotation = _transform.rotation;// + Math.PI * 0.5;
			_beamGfx.visible = _beam.getOn();
			_selectedGfx1.visible = _tower.playerSelected == 1;
			_selectedGfx2.visible = _tower.playerSelected == 2;
			update();
		}

		private function update() : void {
			_timeLeft.setPercent(_health.getHealthPercentage());
			var time : String = _health.getHealth().toFixed(2);
			if(time.length < 5) time = "0" + time;
			_text.text = time;
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
