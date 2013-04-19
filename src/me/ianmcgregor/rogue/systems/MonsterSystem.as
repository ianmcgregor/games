package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.astar.Node;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.rogue.components.MonsterComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class MonsterSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _monsterMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		/**
		 * _timeNow
		 */
		private var _timeNow : Number;
		private var _p1 : Entity;
		private var _p2 : Entity;

		/**
		 * MonsterSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function MonsterSystem(g : GameContainer) {
			super(MonsterComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_monsterMapper = new ComponentMapper(MonsterComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_timeNow = _g.getTimeNow();
			_p1 = _world.getTagManager().getEntity(EntityTag.PLAYER_1);
			_p2 = _world.getTagManager().getEntity(EntityTag.PLAYER_2);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * components
			 */
			var monster: MonsterComponent = _monsterMapper.get(e);
			var transform: TransformComponent = _transformMapper.get(e);
			var velocity: VelocityComponent = e.getComponent(VelocityComponent);
			
			if(monster.getPath() && monster.pathIndex < monster.getPath().length) {
				var node: Node = monster.getPath()[monster.pathIndex] as Node;
				var targetX: Number = node.x * Constants.TILE_SIZE;
				var targetY: Number = node.y * Constants.TILE_SIZE;
				var dx: Number = targetX - transform.x; 
				var dy: Number = targetY - transform.y;
				if(isNaN(monster.stepX)) {
					monster.stepX = dx * 0.05;
					monster.stepY = dy * 0.05;
				}
				var dist: Number = Math.sqrt(dx * dx + dy * dy);
				if(dist < 0.2) {
					monster.pathIndex++;
					monster.stepX = NaN;
				} else {
					velocity.setX(monster.stepX);
					velocity.setY(monster.stepY);
				}
			}
			checkAttackedByPlayer(_p1, e);
			checkAttackedByPlayer(_p2, e);
		}

		private function checkAttackedByPlayer(p : Entity, m: Entity) : void {
			if(!p) return;
			var player: PlayerComponent = p.getComponent(PlayerComponent);
			if (player.attack == Constants.ATTACK_PROGRESS) {
				var mTransform : TransformComponent = m.getComponent(TransformComponent);
				var pTransform : TransformComponent = p.getComponent(TransformComponent);
				var dist : Number = MathUtils.distance(pTransform.x + Constants.TILE_SIZE * 0.5, pTransform.y + Constants.TILE_SIZE * 0.5, mTransform.x + Constants.TILE_SIZE * 0.5, mTransform.y + Constants.TILE_SIZE * 0.5);
				if (dist < Constants.TILE_SIZE * 1.5) {
					var mHealth : HealthComponent = m.getComponent(HealthComponent);
					mHealth.addDamage(Constants.MONSTER_HIT_DAMAGE);
					EntityFactory.createSpatter(_world, mTransform.x + Constants.TILE_SIZE * 0.5, mTransform.y + Constants.TILE_SIZE * 0.5);
	
					if (!mHealth.isAlive()) {
						EntityFactory.createMessage(_world, Constants.MESSAGE_KILLED_MONSTER, Constants.DEFAULT_MESSAGE_LIFETIME, pTransform);
						_world.deleteEntity(m);
					} else {
						EntityFactory.createMessage(_world, Constants.MESSAGE_HIT_MONSTER, Constants.DEFAULT_MESSAGE_LIFETIME, mTransform);
					}
				}
			}
		}
		
		/**
		 * getPlayerDistance
		 * 
		 * @param player
		 * @param x
		 * @param y
		 * 
		 * @return Number
		 */
		
//		private function getPlayerDistance(player: Entity, x : Number, y : Number) : Number {
//			if(!player) return NaN;
//			var t: TransformComponent = player.getComponent(TransformComponent);
//			return MathUtils.distance(x, y, t.x, t.y);
//		}
		
		/**
		 * shoot
		 * 
		 * @param player
		 * @param x
		 * @param y
		 * 
		 * @return Number
		 */
		
//		private function shoot(player: Entity, x : Number, y : Number) : void {
//			if(!player) return;
//			var t: TransformComponent = player.getComponent(TransformComponent);
//			//Point.polar(len, angle)
//			EntityFactory.createMonsterBullet(_world, x, y, (t.x - x) * 0.2, (t.y - y) * 0.2);
//		}
	}
}
