package me.ianmcgregor.racer.components {
	/**
	 * @author ianmcgregor
	 */
	public final class CarModel {
		public var type : String;
		public var acceleration : Number;
		public var traction : Number;
		public var texture : String;

		public function CarModel(type: String, acceleration: Number, traction: Number, texture: String) {
			this.type = type;
			this.acceleration = acceleration;
			this.traction = traction;
			this.texture = texture;
		}

	}
}
