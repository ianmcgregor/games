package me.ianmcgregor.games.base {
	import starling.events.Event;
	import me.ianmcgregor.games.utils.app.AirApp;
	import me.ianmcgregor.games.utils.app.Environment;
	import me.ianmcgregor.games.utils.display.LayoutUtils;

	import starling.core.Starling;
	import starling.utils.AssetManager;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;

	/**
	 * BaseStartup 
	 * 
	 * @example 
	 * 
	 * @exampleText 
	 * 
	 */
	public class BaseStartup extends Sprite {
		/**
		 * _starling 
		 */
		protected var _starling : Starling;
		/**
		 * _startupImage 
		 */
		private var _startupImage : IStartupImage;
		/**
		 * _game 
		 */
		private var _game : BaseGame;
		
		/**
		 * _assetsClass 
		 */
		private var _assetsClass : Class;

		/**
		 * BaseStartup 
		 * 
		 * @param rootClass 
		 * @param width 
		 * @param height 
		 * 
		 * @return 
		 */
		public function BaseStartup(rootClass : Class, width : uint, height : uint, assetsClass: Class = null, startupImage: IStartupImage = null) {
			// set stage properties
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
			// disable right-click
			stage.addEventListener("rightClick", onRightClick);
			
			// useful on mobile devices
			Starling.multitouchEnabled = Environment.isMobile;
			// required on Android, should be false for iOS
			Starling.handleLostContext = Environment.isAndroid || Environment.isWindows;
			
			// TODO: seems like possible screen width/height could be wrongly reported - maybe need to delay?

			// create a suitable viewport for the screen size
			
//			var viewPort : Rectangle = RectangleUtil.fit(new Rectangle(0, 0, width, height), new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), ScaleMode.SHOW_ALL, true);
			
			/**
			 * viewPort 
			 */
			var viewPort : Rectangle = new Rectangle(0,0,width,height);
			if (Environment.isMobile) {
				
				/**
				 * screenWidth 
				 */
				var screenWidth : int = stage.fullScreenWidth;
				/**
				 * screenHeight 
				 */
				var screenHeight : int = stage.fullScreenHeight;

				LayoutUtils.resize(viewPort, screenWidth, screenHeight, true, false);
			}
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering,
			// we display a startup image for now, but will remove it when Starling is ready to go.
			//
			// (Note that we *cannot* embed the "Default*.png" images, because then they won't
			// be copied into the package any longer once they are embedded.)

			if(!startupImage)_startupImage = new StartupImage();
			_startupImage.init(viewPort);
			addChild(_startupImage as flash.display.DisplayObject);
			
			// Ref to assetsClass
			_assetsClass = assetsClass;

			// Set up Starling
			_starling = new Starling(( rootClass || BaseGame ) as Class, stage, viewPort);//, null, "auto", "baseline");
//			_starling.stage.stageWidth  = width;  // <- same size on all devices!
//            _starling.stage.stageHeight = height; // <- same size on all devices!
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = false;
			_starling.showStats = false;
			_starling.antiAliasing = 1;

			// Wait for Starling to initialize
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreate);
		}

		/**
		 * onRootCreate 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onRootCreate(event : starling.events.Event) : void {
			// Starling is ready! 
			event;
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreate);
			
			if (Environment.isMobile) {
				// if we're on mobie keep screen awake
				AirApp.keepAwake(true);
				// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
				// would report a very long 'passedTime' when the app is reactivated.
				AirApp.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
			_game = _starling.root as BaseGame;
			
			// create the AssetManager
            if(_assetsClass) {
				/**
				 * assets 
				 */
				var assets:AssetManager = _game.gameContainer.assets;
            	assets.verbose = Capabilities.isDebugger;
				assets.enqueue(_assetsClass);
				assets.loadQueue(onAssetsLoad);
			} else {
				start();
			}
//
//            var appDir:File = File.applicationDirectory;
//            assets.enqueue(
//                appDir.resolvePath("audio"),
//                appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
//                appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
//            );
		}

		/**
		 * onAssetsLoad 
		 * 
		 * @param ratio 
		 * 
		 * @return 
		 */
		private function onAssetsLoad(ratio : Number) : void {
			if (ratio == 1.0) {
				start();
			}
		}
		
		/**
		 * start 
		 * 
		 * @return 
		 */
		private function start(): void {
			// remove the startup image
			_startupImage.remove();
			_startupImage = null;
			
			// start starling and activate game instance
			_starling.start();
			_game.start();
			
			// add deactivate listener for air
			AirApp.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
		}

		/**
		 * onActivate 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onActivate(event : flash.events.Event) : void {
			AirApp.removeEventListener(flash.events.Event.ACTIVATE, onActivate);
			AirApp.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
			
			_starling.start();
			_game.start();
		}

		/**
		 * onDeactivate 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onDeactivate(event : flash.events.Event) : void {
			AirApp.removeEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
			AirApp.addEventListener(flash.events.Event.ACTIVATE, onActivate);
			
			_starling.stop();
			_game.stop();
		}
		
		/**
		 * onRightClick 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onRightClick(event : MouseEvent) : void {
			event;
		}

		/**
		 * onKeyDown 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onKeyDown(event : KeyboardEvent) : void {
			switch(event.keyCode){
				case Keyboard.BACK:
					event.preventDefault();
					AirApp.exit();
					break;
				case Keyboard.MENU:
					event.preventDefault();
					_game.toggleMenu();
					break;
				case Keyboard.HOME:
					
					break;
				default:
			}
		}
	}
}