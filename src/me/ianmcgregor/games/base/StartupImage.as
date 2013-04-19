package me.ianmcgregor.games.base {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * @author ianmcgregor
	 */
	public final class StartupImage extends Sprite implements IStartupImage {
		/**
		 * _image
		 */
		private var _image : Bitmap;
		/**
		 * StartupImage 
		 * 
		 * @return 
		 */
		public function StartupImage() {
		}
		
		/**
		 * init 
		 * 
		 * @param viewPort 
		 * @param isHD 
		 * 
		 * @return 
		 */
		public function init(viewPort : Rectangle): void {
			addChild(_image = new Bitmap(new BitmapData(viewPort.width, viewPort.height, false, 0xFF000000)));
		}
		
		/**
		 * remove 
		 * 
		 * @return 
		 */
		public function remove() : void {
			if(_image.bitmapData) {
				_image.bitmapData.dispose();
			}
			if(parent) {
				parent.removeChild(this);
			}
		}
	}
}
