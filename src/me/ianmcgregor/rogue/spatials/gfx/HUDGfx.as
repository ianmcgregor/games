package me.ianmcgregor.rogue.spatials.gfx {
	import me.ianmcgregor.rogue.components.InventoryComponent;

	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDGfx extends Sprite {
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
			 
//			flatten();
			touchable = false;
		}
		
		public function update(playerNum: uint, health: Number, inventory: InventoryComponent) : void {
			var p: PlayerHUD = playerNum == 1 ? _player1 : _player2;
			p.updateTreasure(inventory.treasure);
			p.updateItems(inventory.getItems());
			p.updateHealth(health);
		}
	}
}
import me.ianmcgregor.games.ui.Bar;
import me.ianmcgregor.rogue.constants.Constants;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

internal class PlayerHUD extends Sprite {
	private var _player : TextField;
	private var _health : Bar;
	private var _treasure : Item;
	private var _items : Sprite;
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
		addChild(_treasure = new Item(atlas.getTexture(Constants.TEXTURE_TREASURE)));
		addChild(_items = new Sprite()); 
		// layout
		_health.x = _player.x + _player.width;
		_health.y = 3;
		_treasure.x = _health.x + _health.width + 5;
		_items.x = _treasure.x + _treasure.width;
		
		addChildAt(_bg = new Quad(width + 64, 19), 0);
		_bg.color = 0x222222;
	}
	public function updateTreasure(count: uint): void {
		_treasure.setCount(count);
	}

	public function updateHealth(health : Number) : void {
		_health.setPercent(health);
	}

	/**
	 * updateItems
	 */
	public function updateItems(items : Object) : void {
//		_items.unflatten();
		for (var name : String in items) {
			var existing : DisplayObject = _items.getChildByName(name);
			if (existing) {
				var count: uint = items[name];
				if(count == 0) {
					// remove it as count is now zero
					_items.removeChild(existing);
					var l : int = _items.numChildren;
					for (var i : int = 0; i < l; ++i) {
						_items.getChildAt(i).x = i * existing.width;
					}
				} else {
					// update count
					Item(existing).setCount(count);
				}
			} else {
				// create a new one
				var newX: Number = _items.width;
				var newItem: DisplayObject = _items.addChild(new Item(_atlas.getTexture(name), 1));
				newItem.name = name;
				newItem.x = newX;
			}
		}
//		_items.flatten();
	}
}

internal class Item extends Sprite {
	private var _img : Image;
	private var _txt : TextField;
	public function Item(texture: Texture, initialCount: uint = 0) {
		addChild(_img = new Image(texture));
		addChild(_txt = new TextField(10, 10, "", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, false));
		_img.scaleX = _img.scaleY = 0.5;
		_txt.x = _img.x + _img.width;
		setCount(initialCount);
	}
	
	public function setCount(count: uint) : void {
		_txt.text = String(count);
	}
}