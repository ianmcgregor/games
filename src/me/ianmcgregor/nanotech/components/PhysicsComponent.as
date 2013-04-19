package me.ianmcgregor.nanotech.components {
	import nape.phys.Body;
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public final class PhysicsComponent extends Component {
		/**
		 * name 
		 */
		public var name : String;
		/**
		 * body 
		 */
		public var body : Body;
		/**
		 * PhysicsComponent 
		 */

		/**
		 * PhysicsComponent 
		 * 
		 * @param name 
		 * @param body 
		 * 
		 * @return 
		 */
		public function PhysicsComponent(name : String, body : Body) {
			this.name = name;
			this.body = body;
		}
		
		/**
		 * x 
		 */
		public function get x(): Number {
			return body.position.x;
		}
		
		/**
		 * y 
		 */
		public function get y(): Number {
			return body.position.y;
		}
		
		/**
		 * rotation 
		 */
		public function get rotation(): Number {
			return body.rotation;
		}
	}
}
