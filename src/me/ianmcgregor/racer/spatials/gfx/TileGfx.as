package me.ianmcgregor.racer.spatials.gfx {
	import me.ianmcgregor.racer.constants.TileConstants;

	import starling.display.Image;
	import starling.textures.Texture;


	/**
	 * @author McFamily
	 */
	public class TileGfx extends Image implements ITileGfx {
		/**
		 * id 
		 */
		public var id : uint;

		/**
		 * TileGfx 
		 * 
		 * @param id 
		 * @param texture 
		 * 
		 * @return 
		 */
		public function TileGfx(id : uint, texture : Texture) {
			super(texture);
			this.id = id;
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
			x = translateX(row, col);
			y = translateY(row, col, z);
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
		 * @param z 
		 * 
		 * @return 
		 */
		private function translateY(row: Number, col: Number, z: Number): Number {
			return (col * TileConstants.TILE_SIZE * 0.5) + (row * TileConstants.TILE_SIZE * 0.5) - (z * TileConstants.TILE_SIZE * 0.25);
		}
		
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
