package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.display.Rect;
	import me.ianmcgregor.nanotech.components.BulletComponent;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class BulletCollisionSystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _playerMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _timeNow : Number;

		public function BulletCollisionSystem(g : GameContainer) {
			super(BulletComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(VelocityComponent, _world);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_timeNow = _g.getTimeNow();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var level : LevelComponent = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
			var bT: TransformComponent = _transformMapper.get(e);
			if( level.getTile(bT.x, bT.y) == 1 ) {
				// hit a wall
				_world.deleteEntity(e);
			} else {
				var bV: VelocityComponent = _velocityMapper.get(e);
				bT.x += bV.getX(); 
				bT.y += bV.getY(); 
				testHit(EntityTag.PLAYER_1, e);
				testHit(EntityTag.PLAYER_2, e);
			}
		}

		private function testHit(player: String, bulletEntity : Entity) : void {
			var p : Entity = _world.getTagManager().getEntity(player);
			if(!p) return;
			var bulletTransform: TransformComponent = _transformMapper.get(bulletEntity);
			var pTransform : TransformComponent = _transformMapper.get(p);
			var r1 : Rect = Rect.get(bulletTransform.x, bulletTransform.y, 4, 4);
			var r2 : Rect = Rect.get(pTransform.x, pTransform.y, Constants.TILE_SIZE, Constants.TILE_SIZE);
			if ( r1.intersects(r2) && r1.getIntersectionPercent(r2) > 0.5 ) {
				// trace('collision', r1.getIntersectionArea(r2), " of ",(r1.width * r1.height), '', r1.getIntersectionPercent(r2).toFixed(2));
				var h : HealthComponent = p.getComponent(HealthComponent);
				if (h.getDamagedAt() < _timeNow - 0.2) {
					h.addDamage(Constants.BULLET_DAMAGE);
					h.setDamagedAt(_timeNow);
				}
				_world.deleteEntity(bulletEntity);
			}
			r1.dispose();
			r2.dispose();
		}
	}
}
