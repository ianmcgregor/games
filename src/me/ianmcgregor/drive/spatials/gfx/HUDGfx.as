package me.ianmcgregor.drive.spatials.gfx {
	import me.ianmcgregor.drive.components.AvatarComponent;

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
		private var _badGuy1 : PlayerHUD;
		private var _badGuy2 : PlayerHUD;
		/**
		 * HUDGfx 
		 */
		private var _atlas : TextureAtlas;

		public function HUDGfx(w : Number, h : Number, atlas : TextureAtlas, isTwoPlayer: Boolean, avatar1: AvatarComponent, avatar2: AvatarComponent) {
			super();
			w, h;
			_atlas = atlas;
			
			addChild(_player1 = new PlayerHUD(atlas, avatar1.name)); 
			_player1.x = 15;
			_player1.y = 10;
			
			addChild(_badGuy1 = new PlayerHUD(atlas, "BAD GUY")); 
			_badGuy1.hideScore();
			_badGuy1.x = _player1.x;
			_badGuy1.y = h - _badGuy1.height - 6;
			_badGuy1.visible = false;
			
			if(isTwoPlayer) {
				addChild(_player2 = new PlayerHUD(atlas, avatar2.name)); 
				_player2.x = w - _player2.width - _player1.x;
				_player2.y = _player1.y;

				addChild(_badGuy2 = new PlayerHUD(atlas, "BAD GUY")); 
				_badGuy2.hideScore();
				_badGuy2.x = _player2.x;
				_badGuy2.y = _badGuy1.y;
				_badGuy2.visible = false;
			}
			
			
			addChild(_textField = new TextField(w, 20, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xffffff));
			_textField.y = 40;
			
//			var title : TextField;
//			addChild(title = new TextField(320, 80, Constants.TITLE_TEXT, Constants.FONT, BitmapFont.NATIVE_SIZE, 0xFFFFFF));
//			title.autoScale = true;
//			title.x = (w - title.width) * 0.5;
//			title.y = 5;
			
//			flatten();
			touchable = false;
		}
		
		public function update(playerNum: uint, health: Number, score: uint) : void {
			var p: PlayerHUD = playerNum == 1 ? _player1 : _player2;
			if(p) p.updateHealth(health);
			if(p) p.updateScore(score);
		}
		
		/**
		 * @private
		 */
		public function set text(newText : String) : void {
			if(newText == _text) return;
			_text = newText;
			unflatten();
			_textField.text = _text;
			flatten();
		}

		public function updateBadGuy(playerNum: uint, active: Boolean, name: String, health : Number) : void {
			var p: PlayerHUD = playerNum == 1 ? _badGuy1 : _badGuy2;
			if(p) {
				p.updateHealth(health);
				p.updateName(name);
				p.visible = active;
			}
		}
	}
}