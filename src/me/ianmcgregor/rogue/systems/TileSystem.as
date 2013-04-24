package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.CollisionComponent;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.EntityTag;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author McFamily
	 */
	public final class TileSystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _playerMapper : ComponentMapper;

		public function TileSystem(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
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
			/**
			 * player 
			 */
//			var player: PlayerComponent = _playerMapper.get(e);
			var transform : TransformComponent = e.getComponent(TransformComponent);
			var velocity : VelocityComponent = e.getComponent(VelocityComponent);
			var collision : CollisionComponent = e.getComponent(CollisionComponent);
			
			var tile: uint = level.getTile(transform.x + collision.width * 0.5, transform.y + collision.width * 0.5);
//			trace('tile: ' + (tile));
			switch(tile){
				// exit
//				case 8:
//					_g.state = State.END_LEVEL;
//					break;
				// water
				case 117:
					velocity.dampenX(0.8);
					velocity.dampenY(0.8);
					break; 
				// lava
				default:
			}
		}
	}
}
