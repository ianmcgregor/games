package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.tenseconds.components.EnemySpawnComponent;
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.tenseconds.factories.EntityFactory;

	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public final class EnemySpawnSystem extends IntervalEntityProcessingSystem {
		private var _g : GameContainer;
		private var _count : int;
		private var _minInterval : Number = 1;
		private var _margin : Number = 40;
		private var _spawn : Number = 2;
		private var _maxSpawn : Number = 8;

		public function EnemySpawnSystem(g : GameContainer) {
			super(2, EnemySpawnComponent, null);
			_g = g;
			
//			_spawn = _maxSpawn; _interval = _minInterval;
		}

		override protected function processEntity(e : Entity) : void {
			e;
			var i: int = 1 + int( Math.random() * _spawn );
			while(--i > -1) {
				if(_count < Constants.MAX_ENEMIES) {
					var x : Number = _margin + ( _g.getWidth() - _margin * 2 ) * Math.random();
					EntityFactory.createEnemy(_world, x, -64);
					_count ++;
				}
			}
		}
		
		override protected function end() : void {
			_interval -= _world.getDelta() * 0.2;
			if (_interval < _minInterval) _interval = _minInterval;
//			trace('_interval: ' + (_interval));
			_spawn += _world.getDelta() * 0.5;
			if (_spawn > _maxSpawn) _spawn = _maxSpawn;
//			trace('_spawn: ' + (_spawn));
		}

	}
}
