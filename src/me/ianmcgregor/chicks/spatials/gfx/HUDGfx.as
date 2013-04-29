package me.ianmcgregor.chicks.spatials.gfx {
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
			
			addChild(_player1 = new PlayerHUD(atlas, 1)); 
			if(isTwoPlayer) {
				addChild(_player2 = new PlayerHUD(atlas, 2)); 
				_player1.x = w * 0.5 - _player1.width - 100;
				_player2.x = w * 0.5 + 100;
			} else {
				_player1.x = ( w - _player1.width ) * 0.5;
			}
			addChild(_textField = new TextField(w, 20, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xffffff));
			_textField.y = 40;
			 
//			flatten();
			touchable = false;
		}
		
		public function update(playerNum: uint, health: Number) : void {
			var p: PlayerHUD = playerNum == 1 ? _player1 : _player2;
			p.updateHealth(health);
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
	}
}
import me.ianmcgregor.games.ui.Bar;

import starling.display.Quad;
import starling.display.Sprite;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.TextureAtlas;

internal class PlayerHUD extends Sprite {
	private var _player : TextField;
	private var _health : Bar;
	private var _atlas : TextureAtlas;
	private var _bg : Quad;
	
	/**
	 * PlayerHUD
	 */
	
	public function PlayerHUD(atlas : TextureAtlas, playerNum : uint) {
		_atlas = atlas;
		// create children
		addChild(_player = new TextField(50, 8, "PLAYER " + String(playerNum), BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, false));
		_player.scaleX = _player.scaleY = 2;
		addChild(_health = new Bar());
		// layout
		_health.x = _player.x + _player.width;
		_health.y = 3;
		
		addChildAt(_bg = new Quad(width + 64, 19), 0);
		_bg.color = 0x222222;
	}

	public function updateHealth(health : Number) : void {
		_health.setPercent(health);
	}
}