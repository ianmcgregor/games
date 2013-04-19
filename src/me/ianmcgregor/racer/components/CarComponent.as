package me.ianmcgregor.racer.components {
	import me.ianmcgregor.racer.constants.TileConstants;

	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class CarComponent extends Component {
		private const LANE_CONST : Number = 1 / TileConstants.TILE_RANGE;// 0.125; // 1/
		/**
		 * id 
		 */
		public var id : int;
		/**
		 * col 
		 */
		public var col : Number;
		/**
		 * row 
		 */
		public var row : Number;
		/**
		 * z 
		 */
		public var z : Number;
		/**
		 * isCPU 
		 */
		public var isCPU : Boolean;
		/**
		 * direction 
		 */
		public var direction : Number;
		/**
		 * lane 
		 */
		public var lane : Number;
		/**
		 * speed 
		 */
		public var speed : Number;
		/**
		 * nextLap 
		 */
		public var nextLap : int;
		/**
		 * lap 
		 */
		public var lap : int;
		/**
		 * progress 
		 */
		public var progress : Number;
		/**
		 * winTotal 
		 */
		public var winTotal : int;
		/**
		 * lives 
		 */
		public var lives : int;
		/**
		 * opponentCar 
		 */
		public var opponentCar : CarComponent;
		/**
		 * hasSwappedLane 
		 */
		public var hasSwappedLane : Boolean;
		/**
		 * targetTile 
		 */
		public var targetTile : TileComponent;
		/**
		 * zSpeed 
		 */
		public var zSpeed : Number;
		/**
		 * zAcceleration 
		 */
		public var zAcceleration : Number;
		/**
		 * isOffroad 
		 */
		public var isOffroad : Boolean;
		/**
		 * accelerateKey 
		 */
		public var accelerateKey : uint;
		/**
		 * reverseKey 
		 */
		public var reverseKey : uint;
		/**
		 * acceleration 
		 */
		public var acceleration : Number;
		/**
		 * cpuSlowAcceleration 
		 */
		public var cpuSlowAcceleration : Number;
		/**
		 * cpuAcceleration 
		 */
		public var cpuAcceleration : Number;
		/**
		 * traction 
		 */
		public var traction : Number;
		/**
		 * lapUpdated 
		 */
		public var lapUpdated : Boolean;
		/**
		 * _model 
		 */
		private var _model : CarModel;
		/**
		 * type 
		 */
		public var type : String;
		/**
		 * rotation 
		 */
		public var rotation : Number;
		/**
		 * lapTime 
		 */
		public var lapTime : Number;
		/**
		 * startTime 
		 */
		public var startTime : Number;
		/**
		 * texture 
		 */
		public var texture : String;

		/**
		 * CarComponent 
		 * 
		 * @param id 
		 * 
		 * @return 
		 */
		public function CarComponent(id: int) {
			this.id = id;
		}
		
		/**
		 * init 
		 * 
		 * @param model 
		 * 
		 * @return 
		 */
		public function init(model : CarModel) : void {
			_model = model;
			winTotal = 0;
			lives = 3;
			
			reset();
		}
		
		/**
		 * reset 
		 * 
		 * @return 
		 */
		public function reset(): void {
			isOffroad = false;
			lap = -1;
			nextLap = 0;
			speed = 0;
			zSpeed = 0;
			lapUpdated = false;
			
			lane = LANE_CONST;// * (id == 2 ? 1 : -1);
			if(id == 1) lane *= -1;
			direction = 5;
			z = 0;
			zAcceleration = 0;
			
			traction = 0.950;
			progress = 0;
			acceleration = 0.015;
			
			// copy vals from init object
			type = _model.type;
			acceleration = _model.acceleration;
			traction = _model.traction;
			texture = _model.texture;
			
			// cpu player adjustments
			cpuAcceleration = acceleration * 1.25; // 1.6
			cpuSlowAcceleration = cpuAcceleration * 0.6; // 0.7
			
			lapTime = 0;
		}

		/**
		 * toString 
		 * 
		 * @return 
		 */
		public function toString() : String {
			return "CarComponent id:" + id;
		}
	}
}
