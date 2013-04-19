package me.ianmcgregor.racer.constants {
	/**
	 * @author ianmcgregor
	 */
	public class Direction {
		public static const NONE: Number 	= 0;
		public static const NE : Number 	= 1;
		public static const NW : Number 	= 3;
		public static const SW : Number 	= 5;
		public static const SE : Number 	= 7;
		
		/**
		 * getName 
		 * 
		 * @param direction 
		 * 
		 * @return 
		 */
		public static function getName(direction: Number): String {
			/**
			 * name 
			 */
			var name: String;
			switch(direction){
				case NONE:
					name = "NONE";
					break;
				case NE:
					name = "NE";
					break;
				case NW:
					name = "NW";
					break;
				case SW:
					name = "SW";
					break;
				case SE:
					name = "SE";
					break;
				default:
					name = direction.toFixed(1);
			}
			return name;
		}
	}
}
