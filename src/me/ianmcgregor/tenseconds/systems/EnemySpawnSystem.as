package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.tenseconds.components.EnemySpawnComponent;
	import me.ianmcgregor.tenseconds.factories.EntityFactory;

	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public final class EnemySpawnSystem extends IntervalEntityProcessingSystem {

		public function EnemySpawnSystem() {
			super(1, EnemySpawnComponent, []);
		}

		override protected function processEntity(e : Entity) : void {
			var t: TransformComponent = e.getComponent(TransformComponent);
			if(Math.random() > 0.9) { 
				var x : Number = t.x + ( -4 + Math.random() * 8 );
				var y : Number = t.y + ( -128 + Math.random() * 64 );
				EntityFactory.createEnemy(_world, x, y);
			}
		}

	}
}
