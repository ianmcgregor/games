package me.ianmcgregor.fight.spatials.gfx {
	import me.ianmcgregor.fight.constants.Constants;
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
		private var _player : TextField;
//		private var _playerB : TextField;
		private var _health : Sprite;
		private var _atlas : TextureAtlas;
		private var _score : TextField;
//		private var _scoreB : TextField;
		/**
		 * PlayerHUD
		 */
		public function PlayerHUD(atlas : TextureAtlas, playerName : String) {
			_atlas = atlas;
			// create children
			addChild(_player = new TextField(218, 60, (playerName), Constants.FIGHT_FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF, false));
			_player.autoScale = true;
			addChild(_health = new Sprite());
			
			addChild(_score = new TextField(218, 30, "", Constants.FIGHT_FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
			_score.autoScale = true;

			var l : int = 10;
			for (var i : int = 0; i < l; ++i) {
				var h : Image = new Image(atlas.getTexture("heart"));
//				h.scaleX = h.scaleY = 0.25;
				_health.addChild(h);
				h.x = i * (h.width + 2);
				h.y = 3;
			}
			
			
			// layout
			_health.x = 0;
			_health.y = _player.y + _player.height;
			
			_score.y = _health.y + _health.height + 10;
			
			updateScore(0);
		}

		public function updateHealth(health : Number) : void {
			// _health.setPercent(health);
			
			var l : int = _health.numChildren;
			var a : int = MathUtils.round(l * health);
			for (var i: int = 0; i < l; ++i) {
				var h: Image = _health.getChildAt(i) as Image;
				h.texture = i < a ? _atlas.getTexture("heart") : _atlas.getTexture("heart_empty");
			}
		}

		public function updateScore(score : uint) : void {
			_score.text = StringUtils.padLeft(String(score), "0", 10);
//			_scoreB.text = _score.text;
		}

		public function updateName(name : String) : void {
			if(_player.text == name) return;
			_player.text = name;
//			_playerB.text = name;
		}
		
		public function hideScore() : void {
			_score.visible = false;
		}
	}
}
