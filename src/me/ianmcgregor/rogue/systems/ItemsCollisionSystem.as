package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.collisions.CollisionUtil;
	import me.ianmcgregor.games.utils.display.Rect;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.rogue.components.BatComponent;
	import me.ianmcgregor.rogue.components.InventoryComponent;
	import me.ianmcgregor.rogue.components.ItemComponent;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.MonsterComponent;
	import me.ianmcgregor.rogue.components.PlayerComponent;
	import me.ianmcgregor.rogue.components.VelocityComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityGroup;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.factories.EntityFactory;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author ianmcgregor
	 */
	public final class ItemsCollisionSystem extends EntityProcessingSystem {
		private var _g : GameContainer;
		private var _playerMapper : ComponentMapper;
		private var _doorUnlockedAt : Number;

		// TODO: could grab everything with some itemcomponent or collisioncomponent...
		
		public function ItemsCollisionSystem(g : GameContainer) {
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
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
//			var level : LevelComponent = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
			/**
			 * player 
			 */
			// var player: PlayerComponent = _playerMapper.get(e);
//			var transform : TransformComponent = e.getComponent(TransformComponent);
//			var velocity : VelocityComponent = e.getComponent(VelocityComponent);
//			var collision : CollisionComponent = e.getComponent(CollisionComponent);

//			checkCollisions(e, EntityGroup.LEVEL_ENTITIES);
			
			var entities : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.LEVEL_ENTITIES);
			CollisionUtil.resolveCollisions(e, entities, collide);
			
		}

//		private function checkCollisions(player: Entity, group: String) : void {
//			var entities : IImmutableBag = _world.getGroupManager().getEntities(group);
//			var l : int = entities.size();
//			for (var i : int = 0; i < l; ++i) {
//				var e : Entity = entities.get(i);
//				resolveCollision(player, e);
//			}
//		}

