package me.ianmcgregor.drive.spatials.gfx {
	import me.ianmcgregor.drive.components.AvatarComponent;
	import me.ianmcgregor.drive.constants.AvatarList;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	/**
	 * @author ianmcgregor
	 */
	public class SelectCharacter extends Sprite {
		private var _atlas : TextureAtlas;
		private var _index : uint;
		private var _image : Image;
		private var _name : TextField;
		private var _title : TextField;
		private var _playerNum : uint;

		public function SelectCharacter(atlas : TextureAtlas, playerNum : uint) {
			super();

			_atlas = atlas;
			_playerNum = playerNum;
			_index = AvatarList.HERO[_playerNum];

			display();

			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(event : TouchEvent) : void {
			Mouse.cursor = (event.interactsWith(this)) ? MouseCursor.BUTTON : MouseCursor.AUTO;

			var touch : Touch = event.getTouch(this);
			if (touch && touch.phase == TouchPhase.BEGAN) {
				_index++;
				if (_index > AvatarList.HEROES.length - 1) _index = 0;
				display();
			}
		}

		public function getSelected() : uint {
			return _index;
		}

		private function display() : void {
			var character : AvatarComponent = AvatarList.HEROES[_index];
//			var texture : Texture = _atlas.getTexture(character.texturePrefix + "_stand");
			var texture : Texture = _atlas.getTexture("car");
			if (!_image) {
				addChild(_image = new Image(texture));
				addChild(_title = new TextField(_image.width, 20, "SELECT CHARACTER:", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
				addChild(_name = new TextField(_image.width, 20, character.name, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
				_image.y = _title.height + 2;
				_name.y = _image.y + _image.height;
			} else {
				_image.texture = texture;
				_name.text = character.name;
			}
			AvatarList.HERO[_playerNum] = _index;
		}
	}
}
