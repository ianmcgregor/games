package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.collections.ArrayUtils;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.nanotech.components.EnemyComponent;
	import me.ianmcgregor.nanotech.components.GameConfigComponent;
	import me.ianmcgregor.nanotech.components.PhysicsComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.constants.EntityTag;
	import me.ianmcgregor.nanotech.factories.EntityFactory;

	import nape.geom.Vec2;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntitySystem;
	import com.artemis.utils.IImmutableBag;

	import flash.geom.Rectangle;

	/**
	 * @author ianmcgregor
	 */
	public final class EnemySpawnSystem extends IntervalEntitySystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * _areas 
		 */
		private var _areas : Vector.<Rectangle>;

		private var _gameConfigMapper : ComponentMapper;
		/**
		 * EnemySpawnSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function EnemySpawnSystem(g : GameContainer) {
			super(2, [EnemyComponent]);
			_g = g;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_gameConfigMapper = new ComponentMapper(GameConfigComponent, _world);
//			areas:
			/**
			 * offset 
			 */
//			var offset: Number = 0 - Constants.CIRCLE_RADIUS * 2;
			var offset: Number = 100;
			/**
			 * xMax 
			 */
			var xMax: Number = _g.getWidth() - offset * 2;
			/**
			 * yMax 
			 */
			var yMax: Number = _g.getHeight() - offset * 2;
			
//			top, right, bottom, left
			_areas = new  Vector.<Rectangle>(4, true);
			_areas[0] = new Rectangle(offset, offset, xMax, 0);
			_areas[1] = new Rectangle(xMax, offset, 0, yMax);
			_areas[2] = new Rectangle(offset, yMax, xMax, 0);
			_areas[3] = new Rectangle(offset, offset, 0, yMax);
			
		}
		
		/**
		 * begin
		 */
		override protected function begin() : void {
			var config: GameConfigComponent = _gameConfigMapper.get(_world.getTagManager().getEntity(EntityTag.GAME_CONFIG));
			_interval = Constants.ENEMY_SPAWN_INTERVAL_MAX - (Constants.ENEMY_SPAWN_INTERVAL_MAX - Constants.ENEMY_SPAWN_INTERVAL_MIN) * config.getProgress();
		}
		/**
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
			
//			Logger.log("Spawn Enemy", _interval);
			
			/**
			 * entity 
			 */
			var e : Entity = EntityFactory.createEnemy(_world);
			var transform: TransformComponent = e.getComponent(TransformComponent);
			var physics: PhysicsComponent = e.getComponent(PhysicsComponent);
			
			/**
			 * area 
			 */
			var area: Rectangle = ArrayUtils.getRandomElement(_areas);
			var x : Number = MathUtils.random(area.x, area.x + area.width);
			var y : Number = MathUtils.random(area.y, area.y + area.height);

			transform.setLocation(x, y);
			e.refresh();

			/**
			 * vector to go towards
			 */
			var xPos : Number = _g.getWidth() * 0.5 - x;
    		var yPos : Number = _g.getHeight() * 0.5 - y;
			/**
			 * impulseVec 
			 */
			var impulseVec : Vec2 = Vec2.get(xPos, yPos);
			impulseVec.length = 200 * physics.body.mass;
			physics.body.applyImpulse(impulseVec);
			impulseVec.dispose();
		}

	}
}
