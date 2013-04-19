package me.ianmcgregor.racer.spatials.gfx {
	import me.ianmcgregor.racer.components.CarModel;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * @author ianmcgregor
	 */
	public final class ChooseCar extends Button {
		private var _texture : RenderTexture;
		private var _name : TextField;
		private var _car : Image;
		private var _container : Sprite;
		private var _atlas : TextureAtlas;
		private var _info : TextField;
		/**
		 * RacerButton 
		 * 
		 * @param text 
		 * 
		 * @return 
		 */

		public function ChooseCar(atlas : TextureAtlas, model : CarModel) {
			_atlas = atlas;
			_container = new Sprite();
			_container.addChild(_name = new TextField(100, 20, model.type, BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true));
			_name.scaleX = _name.scaleY = 2;
			_container.addChild(_car = new Image(getTexture(model.texture)));
			_container.addChild(_info = new TextField(100, 30, getInfoText(model), BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, false));
			
			_name.x = 0;
			_name.y = 0;
			
			_car.x = _name.x + (_name.width - _car.width) * 0.5;
			_car.y = 30;
			
			_info.x = _name.x + (_name.width - _info.width) * 0.5;
			_info.y = 50;
			
			_texture = new RenderTexture(_container.width, _container.height, true);
			_texture.draw(_container);
			
			super(_texture);
		}

		private function getInfoText(model : CarModel) : String {
			return "ACCELERATION: " + model.acceleration + "\nTRACTION:" + model.traction;
		}

		public function choose(model : CarModel) : void {
			_car.texture = getTexture(model.texture);
			_name.text = model.type;
			_info.text = getInfoText(model);
			_texture.clear();
			_texture.draw(_container);
		}

		private function getTexture(texture : String) : Texture {
			trace('_atlas.getTexture("car' + texture + '_2"): ' + (_atlas.getTexture("car" + texture + "_2")));
			return _atlas.getTexture("car" + texture + "_2");
		}
	}
}
