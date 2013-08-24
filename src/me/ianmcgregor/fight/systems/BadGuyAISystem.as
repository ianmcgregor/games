package me.ianmcgregor.fight.systems {
	import me.ianmcgregor.fight.components.PlayerComponent;
	import me.ianmcgregor.fight.assets.Assets;
	import me.ianmcgregor.fight.components.BadGuyComponent;
	import me.ianmcgregor.fight.components.CharacterComponent;
	import me.ianmcgregor.fight.components.PhysicsComponent;
	import me.ianmcgregor.fight.constants.EntityTag;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class BadGuyAISystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _badGuyMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _p1 : Entity;
		private var _p2 : Entity;
		private var _timeNow : Number = 0;

		public function BadGuyAISystem(g : GameContainer) {
			super(BadGuyComponent, []);
			_g = g;
		}
		
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_badGuyMapper = new ComponentMapper(BadGuyComponent, _world);
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
			/**
			 * badGuyComponent 
			 */
			var b: BadGuyComponent = _badGuyMapper.get(e);
			var p: PhysicsComponent = e.getComponent(PhysicsComponent);
			var c: CharacterComponent = e.getComponent(CharacterComponent);
			c.updateTime(_timeNow);
			
			if(c.isDead()) {
				if (c.deadAt < _timeNow - 0.2) {
					Audio.play(Assets.Explosion19, 0.3);
					_world.deleteEntity(e);
				}
				return;
			}
			
			if(c.isHurt) {
				if (c.hurtAt < _timeNow - 0.1) {
					c.isHurt = false;
				}
				return;
			}
			
			b;
			/**
			 * transformComponent 
			 */
			var t: TransformComponent = _transformMapper.get(e);
			
			var playerToAttack: Entity = _p1;
			var pT: TransformComponent = _p1.getComponent(TransformComponent);
			var dx : Number = t.x - pT.x;
			var dy : Number = t.y - pT.y;
			var d: Number = Math.sqrt(dx * dx + dy * dy);
			
			if(_p2) {
				var pT2: TransformComponent = _p2.getComponent(TransformComponent);
				var dx2 : Number = t.x - pT2.x;
				var dy2 : Number = t.y - pT2.y;
				var d2: Number = Math.sqrt(dx2 * dx2 + dy2 * dy2);
				if(d2 < d) {
					playerToAttack = _p2;
					pT = _p2.getComponent(TransformComponent);
					dx = dx2;
					dy = dy2;
					d = d2;
				}
			}
			
			var pC: CharacterComponent = playerToAttack.getComponent(CharacterComponent);
			var p1: PlayerComponent = playerToAttack.getComponent(PlayerComponent);
			
			c.directionH = dx < 0 ? 1 : -1; 
			if(pC.directionV != 0 && d > 80) {
				return;
			}

			if(d > 40 && d < 300) {
				c.directionH = dx < 0 ? 1 : -1; 
			} else {
				c.directionH = 0;
			}
			p.body.velocity.x = c.directionH * 190;
			
//			trace(c.directionH, p.body.velocity.x.toFixed(1));
			if(d < 100) {
				p1.opponent = e;
			}
			// attack
			if(d < 41) {
				var kick: Boolean = MathUtils.coinToss();
				// kick or punch
				c.attackRepeatGap = MathUtils.random(0.2, 0.8);
				if(kick) {
					var isKicking : Boolean = c.kick();
					if(isKicking) Audio.play(Assets.Hit_Hurt52);
				} else {
					var isPunching: Boolean = c.punch();
					if(isPunching) Audio.play(Assets.Hit_Hurt57);
				}
			}
			
//			if(c.isAttacking()) {
//				p.body.shapes.add(p.body.userData.fist);
//			} else {
//				p.body.shapes.remove(p.body.userData.fist);
//			}
		}
	}
}
