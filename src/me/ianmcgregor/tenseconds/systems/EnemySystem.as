package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.tenseconds.components.EnemyComponent;
	import me.ianmcgregor.tenseconds.components.HUDComponent;
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.tenseconds.constants.EntityGroup;
	import me.ianmcgregor.tenseconds.constants.EntityTag;
	import me.ianmcgregor.tenseconds.constants.State;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author McFamily
	 */
	public final class EnemySystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _transformMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;
		private var _hud : HUDComponent;
		private var _speed : Number = 60;
		private var _maxSpeed : Number = 200;

		/**
		 * PlaySystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function EnemySystem(g: GameContainer) {
			super(EnemyComponent, null);
			_g = g;
//			_speed = _maxSpeed;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
		}
		
		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			_hud = _world.getTagManager().getEntity(EntityTag.HUD).getComponent(HUDComponent);
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var h: HealthComponent = _healthMapper.get(e);
			if (!h.isAlive()) {
				_world.deleteEntity(e);
				_hud.kills ++;
			} else {
				var t : TransformComponent = _transformMapper.get(e);
				t.y += ( _speed * t.width ) * _world.getDelta();
				
				if(t.y > 600) {
					damageTower(t.x);
					_hud.hits ++;
					_world.deleteEntity(e);
				}
			}
		}
		
		private function damageTower(x: Number) : void {
			var towers: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.TOWERS);
			var l: int = towers.size();
			for (var i : int = 0; i < l; ++i) {
				var t: Entity = towers.get(i);
				var tr : TransformComponent = t.getComponent(TransformComponent);
				if (MathUtils.abs(tr.x - x) < 128) {
					var h : HealthComponent = t.getComponent(HealthComponent);
					h.addDamage(0.1);
					break;
				}
			}
		}
		
		override protected function end() : void {
			_speed += _world.getDelta() * 0.5;
			if (_speed > _maxSpeed) _speed = _maxSpeed;
			
			if(_hud.hits + _hud.kills >= Constants.MAX_ENEMIES) {
				_g.state = State.GAME_ENDING;
			}
		}
	}
}
