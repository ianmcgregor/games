package me.ianmcgregor.games.utils.display {
	import me.ianmcgregor.games.utils.math.MathUtils;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Stage;

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * @author thomas
	 */
	public class LayoutUtils {
		
		/**
		 * removeAllChildren 
		 * 
		 * @param displayObjectContainer 
		 * 
		 * @return 
		 */
		public static function removeAllChildren(displayObjectContainer:DisplayObjectContainer):void{
			while (displayObjectContainer.numChildren){
			    displayObjectContainer.removeChildAt(0);   
			}
		}
		
		/**
		 * resize 
		 * 
		 * @param target - DisplayObject, Rectangle, etc
		 * @param areaWidth 
		 * @param areaHeight 
		 * @param autoCenter 
		 * @param fill - Fill the area (true) or fit within it (false) 
		 * 
		 * @return 
		 */
		public static function resize(target : Object, areaWidth : Number, areaHeight : Number, autoCenter : Boolean = true, fill : Boolean = true) : void {
			var targetWidth : Number = target.width;
			var targetHeight : Number = target.height;

			var scale : Number;

			if ( areaWidth > areaHeight ) {
				scale = areaWidth / targetWidth;
				var adjustHeight : Boolean = fill ? targetHeight * scale < areaHeight : targetHeight * scale > areaHeight;
				if ( adjustHeight ) {
					scale = areaHeight / targetHeight;
				}
			} else {
				scale = areaHeight / targetHeight;
				var adjustWidth : Boolean = fill ? targetWidth * scale < areaWidth : targetWidth * scale > areaWidth;
				if ( adjustWidth ) {
					scale = areaWidth / targetWidth;
				}
			}

			target.width = targetWidth * scale;
			target.height = targetHeight * scale;

			if (autoCenter) {
				target.x = (areaWidth - target.width) * 0.5;
				target.y = (areaHeight - target.height) * 0.5;
			}
		}
		
		/**
		 * setToRect 
		 * 
		 * @param target 
		 * @param rect 
		 * 
		 * @return 
		 */
		public static function setToRect(target : DisplayObject, rect: Rectangle) : void {
			target.x = rect.x;
			target.y = rect.y;
			target.width = rect.width;
			target.height = rect.height;
		}
		
		/**
		 * flipHorizontal 
		 * 
		 * @param displayObject 
		 * 
		 * @return 
		 */
		public static function flipHorizontal(displayObject:DisplayObject):void{
		   /**
		    * matrix 
		    */
		   var matrix:Matrix = displayObject.transformationMatrix;
		   matrix.a=-1;
		   matrix.tx=displayObject.width+displayObject.x;
		   displayObject.transformationMatrix=matrix;
		}
		
		/**
		 * flipVertical
		 * 
		 * @param displayObject 
		 * 
		 * @return 
		 */
		public static function flipVertical(displayObject:DisplayObject):void{
		   /**
		    * matrix 
		    */
		   var matrix:Matrix = displayObject.transformationMatrix;
		   matrix.d=-1;
		   matrix.ty=displayObject.height+displayObject.y;
		   displayObject.transformationMatrix=matrix;
		}
		
		/**
		 * roundPositions 
		 * 
		 * @param displayObjectContainer 
		 * 
		 * @return 
		 */
		public static function roundPositions(displayObjectContainer:DisplayObjectContainer):void{
		    if (!(displayObjectContainer is Stage)) {
		        displayObjectContainer.x = MathUtils.round(displayObjectContainer.x);
		        displayObjectContainer.y = MathUtils.round(displayObjectContainer.y);
		    }
			
			/**
			 * l 
			 */
			var l: uint = displayObjectContainer.numChildren;
			/**
			 * child 
			 */
			var child:DisplayObject;
		    /**
		     * i 
		     */
		    for (var i:uint = 0; i < l; i++) {
		        child = displayObjectContainer.getChildAt(i);
		        if (child is DisplayObjectContainer) {
		            roundPositions(child as DisplayObjectContainer);
		        } else {
		            child.x = MathUtils.round(child.x);
		            child.y = MathUtils.round(child.y);
		        }
		    }
		}
		
		/**
		 * positionCenterHorizontal 
		 * 
		 * @param object 
		 * @param areaWidth 
		 * @param fromX 
		 * 
		 * @return 
		 */
		public static function positionCenterHorizontal(object: DisplayObject, areaWidth: Number, fromX: Number = 0) : void {
			object.x = fromX + (areaWidth - object.width) * 0.5;
		}
		
		/**
		 * positionCenterVertical 
		 * 
		 * @param object 
		 * @param areaHeight 
		 * @param fromY 
		 * 
		 * @return 
		 */
		public static function positionCenterVertical(object: DisplayObject, areaHeight: Number, fromY: Number = 0) : void {
			object.y = fromY + (areaHeight - object.height) * 0.5;
		}
		
		/**
		 * positionCenter 
		 * 
		 * @param object 
		 * @param areaWidth 
		 * @param areaHeight 
		 * 
		 * @return 
		 */
		public static function positionCenter(object: DisplayObject, areaWidth: Number, areaHeight: Number) : void {
			object.x = (areaWidth - object.width) * 0.5;
			object.y = (areaHeight - object.height) * 0.5;
		}
		
		/**
		 * positionCenterStage 
		 * 
		 * @param object 
		 * 
		 * @return 
		 */
		public static function positionCenterStage(object: DisplayObject) : void {
			object.x = (object.stage.stageWidth - object.width) * 0.5;
			object.y = (object.stage.stageHeight - object.height) * 0.5;
		}
		
		/**
		 * positionChildrenCenterHorizontal 
		 * 
		 * @param container 
		 * @param areaWidth 
		 * 
		 * @return 
		 */
		public static function positionChildrenCenterHorizontal(container: DisplayObjectContainer, areaWidth: Number): void {
			/**
			 * l 
			 */
			var l: uint = container.numChildren;
		    /**
		     * i 
		     */
		    for (var i:uint = 0; i < l; ++i) {
				positionCenterHorizontal(container.getChildAt(i), areaWidth);
			}
		}
		
		/**
		 * positionChildrenCenterVertical
		 * 
		 * @param container 
		 * @param areaWidth 
		 * 
		 * @return 
		 */
		public static function positionChildrenCenterVertical(container: DisplayObjectContainer, areaHeight: Number): void {
			/**
			 * l 
			 */
			var l: uint = container.numChildren;
		    /**
		     * i 
		     */
		    for (var i:uint = 0; i < l; ++i) {
				positionCenterVertical(container.getChildAt(i), areaHeight);
			}
		}
		
		/**
		 * positionChildrenCenterStage 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public static function positionChildrenCenterStage(container: DisplayObjectContainer): void {
			/**
			 * l 
			 */
			var l: uint = container.numChildren;
		    /**
		     * i 
		     */
		    for (var i:uint = 0; i < l; ++i) {
				positionCenterStage(container.getChildAt(i));
			}
		}
		
		// spacing / distribution
		
		/**
		 * spaceEvenlyHorizontal 
		 * 
		 * @param objects 
		 * @param areaWidth 
		 * 
		 * @return 
		 */
		public static function spaceEvenlyHorizontal(objects: Array, areaWidth: Number): void {
			/**
			 * obj 
			 */
			var obj: DisplayObject;
			/**
			 * objectsWidth 
			 */
			var objectsWidth: Number = 0;
			/**
			 * l 
			 */
			var l: int = objects.length;
			/**
			 * i 
			 */
			for(var i: int = 0; i < l; ++i){
				obj = objects[i];
				objectsWidth += obj.width;
			}
			/**
			 * availableSpace 
			 */
			var availableSpace: Number = areaWidth - objectsWidth;
			/**
			 * objectSpace 
			 */
			var objectSpace: Number = availableSpace / ( objects.length - 1 ); 
			/**
			 * currentX 
			 */
			var currentX: Number = 0;
			
			for(i = 0; i < l; ++i){
				obj = objects[i];
				obj.x = currentX;
				currentX += obj.width + objectSpace;
			}
		}
		
		/**
		 * spaceChildrenEvenlyHorizontal 
		 * 
		 * @param container 
		 * @param areaWidth 
		 * 
		 * @return 
		 */
//		public static function spaceChildrenEvenlyHorizontal(container: DisplayObjectContainer, areaWidth: Number): void {
//			
//			/**
//			 * objects 
//			 */
//			var objects: Array = getDisplayObjectArrayFromContainer(container);
//			spaceEvenlyHorizontal(objects, areaWidth);
//		}
		
		/**
		 * spaceEvenlyVertical 
		 * 
		 * @param objects 
		 * @param areaHeight 
		 * 
		 * @return 
		 */
		public static function spaceEvenlyVertical(objects: Array, areaHeight: Number): void {
			/**
			 * obj 
			 */
			var obj : DisplayObject;
			/**
			 * objectsHeight 
			 */
			var objectsHeight: Number = 0;
			/**
			 * l 
			 */
			var l: int = objects.length;
			/**
			 * i 
			 */
			for(var i: int = 0; i < l; ++i){
				obj = objects[i];
				objectsHeight += obj.height;
			}
			/**
			 * availableSpace 
			 */
			var availableSpace: Number = areaHeight - objectsHeight;
			/**
			 * objectSpace 
			 */
			var objectSpace: Number = availableSpace / ( objects.length - 1 );
			/**
			 * currentY 
			 */
			var currentY: Number = 0;
			
			for(i = 0; i < l; ++i){
				obj = objects[i];
				obj.y = currentY;
				currentY += obj.height + objectSpace;
			}
		}
		
		/**
		 * spaceChildrenEvenlyVertical 
		 * 
		 * @param container 
		 * @param areaHeight 
		 * 
		 * @return 
		 */
//		public static function spaceChildrenEvenlyVertical(container: DisplayObjectContainer, areaHeight: Number): void {
//			/**
//			 * objects 
//			 */
//			var objects: Array = getDisplayObjectArrayFromContainer(container);
//			spaceEvenlyVertical(objects, areaHeight);
//		}
		
		/**
		 * spaceHorizontal 
		 * 
		 * @param objects 
		 * @param margin 
		 * @param fromX 
		 * 
		 * @return 
		 */
		public static function spaceHorizontal(objects: Array, margin: Number, fromX: Number = 0): void {
			/**
			 * x 
			 */
			var x: Number = fromX;
			/**
			 * obj 
			 */
			var obj : DisplayObject;
			/**
			 * l 
			 */
			var l: int = objects.length;
			/**
			 * i 
			 */
			for(var i: int = 0; i < l; ++i){
				obj = objects[i];
				obj.x = x;
				x += obj.width + margin;
			}
		}
		
		/**
		 * spaceChildrenHorizontal 
		 * 
		 * @param container 
		 * @param margin 
		 * @param fromX 
		 * 
		 * @return 
		 */
//		public static function spaceChildrenHorizontal(container: DisplayObjectContainer, margin: Number, fromX: Number = 0): void {
//			/**
//			 * objects 
//			 */
//			var objects: Array = getDisplayObjectArrayFromContainer(container);
//			spaceHorizontal(objects, margin, fromX);
//		}
		
		
		/**
		 * spaceVertical 
		 * 
		 * @param objects 
		 * @param margin 
		 * @param fromY 
		 * 
		 * @return 
		 */
		public static function spaceVertical(objects: Array, margin: Number, fromY: Number = 0): void {
			/**
			 * y 
			 */
			var y: Number = fromY;
			/**
			 * obj 
			 */
			var obj : DisplayObject;
			
			/**
			 * l 
			 */
			var l: int = objects.length;
			/**
			 * i 
			 */
			for(var i: int = 0; i < l; ++i){
				obj = objects[i];
				obj.y = y;
				y += obj.height + margin;
			}
		}
		
		/**
		 * spaceChildrenVertical 
		 * 
		 * @param container 
		 * @param margin 
		 * @param fromY 
		 * 
		 * @return 
		 */
//		public static function spaceChildrenVertical(container: DisplayObjectContainer, margin: Number, fromY: Number = 0): void {
//			/**
//			 * objects 
//			 */
//			var objects: Array = getDisplayObjectArrayFromContainer(container);
//			spaceVertical(objects, margin, fromY);
//		}
		
		/**
		 * getDisplayObjectArrayFromContainer 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
//		public static function getDisplayObjectArrayFromContainer(container: DisplayObjectContainer): Array {
//			/**
//			 * objects 
//			 */
//			var objects: Array = [];
//			/**
//			 * l 
//			 */
//			var l: int = container.numChildren;
//			/**
//			 * i 
//			 */
//			for(var i: int = 0; i < l; ++i){
//				objects[objects.length] = container.getChildAt(i);
//			}
//			return objects;
//		}
		
//		public static function getDisplayObjectVectorFromContainer(container: DisplayObjectContainer): Vector.<DisplayObject> {
//			var objects: Vector.<DisplayObject> = new Vector.<DisplayObject>();
//			var l: int = container.numChildren;
//			for(var i: int = 0; i < l; i++){
//				objects[objects.length] = container.getChildAt(i);
//			}
//			return objects;
//		}

		/**
		 *  scrollRepeating - for repeating backgrounds or carousels
		 */

		public static function scrollRepeatingX(ob1: DisplayObject, ob2: DisplayObject, delta: Number) : void {
			ob1.x += delta;
			ob2.x += delta;
			if(delta < 0) {
				if (ob1.x < 0 - ob1.width) {
					ob1.x = ob2.x + ob2.width;
				} else if (ob2.x < 0 - ob2.width) {
					ob2.x = ob1.x + ob1.width;
				}
			} else {
				if (ob1.x > 0) {
					ob2.x = ob1.x - ob2.width;
				}
				if (ob2.x > 0) {
					ob1.x = ob2.x - ob1.width;
				} 
			}
		}
		
		public static function scrollRepeatingY(ob1: DisplayObject, ob2: DisplayObject, delta: Number) : void {
			ob1.y += delta;
			ob2.y += delta;
			if(delta < 0) {
				if (ob1.y < 0 - ob1.height) {
					ob1.y = ob2.y + ob2.height;
				} else if (ob2.y < 0 - ob2.height) {
					ob2.y = ob1.y + ob1.height;
				}
			} else {
				if (ob1.y > 0) {
					ob2.y = ob1.y - ob2.height;
				}
				if (ob2.y > 0) {
					ob1.y = ob2.y - ob1.height;
				} 
			}
		}
		
		/**
		 * scrollCameraX - scroll camera to keep up with player
		 */
		public static function scrollCameraX(camera : Point, velocity : Number, position : Number, scrollAtMin : Number, scrollAtMax : Number, cameraMax : Number) : void {
			// going left, right or nowhere
			if (velocity < 0 && position < camera.x + scrollAtMin) {
				camera.x += position - camera.x - scrollAtMin;
			} else if(velocity > 0 && position > camera.x + scrollAtMax) {
				camera.x += position - camera.x - scrollAtMax;
			} else {
				return;
			}
			// clamp camera to min max
			camera.x = MathUtils.clamp(camera.x, 0, cameraMax);
		}
		
		/**
		 * scrollCameraY - scroll camera to keep up with player
		 */
		public static function scrollCameraY(camera : Point, velocity : Number, position : Number, scrollAtMin : Number, scrollAtMax : Number, cameraMax : Number) : void {
			// going up, down or nowhere
			if (velocity < 0 && position < camera.y + scrollAtMin) {
				camera.y += position - camera.y - scrollAtMin;
			} else if(velocity > 0 && position > camera.y + scrollAtMax) {
				camera.y += position - camera.y - scrollAtMax;
			} else {
				return;
			}
			// clamp camera to min max
			camera.y = MathUtils.clamp(camera.y, 0, cameraMax);
		}
	}
}
