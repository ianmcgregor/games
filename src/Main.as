package {
	import me.ianmcgregor.games.base.BaseStartup;
	import me.ianmcgregor.tenseconds.TenSeconds;
	import me.ianmcgregor.tenseconds.assets.Assets;

	import flash.utils.getTimer;

	/**
	 * @author McFamily
	 */
//	[SWF(width="800", height="480", frameRate="60", backgroundColor="#383228")]
//	[SWF(width="1024", height="640", frameRate="60", backgroundColor="#383228")]
	// species
//	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	// racer
	[SWF(width="1024", height="640", frameRate="60", backgroundColor="#000000")]
	public class Main extends BaseStartup {
		public function Main() {
//			super(Racer, 960, 640, me.ianmcgregor.racer.assets.Assets);
//			super(Game, 960, 640, me.ianmcgregor.template.assets.Assets);
//			super(Nanotech, 1024, 768, me.ianmcgregor.nanotech.assets.Assets);
//			super(Species, 640, 480);
//			super(Pong, 960, 640);
//			super(Rogue, 1024, 768, me.ianmcgregor.rogue.assets.Assets);
//			super(Chicks, 1024, 640, me.ianmcgregor.chicks.assets.Assets);
//			super(Fight, 1024, 640, me.ianmcgregor.fight.assets.Assets);
//			super(Drive, 640, 480, me.ianmcgregor.drive.assets.Assets);
			super(TenSeconds, 960, 640, me.ianmcgregor.tenseconds.assets.Assets);

//			testA();
//			testB();
			
		}
		
		/**
		 * Quick performance tests:
		 */
		
		protected function testA(): void {
			
//			var startTime: uint = getTimer();
////			var v: Vector.<uint> = new Vector.<uint>();
//			var v: Array = [];
//			while(v.length < 100000) {
//				v[v.length] = v.length;
//			}
//			v.reverse();
//			var r : uint;
//			var l: int = 1000000;
//			for (var i : int = 0; i < l; ++i) {
//				trace(MathUtils.randomInt(0,2));
				
				
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
//			trace("testA excecuted in", getTimer() - startTime, "ms");
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
