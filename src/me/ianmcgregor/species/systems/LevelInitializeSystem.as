package me.ianmcgregor.species.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.species.components.Level;
	import me.ianmcgregor.species.constants.EntityGroup;
	import me.ianmcgregor.species.constants.EntityTag;
	import me.ianmcgregor.species.factories.EntityFactory;
	import me.ianmcgregor.species.factories.SoundFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author McFamily
	 */
	public class LevelInitializeSystem extends EntityProcessingSystem {
		/**
		 * _processLevel 
		 */
		private var _processLevel : Boolean;
		/**
		 * _levelMapper 
		 */
		private var _levelMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * _heroRect 
		 */
		private var _heroRect : Rectangle;
		/**
		 * LevelInitializeSystem 
		 */
		public function LevelInitializeSystem() {
			super(Level, []);
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_levelMapper = new ComponentMapper(Level, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_processLevel = true;
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
			 * level 
			 */
			var level: Level = _levelMapper.get(e);
			
			/**
			 * hero 
			 */
			var hero : Entity = _world.getTagManager().getEntity(EntityTag.HERO);
			/**
			 * heroTransfrom 
			 */
			var heroTransfrom: TransformComponent = _transformMapper.get(hero);
			
			// check if reached level exit
			if(!_heroRect) _heroRect = new Rectangle(0,0,32,32);
			 _heroRect.x = heroTransfrom.x;
			 _heroRect.y = heroTransfrom.y;
			if(level.exit && level.exit.intersects(_heroRect)){
				var num: int = level.num + 1;
				_world.getEntityManager().remove(e);
				e = EntityFactory.createLevel(_world, num);
				_processLevel = true;
				level = _levelMapper.get(e);
			}
			
			// set up level
			
			if(_processLevel) {
				//level.parseOgmo( Assets.getLevel(level.num) );
				
				clear();
				
				heroTransfrom.x = level.hero.x;
				heroTransfrom.y = level.hero.y;
				
				var entity : Entity;
				var i : int;
				var l: int;
				
				var enemies: Vector.<Point> = level.enemies;
				l = enemies.length;
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createWeaponisedEnemy(_world);
					TransformComponent(entity.getComponent(TransformComponent)).setLocation(enemies[i].x, enemies[i].y);
					entity.refresh();
				}
	
				var moustacheEnemies: Vector.<Point> = level.moustacheEnemies;
				l = moustacheEnemies.length;
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createMoustachedEnemy(_world);
					TransformComponent(entity.getComponent(TransformComponent)).setLocation(moustacheEnemies[i].x, moustacheEnemies[i].y);
					entity.refresh();
				}
	
				var friends: Vector.<Point> = level.friends;
				l = friends.length;
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createFriend(_world);
					TransformComponent(entity.getComponent(TransformComponent)).setLocation(friends[i].x, friends[i].y);
					entity.refresh();
				}

				var firePits: Vector.<Rectangle> = level.firePits;
				l = firePits.length;
				for (i = 0; i < l; ++i) {
					entity = EntityFactory.createFirePit(_world);
					TransformComponent(entity.getComponent(TransformComponent)).setLocation(firePits[i].x, firePits[i].y);
					entity.refresh();
				}
				
				if(level.ship) {
					entity = EntityFactory.createEnemyShip(_world);
					TransformComponent(entity.getComponent(TransformComponent)).setLocation(level.ship.x, level.ship.y);
					entity.refresh();
				}

				if(level.wall) {
					entity = EntityFactory.createWall(_world, level.wall);
					entity.refresh();
				}
				
				_processLevel = false;
				e.refresh();
				
				SoundFactory.startLevel();
			}
		}

		/**
		 * clear 
		 * 
		 * @return 
		 */
		private function clear() : void {
			/**
			 * heroBullets 
			 */
			var heroBullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BULLETS);
			/**
			 * bullets 
			 */
			var bullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMY_BULLETS);
			/**
			 * enemies 
			 */
			var enemies : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.ENEMIES);
			/**
			 * bombs 
			 */
			var bombs : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BOMBS);
			/**
			 * fires 
			 */
			var fires : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.FIRES);
			/**
			 * effects 
			 */
			var effects : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.EFFECTS);
			
			killAll(enemies);
			killAll(bullets);
			killAll(heroBullets);
			killAll(bombs);
			killAll(fires);
			killAll(effects);

			/**
			 * ship 
			 */
			var ship: Entity = _world.getTagManager().getEntity(EntityTag.ENEMY_SHIP);
			if(ship) _world.deleteEntity(ship);
		}
		
		/**
		 * killAll 
		 * 
		 * @param bag 
		 * 
		 * @return 
		 */
		private function killAll(bag: IImmutableBag): void {
			/**
			 * l 
			 */
			var l : int;
			/**
			 * i 
			 */
			var i : int;
			l = bag.size();
			for (i = 0; i < l; ++i) {
				_world.deleteEntity(bag.get(i));
			}
		}

//		override protected function checkProcessing() : Boolean {
//			return _processLevel;
//		}


	}
}
