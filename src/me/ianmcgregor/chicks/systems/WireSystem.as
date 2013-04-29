package me.ianmcgregor.chicks.systems {
	import me.ianmcgregor.chicks.components.WireComponent;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public final class WireSystem extends EntityProcessingSystem {
		private var _g : GameContainer;

		public function WireSystem(g : GameContainer) {
			_g = g;
			super(WireComponent, []);
		}

		override protected function processEntity(e : Entity) : void {
//			var p: PhysicsComponent = e.getComponent(PhysicsComponent);
			//p.body.applyImpulse(Vec2.weak(0, 1000));
//			var t: TransformComponent = e.getComponent(TransformComponent);
//			if(Math.random() > 0.4) { 
//				var x : Number = t.x + ( -4 + Math.random() * 8 );
//				var y : Number = t.y;
//				EntityFactory.createEgg(_world, x, y, 32, 32);
//			}
		}

	}
}
