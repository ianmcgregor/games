package me.ianmcgregor.tenseconds.spatials.gfx {
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.games.utils.string.StringUtils;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	/**
	 * @author McFamily
	 */
	public class PlayerHUD extends Sprite {
		private var _atlas : TextureAtlas;
		private var _name : TextField;
		private var _health : Sprite;
		private var _score : TextField;
		/**
		 * PlayerHUD
		 */
		public function PlayerHUD(atlas : TextureAtlas, playerName : String) {
			_atlas = atlas;
			// create children
			addChild(_name = new TextField(218, 60, (playerName), Constants.FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF, false));
			_name.autoScale = true;
			addChild(_health = new Sprite());
			
			addChild(_score = new TextField(218, 30, "", Constants.FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
			_score.autoScale = true;

			var l : int = 10;
			for (var i : int = 0; i < l; ++i) {
				var h : Image = new Image(atlas.getTexture("heart"));
				_health.addChild(h);
				h.x = i * (h.width + 2);
				h.y = 3;
			}
			
			// layout
			_health.x = 0;
			_health.y = _name.y + _name.height;
			
			_score.y = _health.y + _health.height + 10;
			
			updateScore(0);
		}

		public function updateHealth(health : Number) : void {
			var l : int = _health.numChildren;
			var a : int = MathUtils.round(l * health);
			for (var i: int = 0; i < l; ++i) {
				var h: Image = _health.getChildAt(i) as Image;
				h.texture = i < a ? _atlas.getTexture("heart") : _atlas.getTexture("heart_empty");
			}
		}

		public function updateScore(score : uint) : void {
			_score.text = StringUtils.padLeft(String(score), "0", 10);
		}

		public function updateName(name : String) : void {
			if(_name.text == name) return;
			_name.text = name;
		}
	}
}
