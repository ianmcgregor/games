package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.components.FriendComponent;
	import me.ianmcgregor.nanotech.components.HUDComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.constants.EntityTag;
	import me.ianmcgregor.nanotech.constants.State;

	import nape.geom.Vec2;
	import nape.phys.Body;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author ianmcgregor
	 */
	public final class FriendSystem extends EntityProcessingSystem {
		/**
		 * mappers 
		 */
		private var _friendMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _physicsMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;
		private var _g : GameContainer;
		private var _totalHealth : Number;

		public function FriendSystem(g : GameContainer) {
			super(FriendComponent, []);
			_g = g;
		}

		override public function initialize() : void {
			_friendMapper = new ComponentMapper(FriendComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_physicsMapper = new ComponentMapper(PhysicsComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
		}
		
		
		override protected function added(e : Entity) : void {
			super.added(e);
			
		}
		
		override protected function processEntities(entities : IImmutableBag) : void {
			if(entities.isEmpty()) {
				_g.state = State.GAME_END;
				return;
			}
			super.processEntities(entities);
		}

		override protected function begin() : void {
			_totalHealth = 0;
		}
		
		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var health: HealthComponent = _healthMapper.get(e);
			var transform: TransformComponent = _transformMapper.get(e);
			var physics: PhysicsComponent = _physicsMapper.get(e);
			
			_totalHealth += health.getHealthPercentage();
			
			var body: Body = physics.body;
			
			/**
			 * vector to go towards
			 */
			var dx : Number = transform.x - body.position.x;
    		var dy : Number = transform.y - body.position.y;
			
			if(Math.sqrt(dx * dx + dy * dy) > 60) {
				/**
				 * impulseVec 
				 */
				var impulseVec : Vec2 = Vec2.get(dx, dy);
				impulseVec.length = body.mass * 20;
				physics.body.applyImpulse(impulseVec);
				impulseVec.dispose();
			}
			
		}

		override protected function end() : void {
			var hud: HUDComponent = _world.getTagManager().getEntity(EntityTag.HUD).getComponent(HUDComponent);
			hud.friendsHealth = _totalHealth;			
		}

	}
}
