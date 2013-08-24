package me.ianmcgregor.games.debug {
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	/**
	 * @author McFamily
	 */
	public final class LayerList extends AbstractDebugPanel implements IUpdateable {
		private const TITLE : String = "LAYER LIST:";
		private var _container : DisplayObjectContainer;

		/**
		 * LayerList 
		 */
		public function LayerList(container : DisplayObjectContainer) {
			super(TITLE);
			_container = container;
		}
		
		/**
		 * update 
		 * 
		 * @return 
		 */
		public function update() : void {
			this.text = getInfo();
		}

		/**
		 * getInfo 
		 * 
		 * @return 
		 */
		private function getInfo() : String {
			/**
			 * text 
			 */
			var text : String = TITLE;
			/**
			 * layers 
			 */
			var i: int = _container.numChildren;
			while(--i > -1) {
				var child: DisplayObject = _container.getChildAt(i);
				text += "\n";
				text += child.name != null ? child.name : String(child).split("[object ").join("").split("]").join("");
			}
			return text;
		}
	}
}
