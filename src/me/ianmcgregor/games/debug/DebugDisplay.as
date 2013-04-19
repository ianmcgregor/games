package me.ianmcgregor.games.debug {
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	import flash.ui.Keyboard;

	/**
	 * @author ian
	 */
	public final class DebugDisplay extends Sprite {
		/**
		 * _infoText 
		 */
		private var _infoText : DriverInfoDisplay;
		/**
		 * _objectPoolMonitor 
		 */
		private var _objectPoolMonitor : ObjectPoolMonitor;
		/**
		 * _deviceInfo 
		 */
		private var _deviceInfo : DeviceInfoDisplay;
		/**
		 * _fps 
		 */
		private var _fps : FPS;
		/**
		 * _logDisplay 
		 */
		private var _logDisplay : LogDisplay;
		/**
		 * _updateList 
		 */
		private var _updateList : Vector.<IUpdateable> = new Vector.<IUpdateable>();
		/**
		 * DebugDisplay 
		 */
		public function DebugDisplay() {
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Logger.debug = this;
		}
		
		/**
		 * log 
		 * 
		 * @param value 
		 * 
		 * @return 
		 */
		public function log(value: String): void {
			_logDisplay.appendText(value);
		}
		
		/**
		 * clearLog 
		 * 
		 * @return 
		 */
		public function clearLog(): void {
			_logDisplay.text = "";
		}
		
		/**
		 * onAddedToStage 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onAddedToStage(event : Event) : void {
			event;
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addChild( _infoText = new DriverInfoDisplay() );
			addChild( _deviceInfo = new DeviceInfoDisplay() );
			addChild( _fps = new FPS() );
			addChild( _objectPoolMonitor = new ObjectPoolMonitor() );
			addChild( _logDisplay = new LogDisplay() );
			
			_objectPoolMonitor.addEventListener(Event.RESIZE, updateLayout);
			_logDisplay.addEventListener(Event.RESIZE, updateLayout);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);

			updateLayout();
		}

		/**
		 * updateLayout 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function updateLayout(event: Event = null) : void {
			event;
			var currentX : int = 0;
			var currentY : int = 0;
			var l : int = numChildren;
			for (var i : int = 0; i < l; ++i) {
				var ob : DisplayObject = getChildAt(i);
				var obHeight : int = int(ob.height + 1);
				if(currentY + obHeight > stage.stageHeight) {
					currentX += 161;
					currentY = 0;
				}
				ob.x = currentX;
				ob.y = currentY;
				currentY += obHeight;
			}
		}
		
		/**
		 * onKey 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onKey(event : KeyboardEvent) : void {
			switch(event.keyCode) {
				case Keyboard.MENU:
				case Keyboard.EQUAL:
					this.visible = !this.visible;
					break;
				default:
			}
		}

		/**
		 * addChild 
		 * 
		 * @param child 
		 * 
		 * @return 
		 */
		override public function addChild(child : DisplayObject) : DisplayObject {
			super.addChild(child);
			addToUpdateList(child);
			updateLayout();
			return child;
		}

		/**
		 * addChildAt 
		 * 
		 * @param child 
		 * @param index 
		 * 
		 * @return 
		 */
		override public function addChildAt(child : DisplayObject, index : int) : DisplayObject {
			super.addChildAt(child, index);
			addToUpdateList(child);
			updateLayout();
			return child;
		}

		/**
		 * addToUpdateList 
		 * 
		 * @param child 
		 * 
		 * @return 
		 */
		private function addToUpdateList(child : DisplayObject) : void {
			var u: IUpdateable = child as IUpdateable;
			if (u && _updateList.indexOf(u) == -1) {
				_updateList[_updateList.length] = u;
			}
		}
		
		/**
		 * update 
		 * 
		 * @return 
		 */
		public function update() : void {
			var i: int = _updateList.length;
			while(--i > -1) {
				_updateList[i].update();
			}
		}
	}
}
