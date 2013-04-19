package me.ianmcgregor.games.input.controls {
	import starling.events.KeyboardEvent;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * @author McFamily
	 */
	public final class Dpad extends Sprite {
		/**
		 * _rads 
		 */
		private var _rads : Number;
		/**
		 * keyCodes 
		 */
		private var _keyCodeA : uint;
		private var _keyCodeB : uint;
		private var _previousKeyCodeA : uint;
		private var _previousKeyCodeB : uint;
		/**
		 * min/max distance 
		 */
		private var _minDistance : Number = 20;
		private var _maxDistance : Number = 80;
		/**
		 * _is8Way 
		 */
		private var _is8Way : Boolean;
		/**
		 * 8 way
		 */
		private const R : Number = -0.39269908169872414;
		private const DR : Number = 0.39269908169872414;
		private const D : Number = 1.1780972450961724;
		private const DL : Number = 1.9634954084936207;
		private const L : Number = 2.748893571891069;
		private const UL : Number = -2.748893571891069;
		private const U : Number = -1.9634954084936207;
		private const UR : Number = -1.1780972450961724;
		/**
		 * 4 way
		 */
		private const RIGHT : Number = -0.7853981633974483;
		private const DOWN : Number = 0.7853981633974483;
		private const LEFT : Number = 2.356194490192345;
		private const UP : Number = -2.356194490192345;
		/**
		 * key codes
		 */
		private var _up : uint;
		private var _down : uint;
		private var _left : uint;
		private var _right : uint;

		/**
		 * Dpad 
		 * 
		 * @param up 
		 * @param down 
		 * @param left 
		 * @param right 
		 * @param is8Way 
		 * @param texture 
		 * 
		 * @return 
		 */
		public function Dpad(up : uint, down : uint, left : uint, right : uint, is8Way : Boolean = true, texture : Texture = null, color: uint = uint.MAX_VALUE, scale: Number = 1) {
			_up = up;
			_down = down;
			_left = left;
			_right = right;
			_is8Way = is8Way;

			/**
			 * image 
			 */
			if(!texture) {
				texture = new DefaultTexture(is8Way, _maxDistance, _minDistance).texture;
			}
			var image : Image = new Image(texture);
			if(color != uint.MAX_VALUE) image.color = color;
			image.scaleX = image.scaleY = scale;
			addChild(image);
			
			/**
			 * _maxDistance 
			 */
			_maxDistance = image.width * 0.5;

			/**
			 * TouchEvent 
			 */
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		/**
		 * get rotation
		 * 
		 * @return 
		 */
		public function get radians(): Number {
			return _rads;
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

			switch(touch.phase){
				case TouchPhase.BEGAN:

					break;
				case TouchPhase.MOVED:
					calculateTouches(touch.globalX, touch.globalY);
					break;
				case TouchPhase.ENDED:
					if (_keyCodeA > 0) {
						dispatchKeyUp(_keyCodeA);
					}
					if (_keyCodeB > 0) {
						dispatchKeyUp(_keyCodeB);
					}
					_keyCodeA = _keyCodeB = 0;
					break;
				default:
			} 
		}

		/**
		 * calculateTouches 
		 * 
		 * @param touchX 
		 * @param touchY 
		 * 
		 * @return 
		 */
		private function calculateTouches(touchX : Number, touchY : Number) : void {
			/**
			 * rads 
			 */
			_rads = Math.atan2(touchY - y - height * 0.5, touchX - x - width * 0.5);
			/**
			 * centerX 
			 */
			var centerX : Number = x + width * 0.5;
			/**
			 * centerY 
			 */
			var centerY : Number = y + height * 0.5;
			/**
			 * dx 
			 */
			var dx : Number = centerX - touchX;
			/**
			 * dy 
			 */
			var dy : Number = centerY - touchY;
			/**
			 * distance 
			 */
			var distance : Number = Math.sqrt(dx * dx + dy * dy);
			
			// reset key codes
			_keyCodeA = _keyCodeB = 0;

			// check within dpad active radius
			if (distance > _minDistance && distance < _maxDistance) {
				if (_is8Way) {
					getKeyCode8Way(_rads);
				} else {
					getKeyCode4Way(_rads);
				}
			}
			// dispatch key up for previous keys
			if (_previousKeyCodeA != _keyCodeA) {
				dispatchKeyUp(_previousKeyCodeA);
				_previousKeyCodeA = _keyCodeA;
			}
			if (_previousKeyCodeB != _keyCodeB) {
				dispatchKeyUp(_previousKeyCodeB);
				_previousKeyCodeB = _keyCodeB;
			}
			// dispatch key down for keys pressed
			if (_keyCodeA > 0) {
				dispatchKeyDown(_keyCodeA);
			}
			if (_keyCodeB > 0) {
				dispatchKeyDown(_keyCodeB);
			}
		}

		/**
		 * getKeyCode8Way 
		 * 
		 * @param rads 
		 * 
		 * @return 
		 */
		private function getKeyCode8Way(rads : Number) : void {
			if (rads >= R && rads < DR) {
				_keyCodeA = _right;
			} else if (rads >= D && rads < DL) {
				_keyCodeA = _down;
			} else if ((rads >= L && rads <= Math.PI) || (rads >= -Math.PI && rads < UL)) {
				_keyCodeA = _left;
			} else if (rads >= U && rads < UR) {
				_keyCodeA = _up;
			} else if (rads >= UL && rads < U) {
				_keyCodeA = _up;
				_keyCodeB = _left;
			} else if (rads >= DL && rads < L) {
				_keyCodeA = _down;
				_keyCodeB = _left;
			} else if (rads >= UR && rads < R) {
				_keyCodeA = _up;
				_keyCodeB = _right;
			} else if (rads >= DR && rads < D) {
				_keyCodeA = _down;
				_keyCodeB = _right;
			}
		}

		/**
		 * getKeyCode4Way 
		 * 
		 * @param rads 
		 * 
		 * @return 
		 */
		private function getKeyCode4Way(rads : Number) : void {
			if (rads >= RIGHT && rads < DOWN) {
				_keyCodeA = _right;
			} else if (rads >= DOWN && rads < LEFT) {
				_keyCodeA = _down;
			} else if ((rads >= LEFT && rads <= Math.PI) || (rads >= -Math.PI && rads < UP)) {
				_keyCodeA = _left;
			} else if (rads >= UP && rads < RIGHT) {
				_keyCodeA = _up;
			}
		}

		/**
		 * dispatchKeyDown 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		private function dispatchKeyDown(keyCode : uint) : void {
			dispatchEventWith(KeyboardEvent.KEY_DOWN, false, keyCode);
		}

		/**
		 * dispatchKeyUp 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		private function dispatchKeyUp(keyCode : uint) : void {
			dispatchEventWith(KeyboardEvent.KEY_UP, false, keyCode);
		}
	}
}
import starling.textures.Texture;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
/**
 * DefaultTexture 
 * 
 * @example 
 * 
 * @exampleText 
 * 
 */
internal class DefaultTexture {
	/**
	 * _texture 
	 */
	private var _texture : Texture;
	
	/**
	 * DefaultTexture 
	 * 
	 * @param is8Way 
	 * @param radius 
	 * @param centerRadius 
	 * 
	 * @return 
	 */
	public function DefaultTexture(is8Way: Boolean, radius: Number, centerRadius: Number) {
			var shape : Shape = new Shape();
			var g : Graphics = shape.graphics;
			var angle : Number;
			var arc : Number;
			var labels : Array;
			var colors : Array;
			
			if(is8Way) {
				angle = -22.5;
				arc = 45;
				labels = ["R", "DR", "D", "DL", "L", "UL", "U", "UR"];
				colors = [0x555555, 0x666666];
			} else {
				angle = -45;
				arc = 90;
				labels = ["R","D","L","U"];
				colors = [0x00FF00, 0xFF0000, 0x0000FF, 0xFFFF00];
			}
			var j : int = 0;
			for (var i : int = 0; i < labels.length; i++) {
				g.beginFill(colors[j]);
				j++;
				if (j == colors.length) {
					j = 0;
				}
				if (angle > 180) angle = angle - 360;
				drawSegment(g, radius, radius, radius, angle, angle + arc);
//				trace(labels[i], ': degrees:', angle, 'rads:', radians(angle));
				angle += arc;
			}

			if(centerRadius > 0){
				g.beginFill(0x000000, 1);
				g.drawCircle(radius, radius, centerRadius);
			}

			g.endFill();

			var bitmapData : BitmapData = new BitmapData(radius * 2, radius * 2, true, 0x00FFFFFF);
			bitmapData.draw(shape, null, null, null, null, true);
			
			_texture = Texture.fromBitmapData(bitmapData);
		}
		
		/**
		 * drawSegment 
		 * 
		 * @param graphics 
		 * @param x 
		 * @param y 
		 * @param r 
		 * @param aStart 
		 * @param aEnd 
		 * @param step 
		 * 
		 * @return 
		 */
		private function drawSegment(graphics : Graphics, x:Number, y:Number, r:Number, aStart:Number, aEnd:Number, step:Number = 1):void {
            var degreesPerRadian:Number = Math.PI / 180;
            aStart *= degreesPerRadian;
            aEnd *= degreesPerRadian;
            step *= degreesPerRadian;
 
            // Draw the segment
            graphics.moveTo(x, y);
            for (var theta:Number = aStart; theta < aEnd; theta += Math.min(step, aEnd - theta)) {
                graphics.lineTo(x + r * Math.cos(theta), y + r * Math.sin(theta));
            }
            graphics.lineTo(x + r * Math.cos(aEnd), y + r * Math.sin(aEnd));
            graphics.lineTo(x, y);
        }
		
		/**
		 * texture 
		 */
		public function get texture() : Texture {
			return _texture;
		}
}