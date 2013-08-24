package me.ianmcgregor.drive.components {
	import com.artemis.Component;
	import com.artemis.Entity;

	/**
	 * @author ianmcgregor
	 */
	public final class BulletComponent extends Component {
		/**
		 * BulletComponent 
		 */
		public var owner : Entity;

		public function BulletComponent(owner : Entity) {
			this.owner = owner;
		}
		
		/**
		 * Object Pool
		 */
		
//		static public function get(owner : Entity) : BulletComponent {
//			var bullet: BulletComponent = ObjectPool.get(BulletComponent);
//			bullet.owner = owner;
//			return bullet;
//		}
//		
//		public function dispose(): void {
//			owner = null;
//			ObjectPool.dispose(this);
//		}
	}
}
