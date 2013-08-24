package me.ianmcgregor.chick.systems {
	import me.ianmcgregor.chick.components.DropperComponent;
	import me.ianmcgregor.chick.factories.EntityFactory;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public final class EggDropperSystem extends IntervalEntityProcessingSystem {
		private var _g : GameContainer;

		public function EggDropperSystem(g : GameContainer) {
			_g = g;
			super(1, DropperComponent, []);
		}

		override protected function processEntity(e : Entity) : void {
			var t: TransformComponent = e.getComponent(TransformComponent);
			if(Math.random() > 0.6) { 
				var x : Number = t.x + ( -4 + Math.random() * 8 );
				var y : Number = t.y + ( -128 + Math.random() * 64 );
				EntityFactory.createEgg(_world, x, y, 32, 32);
			}
		}

	}
}
