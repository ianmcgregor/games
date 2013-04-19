package me.ianmcgregor.racer.spatials.gfx {
	import me.ianmcgregor.racer.components.TileComponent;
	import me.ianmcgregor.racer.constants.TileConstants;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;


	/**
	 * @author McFamily
	 */
	public class BuilderTileGfx extends Sprite implements ITileGfx {
		/**
		 * id 
		 */
		public var id : uint;
		/**
		 * _tile 
		 */
		private var _tile : TileComponent;
//		private var _textField : TextField;
		/**
		 * _textureAtlas 
		 */
		private var _textureAtlas : TextureAtlas;

		/**
		 * BuilderTileGfx 
		 * 
		 * @param id 
		 * @param texture 
		 * @param tile 
		 * 
		 * @return 
		 */
		public function BuilderTileGfx(id : uint, texture : Texture, tile : TileComponent, textureAtlas: TextureAtlas) {
			_textureAtlas = textureAtlas;
			_tile = tile;
			addChild(new TileGfx(id, texture));
			addArrow(tile);

//			var string : String = String(id) + "\n" + tile.type + "\n" + (tile.index);
//			var string : String = String(tile.direction);
//			addChild(_textField = new TextField(width, height, string, BitmapFont.MINI, BitmapFont.NATIVE_SIZE + 20, 0xFF0000, true));
//			_textField.y = 20;
			
//			_textField.visible = false;

			
			touchable = false;
			flatten();
		}

		/**
		 * addArrow 
		 * 
		 * @param tile 
		 * 
		 * @return 
		 */
		private function addArrow(tile : TileComponent) : void {
			/**
			 * arrowTexture 
			 */
			var arrowTexture : Texture;
			switch(tile.direction) {
				case 1:
					arrowTexture = _textureAtlas.getTexture("20_arrow_1");
					break;
				case 3:
					arrowTexture = _textureAtlas.getTexture("23_arrow_7");
					break;
				case 5:
					arrowTexture = _textureAtlas.getTexture("22_arrow_5");
					break;
				case 7:
					arrowTexture = _textureAtlas.getTexture("21_arrow_3");
					break;
				default:
			}
			if (arrowTexture) addChild(new Image(arrowTexture));
		}
		
		/**
		 * draw 
		 * 
		 * @param row 
		 * @param col 
		 * @param z 
		 * 
		 * @return 
		 */
		public function draw(row: Number, col: Number, z: Number) : void {
			x = int( translateX(row, col) );
//			y = int( translateY(row, col, z) );
			y = int( translateY(row, col) );
			
			
//			_textField.text = _textField.text + "\nx=" + x + " (" + x / TileConstants.TILE_SIZE + ")\ny=" + y + " (" + y / TileConstants.TILE_SIZE + ")";
		}
		
		/**
		 * translateX 
		 * 
		 * @param row 
		 * @param col 
		 * 
		 * @return 
		 */
		private function translateX(row: Number, col: Number): Number {
			return (col * TileConstants.TILE_SIZE) - (row * TileConstants.TILE_SIZE);
		}

		/**
		 * translateY 
		 * 
		 * @param row 
		 * @param col 
		 * 
		 * @return 
		 */
		private function translateY(row: Number, col: Number): Number {
			return (col * TileConstants.TILE_SIZE * 0.5) + (row * TileConstants.TILE_SIZE * 0.5);
		}
//		private function translateY(row: Number, col: Number, z: Number): Number {
//			return (col * TileConstants.TILE_SIZE * 0.5) + (row * TileConstants.TILE_SIZE * 0.5) - (z * TileConstants.TILE_SIZE * 0.25);
//		}
		
		/**
		 * toString 
		 * 
		 * @return 
		 */
		public function toString(): String {
			return "Tile id:" + id;
		}
	}
}
