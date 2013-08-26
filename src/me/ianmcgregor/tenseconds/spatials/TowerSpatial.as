package me.ianmcgregor.tenseconds.spatials {
	import me.ianmcgregor.tenseconds.spatials.gfx.template.ParticleGfx;
	import starling.filters.BlurFilter;
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
		private var _engineGfx : ParticleGfx;
		private var _player : TextField;
		
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
			// gfx
			g.addChild(_gfx = new Sprite());
			_gfx.touchable = false;
			_gfx.addChild(_beamGfx = new Image(Texture.fromColor(1, Constants.BEAM_LENGTH, 0xFFFFAA00)));
			_beamGfx.pivotY = _beamGfx.height;
			_beamGfx.filter = BlurFilter.createGlow(0xFFFFAA00, 1, 2, 1);
			_gfx.addChild(_engineGfx = new ParticleGfx(g.assets.getXml('towerPex'), g.assets.getTexture('towerTex')));
			_engineGfx.y = -10;
			_gfx.addChild(_towerGfx = new ImageGfx(g.assets.getTexture(Constants.TEXTURE_TOWER)));
			_gfx.addChild(_selectedGfx1 = new ImageGfx(g.assets.getTexture(Constants.TEXTURE_TOWER_SELECTED_1)));
			_gfx.addChild(_selectedGfx2 = new ImageGfx(g.assets.getTexture(Constants.TEXTURE_TOWER_SELECTED_2)));
			_towerGfx.y = _selectedGfx1.y = _selectedGfx2.y = 18;
			_selectedGfx1.visible = false;
			_gfx.addChild(_timeLeft = new Bar(68, 6, 0x333333, 0xEEEEEE));
			_timeLeft.pivotX = _timeLeft.width * 0.5;
			_timeLeft.y = 46;
			_gfx.addChild(_text = new TextField(28, 10, "", Constants.FONT, -1, 0xFFFFFF));
			_text.hAlign = "left";
			_gfx.addChild(_textSecs = new TextField(42, 10, "SECONDS", Constants.FONT, -1, 0xFFFFFF));
			//_text.pivotX = _text.width * 0.5;
			_text.x = -34;
			_textSecs.x = -7;
			_text.y = _textSecs.y = _timeLeft.y + _timeLeft.height;
			_gfx.addChild(_player = new TextField(50, 10, "", Constants.FONT, -1, 0xFFFFFF));
			_player.pivotX = _player.width * 0.5;
			_player.y = _timeLeft.y - 10;
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
			var playerSelected : int = _tower.playerSelected;
			_towerGfx.visible = playerSelected == 0;
			_selectedGfx1.visible = playerSelected == 1;
			_selectedGfx2.visible = playerSelected == 2;
			
			if(!_beam.alive && _engineGfx.isEmitting) {
//				_engineGfx.numParticles --;
//				if(_engineGfx.numParticles == 0) {
					_engineGfx.stop(true);
//				}
			}
			
			if(playerSelected == 1) {
				_player.text = 'PLAYER 1';
			} else if(playerSelected == 2) {
				_player.text = 'PLAYER 2';
			} else {
				_player.text = '';
			}
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
