package me.ianmcgregor.games.input {
	import flash.ui.Keyboard;

	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;

	/**
	 * @author ian
	 */
	public final class KeyInput implements IKeyInput {
		// phase
		private const UP : uint = 0;
		private const JUST_PRESSED : uint = 1;
		private const DOWN : uint = 2;
		// private const JUST_RELEASED : uint = 3;
		// maps
		private const _key : Vector.<Boolean> = new Vector.<Boolean>(256, true);
		private const _phase : Vector.<uint> = new Vector.<uint>(256, true);
		// vars
		/**
		 * _lastKey 
		 */
		private var _lastKey : uint;
		/**
		 * _numKeysDown 
		 */
		private var _numKeysDown : uint;
		/**
		 * _keyString 
		 */
		private var _keyString : String = "";

		/**
		 * KeyInput
		 * 
		 * @param eventDispatcher: starling.events.EventDispatcher
		 */
		public function KeyInput(eventDispatcher : EventDispatcher = null) {
			if (!eventDispatcher) eventDispatcher = Starling.current.stage;
			// starling.events.KeyboardEvent
			eventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			eventDispatcher.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		/*
		 * Get key state
		 */

		/**
		 * up 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		public function isUp(keyCode : uint) : Boolean {
			return !_key[keyCode];
		}
		
		/**
		 * down 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		public function isDown(keyCode : uint) : Boolean {
//			trace("KeyInput.down(",keyCode,_key[keyCode] == true,")");
			return _key[keyCode];
		}

		/**
		 * justPressed 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		public function justPressed(keyCode : uint) : Boolean {
			var b : Boolean = _phase[keyCode] == JUST_PRESSED;
			if(b) _phase[keyCode] = DOWN;
			return b;
		}

		// public function justReleased(keyCode : uint) : Boolean {
		// return _phase[keyCode] == 3;
		// }
		// public function getPhase(keyCode : uint) : uint {
		// return _phase[keyCode];
		// }
		/**
		 * any 
		 * 
		 * @return 
		 */
		public function any() : Boolean {
			return _numKeysDown > 0;
		}

		/**
		 * keyString 
		 */
		public function get keyString() : String {
			return _keyString;
		}

		/**
		 * lastKey 
		 */
		public function get lastKey() : uint {
			return _lastKey;
		}

		/**
		 * numKeysDown 
		 */
		public function get numKeysDown() : uint {
			return _numKeysDown;
		}
		
		
		/**
		 * Set key state
		 */
		public function setKeyDown(keyCode : uint) : void {
			// store last key
			_lastKey = keyCode;

			// update the keystate
			if (!_key[keyCode]) {
				_key[keyCode] = true;
				_phase[keyCode] = JUST_PRESSED;
				_numKeysDown++;
			} else {
				_phase[keyCode] = DOWN;
			}
		}

		/**
		 * keyUp 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		public function setKeyUp(keyCode : uint) : void {
			// update the keystate
			if (_key[keyCode] == true) {
				_key[keyCode] = false;
				_phase[keyCode] = UP;
				_numKeysDown--;
				// _phase[keyCode] = JUST_RELEASED;
				// To do just released will need to loop through in an onenterframe changing just released to up
			}
		}

		/**
		 * Clear / reset
		 */
		public function clear() : void {
			/**
			 * i 
			 */
			var i : int = _key.length;
			while (--i > -1) {
				_key[i] = false;
				_phase[i] = 0;
			}
			_numKeysDown = 0;
			_keyString = "";
			_lastKey = 0;
		}
		
		
		/**
		 * Syntactic sugar for player controls
		 */
		public function up(): Boolean {
			return isDown(Keyboard.UP) || isDown(Keyboard.W);
		}
		 
		/**
		 * down 
		 * 
		 * @return 
		 */
		public function down(): Boolean {
			return isDown(Keyboard.DOWN) || isDown(Keyboard.S);
		}
		 
		/**
		 * left 
		 * 
		 * @return 
		 */
		public function left(): Boolean {
			return isDown(Keyboard.LEFT) || isDown(Keyboard.A);
		}
		 
		/**
		 * right 
		 * 
		 * @return 
		 */
		public function right(): Boolean {
			return isDown(Keyboard.RIGHT) || isDown(Keyboard.D);
		}

		/**
		 * Key listeners 
		 */
		private function onKeyDown(event : KeyboardEvent) : void {
			/**
			 * keyCode 
			 */
			var keyCode : uint = event.keyCode;
			if (!keyInRange(keyCode)) return;
			
			// update the keystate
			setKeyDown(keyCode);

			// update the keystring
			updateKeyString(keyCode, event.charCode);

			// update registered IKeyListeners
			keyPressed(keyCode);
		}

		/**
		 * onKeyUp 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onKeyUp(event : KeyboardEvent) : void {
			/**
			 * keyCode 
			 */
			var keyCode : uint = event.keyCode;
			if (!keyInRange(keyCode)) return;
			
			// update the keystate
			setKeyUp(keyCode);
			
			// update registered IKeyListeners
			keyReleased(keyCode);
		}

		/**
		 * Helper methods
		 */
		private function keyInRange(keyCode : uint) : Boolean {
			return keyCode <= 255;
		}

		/**
		 * updateKeyString 
		 * 
		 * @param keyCode 
		 * @param charCode 
		 * 
		 * @return 
		 */
		private function updateKeyString(keyCode : uint, charCode : uint) : void {
			if (keyCode == Keyboard.BACKSPACE) {
				_keyString = _keyString.substring(0, _keyString.length - 1);
			} else if (charCode > 31 && keyCode != Keyboard.DELETE) {
				if (keyString.length > 100) _keyString = _keyString.substring(1);
				_keyString += String.fromCharCode(charCode);
			}
		}
		 
		/**
		 * Register keylisteners
		 */
		private var _keyListeners : Vector.<IKeyListener> = new Vector.<IKeyListener>();

		/**
		 * addKeyListener 
		 * 
		 * @param keyListener 
		 * 
		 * @return 
		 */
		public function addKeyListener(keyListener : IKeyListener) : void {
			if (_keyListeners.indexOf(keyListener) == -1)
				_keyListeners[_keyListeners.length] = keyListener;
		}

		/**
		 * keyPressed 
		 * 
		 * @param key 
		 * 
		 * @return 
		 */
		public function keyPressed(key : uint) : void {
			/**
			 * l 
			 */
			var l : int = _keyListeners.length;
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				if (_keyListeners[i].isAcceptingInput())
					_keyListeners[i].keyPressed(key, null);
			}
		}

		/**
		 * keyReleased 
		 * 
		 * @param key 
		 * 
		 * @return 
		 */
		public function keyReleased(key : uint) : void {
			/**
			 * l 
			 */
			var l : int = _keyListeners.length;
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				if (_keyListeners[i].isAcceptingInput())
					_keyListeners[i].keyReleased(key, null);
			}
		}
	}
}
