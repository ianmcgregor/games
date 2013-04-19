package me.ianmcgregor.games.input.controls {
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * @author ianmcgregor
	 */
	public class KeyButton extends Button {
		/**
		 * _keyCode
		 */
		private var _keyCode : uint;
		private var _up : Texture;

		public function KeyButton(keyCode : uint, upState : Texture, downState : Texture = null) {
			super(upState, "", downState);
			_keyCode = keyCode;
			_up = upState;
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		/**
		 * onTouch 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTouch(event : TouchEvent) : void {
			/**
			 * touch 
			 */
			var touch: Touch = event.getTouch(this);
			if(!touch) return;

			/**
			 * key 
			 */
			switch(touch.phase){
				case TouchPhase.BEGAN:
					dispatchEventWith(KeyboardEvent.KEY_DOWN, false, _keyCode);
					break;
				case TouchPhase.ENDED:
					dispatchEventWith(KeyboardEvent.KEY_UP, false, _keyCode);
					break;
				default:
			}
		}

		override public function dispatchEventWith(type : String, bubbles : Boolean = false, data : Object = null) : void {
			if(type == Event.TRIGGERED) data = _keyCode;
			super.dispatchEventWith(type, bubbles, data);
		}

		public function get keyCode() : uint {
			return _keyCode;
		}

		public function setDown(isDown : Boolean) : void {
			if(isDown) {
				upState = downState;
			} else {
				upState = _up;
			}
		}
	}
}
