package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.components.CharacterComponent;
	import me.ianmcgregor.drive.components.EnemyComponent;
	import me.ianmcgregor.drive.components.GameConfigComponent;
	import me.ianmcgregor.drive.components.PhysicsComponent;
	import me.ianmcgregor.drive.constants.EntityTag;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.games.utils.nape.NapeUtils;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class EnemyAISystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _enemyMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _p1 : Entity;
		private var _p2 : Entity;
		private var _timeNow : Number = 0;
		private var _level : OgmoLevel;

		public function EnemyAISystem(g : GameContainer) {
			super(EnemyComponent, []);
			_g = g;
		}
		
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_enemyMapper = new ComponentMapper(EnemyComponent, _world);
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
			var c: CharacterComponent = e.getComponent(CharacterComponent);
			c.attackType = MathUtils.randomInt(0,2);
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			// level
			var gameConfig : GameConfigComponent = _world.getTagManager().getEntity(EntityTag.GAME_CONFIG).getComponent(GameConfigComponent);
			_level = gameConfig.level;
			_p1 = _world.getTagManager().getEntity(EntityTag.PLAYER_1);
			_p2 = _world.getTagManager().getEntity(EntityTag.PLAYER_2);
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
			var h: HealthComponent = e.getComponent(HealthComponent);
			if(!h.isAlive()) return;
			
			var c: CharacterComponent = e.getComponent(CharacterComponent);
			c.updateTime(_timeNow);
			if(c.getHurt()) return;
			
			var p: PhysicsComponent = e.getComponent(PhysicsComponent);
//			var enemy: EnemyComponent = e.getComponent(EnemyComponent);
			
			// find nearest player to attack
			
			var t: TransformComponent = _transformMapper.get(e);
			
			var playerToAttack: Entity = _p1;
			var pT: TransformComponent = _p1.getComponent(TransformComponent);
			var dx : Number = pT.x - t.x;
			var dy : Number = pT.y - t.y;
			var d: Number = Math.sqrt(dx * dx + dy * dy);
			
			if(_p2) {
				var pT2: TransformComponent = _p2.getComponent(TransformComponent);
				var dx2 : Number = pT2.x - t.x;
				var dy2 : Number = pT2.y - t.y;
				var d2: Number = Math.sqrt(dx2 * dx2 + dy2 * dy2);
				if(d2 < d) {
					playerToAttack = _p2;
					pT = _p2.getComponent(TransformComponent);
					dx = dx2;
					dy = dy2;
					d = d2;
				}
			}
			
			/**
			 * TODO: enemy isAttacking or not - could be getting out of tree etc
			 * 
			 * return if isDestroyed
			 */
			
			switch(c.attackType){
				case CharacterComponent.ATTACK_TYPE_REAR:
					break;
				case CharacterComponent.ATTACK_TYPE_LEFT:
					dx -= 65;
					break;
				case CharacterComponent.ATTACK_TYPE_RIGHT:
					dx += 65;
					break;
				default:
			}
			
			var up: Boolean = d > 0;
			
			var angle: Number = Math.atan2(dy, dx);
			angle = MathUtils.rotateToRAD(p.body.rotation, angle);
			angle = MathUtils.lerp(p.body.rotation, angle, 0.15);
			p.body.rotation = angle;
			
			var maxVelocity : Number = 50;
			var impulse : Number = 18;
			
			if (d < 500) NapeUtils.move(p.body, _world.getDelta(), false, false, up, false, 0, 0, maxVelocity, impulse);
			
			// clamp X & Y
			var minX: Number = 32;
			var maxX: Number = _level.width - 32;
			var minY: Number = 32;
			var maxY: Number = _level.height - 32;
			NapeUtils.clampPosition(p.body, minX, maxX, minY, maxY);
		}
	}
}
