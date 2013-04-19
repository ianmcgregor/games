package me.ianmcgregor.rogue.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class InventoryComponent extends Component {
		/**
		 * treasure 
		 */
		public var treasure : uint;
		private const _items : Object = new Object();
		public var weapon : String;

		/**
		 * InventoryComponent 
		 * 
		 * @return 
		 */
		public function InventoryComponent() {
		}

		public function addItem(item: String) : void {
			if(!_items.hasOwnProperty(item)) {
				_items[item] = 1;
			} else {
				_items[item] ++;
			}
		}
		
		public function getItems() : Object {
			return _items;
		}

		public function hasItem(item : String) : Boolean {
			return _items.hasOwnProperty(item) && _items[item] > 0;
		}

		public function useItem(item : String) : void {
			if(hasItem(item)) {
				_items[item] --;
			}
		}
		
		public function emptyItems(): void {
			for (var i : String in _items) {
				delete _items[i];
			}
		}
	}
}