//		private function resolveCollision(e1 : Entity, e2 : Entity) : void {
//			var t1 : TransformComponent = e1.getComponent(TransformComponent);
//			var t2 : TransformComponent = e2.getComponent(TransformComponent);
//			var x: Number = t2.x;
//			var y: Number = t2.y;
//			var width: Number = Constants.TILE_SIZE;
//			var height: Number = Constants.TILE_SIZE;
//			var collision: CollisionComponent = e2.getComponent(CollisionComponent);
//			if( collision ) {
//				x += collision.x;
//				y += collision.y;
//				width = collision.width;
//				height = collision.height;
//			}
//			var r1: Rect = Rect.get(t1.x, t1.y, Constants.TILE_SIZE, Constants.TILE_SIZE);
//			var r2: Rect = Rect.get(x, y, width, height);
//			if(r1.intersects(r2) && r1.getIntersectionPercent(r2) > 0.5) {
////				trace('collision', r1.getIntersectionArea(r2), " of ",(r1.width * r1.height), '', r1.getIntersectionPercent(r2).toFixed(2));
//				collide(e1,e2,r1,r2,r1.getIntersectionPercent(r2));
//			}
//			r1.dispose();
//			r2.dispose();
//		}
		
		private function collide(e1 : Entity, e2 : Entity, r1: Rect, r2: Rect, intersectionPercent: Number) : void {
//			var p: PlayerComponent = e1.getComponent(PlayerComponent);
			var item: ItemComponent = e2.getComponent(ItemComponent);
			if( item ) {
				switch(item.type){
					case Constants.ITEM_TREASURE:
						if(intersectionPercent > Constants.MIN_INTERSECTION_ITEM)
							playerGotTreasure(e1, e2);
						break;
					case Constants.ITEM_FOOD:
						if(intersectionPercent > Constants.MIN_INTERSECTION_ITEM)
							playerGotFood(e1, e2);
						break;
					case Constants.ITEM_KEY:
					case Constants.ITEM_POTION:
						if(intersectionPercent > Constants.MIN_INTERSECTION_ITEM)
							playerGotItem(e1, e2, item);
						break;
					case Constants.ITEM_EXIT:
						if(intersectionPercent > 0.8)
							goThroughExit(e1, e2, item);
						break;
					case Constants.ITEM_EXIT_GAP:
						if(intersectionPercent > 0.8)
							goThroughExit(e1, e2, item);
						break;
					case Constants.ITEM_EXIT_LOCKED_2:
						//if(intersectionPercent > 0.5)
							tryToUnlockDoor2(e1, e2, item);
						break;
					case Constants.ITEM_EXIT_LOCKED:
						if(intersectionPercent > 0.5)
							tryToUnlockDoor(e1, e2, item);
						break;
					case Constants.ITEM_EXIT_UNLOCKING:
						unlockDoor(item);
						break;
					case Constants.ITEM_ENTRANCE:
					case Constants.ITEM_ENTRANCE_GAP:
						if(intersectionPercent > 0.8)
							goBackThroughEntrance(e1, e2, item);
						break;
					case Constants.ITEM_TRAP:
						if(intersectionPercent > 0.8)
							springTheTrap(e1, item);
						break;
					case Constants.ITEM_SWORD:
						if(intersectionPercent > Constants.MIN_INTERSECTION_ITEM)
							pickUpSword(e1, e2);
						break;
					case Constants.ITEM_MOVEABLE:
//						if(intersectionPercent > 0.1)
							pushMoveable(e1, e2);
						break;
					default:
				}
			} else if( e2.getComponent(MonsterComponent) || e2.getComponent(BatComponent) ) {
				playerBumpedMonster(e1, r1, r2);

			}
		}
		
		/**
		 * Push moveable block
		 */
		private function pushMoveable(e1 : Entity, e2 : Entity) : void {
			var pT: TransformComponent = e1.getComponent(TransformComponent);
			var mT: TransformComponent = e2.getComponent(TransformComponent);
			var pV: VelocityComponent = e1.getComponent(VelocityComponent);
			var mV: VelocityComponent = e2.getComponent(VelocityComponent);
			var rads : Number = MathUtils.angle(pT.x, pT.y, mT.x, mT.y);
			
//			const RIGHT : Number = -0.7853981633974483;
//			const DOWN : Number = 0.7853981633974483;
//			const LEFT : Number = 2.356194490192345;
//			const UP : Number = -2.356194490192345;
			
			var mul : Number = 1.1;
			if (rads > -0.6 && rads < 0.6) {
				// left of block pushing right
				// if pushing in right direction
				if(pV.getX() > 0) {
					pV.dampen(0.5);
					// set velocity to player velocity
					mV.setX(pV.getX() * mul);
					// stop player pushing into block if it hit a wall
					if(pT.x + Constants.TILE_SIZE > mT.x) pT.x = mT.x - Constants.TILE_SIZE;
				}
			} else if (rads > 0.8 && rads < 2.2) {
				// above block pushing down
				if(pV.getY() > 0) {
					pV.dampen(0.5);
					mV.setY(pV.getY() * mul);
					if(pT.y + Constants.TILE_SIZE > mT.y) pT.y = mT.y - Constants.TILE_SIZE; 
				}
			} else if ((rads > 2.5 && rads < Math.PI) || (rads > -Math.PI && rads < -2.5)) {
				// right of block pushing left
				if(pV.getX() < 0) {
					pV.dampen(0.5);
					mV.setX(pV.getX() * mul);
					if(pT.x < mT.x + Constants.TILE_SIZE) pT.x = mT.x + Constants.TILE_SIZE;
				}
			} else if (rads > -2.2 && rads < -0.8) {
				// below block pushing up
				if(pV.getY() < 0) {
					pV.dampen(0.5);
					mV.setY(pV.getY() * mul);
					if(pT.y < mT.y + Constants.TILE_SIZE) pT.y = mT.y + Constants.TILE_SIZE;
				}
			}
		}
		
		/**
		 * Pick up sword
		 */
		private function pickUpSword(e1 : Entity, e2 : Entity) : void {
			var i : InventoryComponent = e1.getComponent(InventoryComponent);
			var hasSword: Boolean = i.weapon == Constants.TEXTURE_SWORD;
			if(!hasSword) {
				i.weapon = Constants.TEXTURE_SWORD;
				var p: PlayerComponent = e1.getComponent(PlayerComponent);
				EntityFactory.createWeapon(_world, e1, "", ( p.playerNum == 1 ? EntityTag.WEAPON_PLAYER_1 : EntityTag.WEAPON_PLAYER_2 ));
				_world.deleteEntity(e2);
				EntityFactory.createMessage(_world, Constants.MESSAGE_GOT_WEAPON, Constants.DEFAULT_MESSAGE_LIFETIME, e1.getComponent(TransformComponent));
			}
		}
		
		/**
		 * Spring trap
		 */
		private function springTheTrap(e1 : Entity, item : ItemComponent) : void {
			reducePlayerHealth(e1, 0.2);
			item.update(Constants.ITEM_TRAP_SPRUNG, Constants.ITEM_TEXTURES[Constants.ITEM_TRAP_SPRUNG]);
		}
		
		/**
		 * Go back to previous room
		 */
		private function goBackThroughEntrance(e1 : Entity, e2 : Entity, item : ItemComponent) : void {
			trace("ItemsCollisionSystem.goBackThroughEntrance(",e1, e2, item,")");
			e1, e2, item;
			_g.state = State.PREV_LEVEL;
		}
		
		/**
		 * Go to next room
		 */
		private function goThroughExit(e1 : Entity, e2 : Entity, item : ItemComponent) : void {
			e1, e2, item;
			_g.state = State.NEXT_LEVEL;
		}
		
		/**
		 * Try to unlock door
		 */
		private function tryToUnlockDoor(e1 : Entity, e2 : Entity, item : ItemComponent) : void {
//			trace("ItemsCollisionSystem.tryToUnlockDoor(",e1, e2, item,")");
			e2;
			var i : InventoryComponent = e1.getComponent(InventoryComponent);
			var hasKey: Boolean = i.hasItem(Constants.ITEM_TEXTURES[Constants.ITEM_KEY]);
//			trace('hasKey: ' + (hasKey));
			if(hasKey) {
				_doorUnlockedAt = _g.getTimeNow();
				i.useItem(Constants.ITEM_KEY);
				item.update(Constants.ITEM_EXIT_UNLOCKING, Constants.ITEM_TEXTURES[Constants.ITEM_EXIT]);
			} else {
				var t: TransformComponent = e2.getComponent(TransformComponent);
				EntityFactory.createMessage(_world, Constants.MESSAGE_LOCKED, Constants.DEFAULT_MESSAGE_LIFETIME, null, t.x, t.y);
			}
		}
		
		/**
		 * Try to unlock door
		 */
		private function tryToUnlockDoor2(e1 : Entity, e2 : Entity, item : ItemComponent) : void {
//			trace("ItemsCollisionSystem.tryToUnlockDoor(",e1, e2, item,")");
			e2;
			var i : InventoryComponent = e1.getComponent(InventoryComponent);
			var hasKey: Boolean = i.hasItem(Constants.ITEM_TEXTURES[Constants.ITEM_KEY]);
//			trace('hasKey: ' + (hasKey));
			var t: TransformComponent = e2.getComponent(TransformComponent);
			if(hasKey) {
				_doorUnlockedAt = _g.getTimeNow();
				i.useItem(Constants.ITEM_KEY);
				item.update(Constants.ITEM_DOOR_2, "0-1");
				
				var x: int = t.x / Constants.TILE_SIZE;
				var y: int = t.y / Constants.TILE_SIZE;
				var _level: LevelComponent = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
				_level.current.nodes.setWalkable(x, y, true);
				_level.current.grid[y][x] = true;
				
			} else {
				EntityFactory.createMessage(_world, Constants.MESSAGE_LOCKED, Constants.DEFAULT_MESSAGE_LIFETIME, null, t.x, t.y);
			}
		}
		
		/**
		 * Unlock door
		 */
		private function unlockDoor(item : ItemComponent) : void {
			if(_doorUnlockedAt < _g.getTimeNow() - 1)
				item.update(Constants.ITEM_EXIT);
		}
		
		/**
		 * Got item
		 */
		private function playerGotItem(e1 : Entity, e2 : Entity, item: ItemComponent) : void {
			var i : InventoryComponent = e1.getComponent(InventoryComponent);
			i.addItem(item.texture);
			_world.deleteEntity(e2);
		}
		
		/**
		 * Got treasure
		 */
		private function playerGotTreasure(e1 : Entity, e2 : Entity) : void {
			var i : InventoryComponent = e1.getComponent(InventoryComponent);
			i.treasure++;
			// trace('PLAYER', p.playerNum, 'GOT TREASURE', i.treasure);
			_world.deleteEntity(e2);
		}
		
		/**
		 * Got food
		 */

		private function playerGotFood(e1 : Entity, e2 : Entity) : void {
			var h : HealthComponent = e1.getComponent(HealthComponent);
			if (h.getHealthPercentage() < 1) {
				h.restoreHealth(Constants.FOOD_HEALTH_RESTORE);
				EntityFactory.createMessage(_world, Constants.MESSAGE_ATE_FOOD, Constants.DEFAULT_MESSAGE_LIFETIME, e1.getComponent(TransformComponent));
			} else {
				// add to inventory?
			}
			_world.deleteEntity(e2);
		}
		
		/**
		 * Bumped into monster
		 */
		private function playerBumpedMonster(e1 : Entity, r1 : Rect, r2 : Rect) : void {
			//trace('PLAYER', p.playerNum, 'HIT MONSTER');
			var v: VelocityComponent = e1.getComponent(VelocityComponent);
			//trace(r1.intersection(r2));
			var diffX: Number = r1.left - r2.left;
			var diffY: Number = r1.top - r2.top;
			var forceX: Number = diffX * 0.2;
			var forceY: Number = diffY * 0.2;
			v.setX(forceX);
			v.setY(forceY);

			reducePlayerHealth(e1, Constants.MONSTER_COLLISION_DAMAGE);

			// TODO: reduce health and kill monster if zero
					
							
			//	_world.deleteEntity(e2);}
		}

		private function reducePlayerHealth(e1 : Entity, amount: Number) : void {
			// reduce player health
			var h : HealthComponent = e1.getComponent(HealthComponent);
			if (h.getDamagedAt() < _g.getTimeNow() - 0.2) {
				h.addDamage(amount);
				h.setDamagedAt(_g.getTimeNow());
				EntityFactory.createMessage(_world, Constants.MESSAGE_HURT, Constants.DEFAULT_MESSAGE_LIFETIME, e1.getComponent(TransformComponent));
			}
		}
	}
}
