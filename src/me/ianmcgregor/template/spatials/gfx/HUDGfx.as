package me.ianmcgregor.template.spatials.gfx {
	import me.ianmcgregor.template.constants.Constants;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDGfx extends Sprite {
		/**
		 * text 
		 */
		private var _text : String;
		private var _textField : TextField;
		/**
		 * players 
		 */
		private var _player1 : PlayerHUD;
		private var _player2 : PlayerHUD;
		/**
		 * HUDGfx 
		 */
		private var _atlas : TextureAtlas;

		public function HUDGfx(w : Number, h : Number, atlas : TextureAtlas, isTwoPlayer: Boolean) {
			super();
			w, h;
			_atlas = atlas;
			
			addChild(_player1 = new PlayerHUD(atlas, "PLAYER 1"));
			_player1.x = 15;
			_player1.y = 10;
			 
			if(isTwoPlayer) {
				addChild(_player2 = new PlayerHUD(atlas, "PLAYER 2")); 
				_player2.x = w - _player2.width - _player1.x;
				_player2.y = _player1.y;
			}
			
			addChild(_textField = new TextField(w, 20, "", Constants.FONT, BitmapFont.NATIVE_SIZE, 0xffffff));
			_textField.y = 40;
			 
			touchable = false;
		}
		
		/**
		 * update
		 */
		public function update(playerNum: uint, health: Number, score: uint) : void {
			var p: PlayerHUD = playerNum == 1 ? _player1 : _player2;
			if(p) p.updateHealth(health);
			if(p) p.updateScore(score);
		}
		
		/**
		 * set text
		 */
		public function set text(newText : String) : void {
			if(newText == _text) return;
			_text = newText;
			unflatten();
			_textField.text = _text;
			flatten();
		}
	}
}