package me.ianmcgregor.tenseconds.spatials.gfx.template {
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author ianmcgregor
	 */
	public final class TextureSelectGfx extends Sprite {
		private var _textures : Vector.<Texture>;
		private var _image : Image;
		private var _textureIndex : uint;
		private var _selectedTexture : String;
		private var _names : Vector.<String>;
		/**
		 * TextureSelectGfx 
		 */

		public function TextureSelectGfx(atlas : TextureAtlas, selectedTexture : String = null) {
			super();
			_selectedTexture = selectedTexture;
			
			/**
			 * gfx 
			 */
			if(atlas) {
				_textures = atlas.getTextures();
				_names = atlas.getNames();
				if(selectedTexture) {
					_textureIndex = _names.indexOf(selectedTexture);
				}
				addChild(_image = new Image(_textures[_textureIndex]));
				addEventListener(TouchEvent.TOUCH, onTouch);
			} else {
				var gfx: Quad = new Quad(32, 32);
				gfx.color = 0xFF0000;
				addChild(gfx);
			}
			
//			pivotX = width * 0.5;
//			pivotY = height * 0.5;
			
//			flatten();
//			touchable = false;
		}
		
		public function changeTexture(texture: String) : void {
			unflatten();
			_textureIndex = _names.indexOf(texture);
			_image.texture = _textures[_textureIndex];
			flatten();
		}

		private function onTouch(event : TouchEvent) : void {
			if(event.getTouch(this)) {
				var touch: Touch = event.getTouch(this);
				if(touch.phase == TouchPhase.BEGAN) {
					_textureIndex++;
					if(_textureIndex >= _textures.length) {
						_textureIndex = 0;
					}
					_image.texture = _textures[_textureIndex];
					trace("SELECTED:", _names[_textureIndex]);
				}
			}
		}
	}
}
