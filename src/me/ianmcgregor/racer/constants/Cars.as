package me.ianmcgregor.racer.constants {
	import me.ianmcgregor.racer.components.CarModel;
	/**
	 * @author ianmcgregor
	 */
	public class Cars {
		public static const TYPE_RED : String = 'RED';
		public static const TYPE_BLUE : String = 'BLUE';
		public static const TYPE_GREEN : String = 'GREEN';
		
		public static var carModels: Vector.<CarModel> = Vector.<CarModel>([
			new CarModel(TYPE_RED, 0.015, 0.950, "1"), 
			new CarModel(TYPE_BLUE, 0.014, 0.955, "2"), 
			new CarModel(TYPE_GREEN, 0.016, 0.948, "3") 
			]);
	}
}
