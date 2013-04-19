package {
	import me.ianmcgregor.games.base.BaseStartup;
	import me.ianmcgregor.rogue.Rogue;
	import me.ianmcgregor.rogue.assets.Assets;

	import flash.utils.getTimer;

	/**
	 * @author McFamily
	 */
//	[SWF(width="800", height="480", frameRate="60", backgroundColor="#383228")]
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#383228")]
	// species
//	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	// racer
//	[SWF(width="960", height="640", frameRate="60", backgroundColor="#383228")]
	public class Main extends BaseStartup {
		public function Main() {
//			super(Racer, 960, 640, org.alwaysinbeta.racer.assets.Assets);
//			super(Game, 800, 480, org.alwaysinbeta.template.assets.Assets);
//			super(Nanotech, 1024, 768, org.alwaysinbeta.nanotech.assets.Assets);
//			super(Species, 640, 480);
//			super(Pong, 960, 640);
			super(Rogue, 1024, 768, me.ianmcgregor.rogue.assets.Assets);

//			testA();
//			testB();
			
		}
		
		/**
		 * Quick performance tests:
		 */
		
		protected function testA(): void {
			
			
			var startTime: uint = getTimer();
//			var v: Vector.<uint> = new Vector.<uint>();
			var v: Array = [];
			while(v.length < 100000) {
				v[v.length] = v.length;
			}
			v.reverse();
//			var r : uint;
//			var l: int = 1000000;
//			for (var i : int = 0; i < l; ++i) {
				
				
//				MathUtils.min(1,0);
//				if (Math.random() > 0.5) {
//					r++;
//				}
//				
////				trace(MathUtils.randomInt(-100, 100));
//
//				var p : Number = i;
//				if(p > 0) p *= 0.001;
//				trace(Math.floor(MathUtils.interpolate(32, 64, p)));
//			}
			trace("testA excecuted in", getTimer() - startTime, "ms");
		}
		protected function testB(): void {
			var startTime: uint = getTimer();
//			var v: Vector.<uint> = new Vector.<uint>();
			var v: Array = [];
			while(v.length < 100000) {
				v.unshift( v.length );
			}
			trace("testB excecuted in", getTimer() - startTime, "ms");
		}
	}
}
