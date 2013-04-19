package me.ianmcgregor.species.tilemap {
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public class Tile extends Image {
		/**
		 * _index 
		 */
		private var _index : int;

		/**
		 * Tile 
		 * 
		 * @param index 
		 * @param texture 
		 * 
		 * @return 
		 */
		public function Tile(index : int, texture : Texture) {
			super(texture);
			_index = index;
		}

		/**
		 * index 
		 */
		public function get index() : int {
			return _index;
		}
		
	}
}
