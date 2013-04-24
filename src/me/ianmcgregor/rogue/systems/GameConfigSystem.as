package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.app.Environment;
	import me.ianmcgregor.games.utils.ogmo.OgmoEntity;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import me.ianmcgregor.games.utils.ogmo.OgmoParser;
	import me.ianmcgregor.rogue.assets.Levels;
	import me.ianmcgregor.rogue.components.CollisionComponent;
	import me.ianmcgregor.rogue.components.GameConfigComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityGroup;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.constants.State;
	import me.ianmcgregor.rogue.factories.EntityFactory;

	import starling.core.Starling;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author ianmcgregor
	 */
	public final class GameConfigSystem extends IntervalEntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _gameConfigMapper : ComponentMapper;
		/**
		 * _gameConfigComponent 
		 */
		private var _gameConfigComponent : GameConfigComponent;
		/**
		 * _levels
		 */
		private var _levels : OgmoParser;
		private var _level : OgmoLevel;
		/**
		 * _initStep
		 */
		private var _initStep : int;
		private var _currentLevel : uint;
		private var _prevState : String;
		
		/**
		 * GameConfigSystem
		 */
		public function GameConfigSystem(g : GameContainer) {
			super(0, GameConfigComponent, []);
			_g = g;
		}
		
		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_gameConfigMapper = new ComponentMapper(GameConfigComponent, _world);
			
			_levels = new OgmoParser();
			_levels.parse(Levels.Level0, Levels.Level1, Levels.Level2, Levels.Level3, Levels.Level4, Levels.Level);
			
//			var l: uint = _levels.numLevels;
//			for (var i : int = 0; i < l; ++i) {
//				trace(i, _levels.at(i));
//			}
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			_gameConfigComponent = _gameConfigMapper.get(e);
			switch(_g.state){
				case State.GAME_START:
					/**
					 *  TODO : 
					 *  
					 *  If the intialisation is taking a long time it could be split up 
					 *  into an init list and show a game loading screen while going through.
					 *  
					 *  List could be an integar that is incremented and sections processed
					 *  in a switch. Default on switch would be the game start.
					 *  
					 *  Can use the interval to process each item on the list.
					 *  
					 *  Once reached end of list update game state to play.
					 */
					_interval = 0.1;
					processInits();
					break;
				case State.PLAY:
					break;
				case State.NEXT_LEVEL:
					clearLevel();
					_currentLevel++;
					_interval = 0.1;
					_prevState = _g.state;
					_g.state = State.INIT_LEVEL;
					break;
				case State.PREV_LEVEL:
					clearLevel();
					_currentLevel--;
					_interval = 0.1;
					_prevState = _g.state;
					_g.state = State.INIT_LEVEL;
					break;
				case State.INIT_LEVEL:
					processInits();
					break;
				case State.GAME_END:
					clearLevel();
					_interval = 0;
					EntityFactory.createGameOver(_world);
					_g.state = State.GAME_OVER;
					break;
				default:
			}
		}
		
		private function processInits(): void {
//			trace("GameConfigSystem.processInits(",_initStep,")");
			switch(_initStep){
				case 0:
					// level
					if(_currentLevel > _levels.numLevels - 1) _currentLevel = 0;
					_level = _levels.at(_currentLevel);
//					trace('_currentLevel: ' + (_currentLevel));
					EntityFactory.createLevel(_world, _level);
					break;
				case 1:
					break;
				case 2:
					var l : int;
					var i : int;
					// add items
					var entities: Vector.<OgmoEntity> = _level.entities.getAll();
					l = entities.length;
					for (i = 0; i < l; ++i) {
						var type : String = entities[i].type;
						var texture: String = Constants.ITEM_TEXTURES[type];
						switch(type) {
							case Constants.ITEM_EXIT_LOCKED_2:
								var x: int = entities[i].x / Constants.TILE_SIZE;
								var y: int = entities[i].y / Constants.TILE_SIZE;
								_level.nodes.setWalkable(x, y, false);
								_level.grid[y][x] = false;
								EntityFactory.createItem2(_world, entities[i], texture, new CollisionComponent(-2, -2, Constants.TILE_SIZE + 4, Constants.TILE_SIZE + 4));
								break;
							case Constants.ITEM_EXIT_GAP:
							case Constants.ITEM_ENTRANCE_GAP:
								EntityFactory.createInvisibleItem(_world, entities[i]);
								break;
							case Constants.ITEM_MOVEABLE:
								EntityFactory.createMoveableItem(_world, entities[i], texture);
								break;
							default:
								if(texture)
									EntityFactory.createItem(_world, entities[i], texture);
								break;
						}
//						trace("GameConfigSystem.processInits()", 'type: ' + (type));
					}
					// add monsters
					var monsters : Vector.<OgmoEntity>;
					if (_level.entities.has("enemyspawner")) {
						monsters = _level.entities.get("enemyspawner");
						l = monsters.length;
						for (i = 0; i < l; ++i) {
							EntityFactory.createMonster(_world, monsters[i]);
						}
					}
					if(_level.entities.has("treemonster")) {
						monsters = _level.entities.get("treemonster");
						l = monsters.length;
						for (i = 0; i < l; ++i) {
							EntityFactory.createMonster(_world, monsters[i]);
						}
					}
					if (_level.entities.has("man")) {
						monsters = _level.entities.get("man");
						l = monsters.length;
						for (i = 0; i < l; ++i) {
							EntityFactory.createMonster(_world, monsters[i]);
						}
					}
					if(_level.entities.has("bat")) {
						var bats : Vector.<OgmoEntity> = _level.entities.get("bat");
						l = bats.length;
						for (i = 0; i < l; ++i) {
							EntityFactory.createBat(_world, bats[i]);
						}
					}
					break;
				case 3:
					// add player entities
					var appendage: String = _prevState == State.PREV_LEVEL ? "entrance" : "";
					var p : OgmoEntity = _level.entities.getEntity(("player1" + appendage));
					var e : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER_1) || EntityFactory.createPlayer(_world, 1, p);
					var t: TransformComponent = e.getComponent(TransformComponent);
					t.x = p.x;
					t.y = p.y;
					EntityFactory.createMessage(_world, Constants.MESSAGE_HELLO, Constants.DEFAULT_MESSAGE_LIFETIME, t);
					if (_gameConfigComponent.numPlayers > 1) {
						p = _level.entities.getEntity(("player2" + appendage));
						e = _world.getTagManager().getEntity(EntityTag.PLAYER_2) || EntityFactory.createPlayer(_world, 2, p);
						t = e.getComponent(TransformComponent);
						t.x = p.x;
						t.y = p.y;
					}
					break;
				case 4:
					// add hud
					EntityFactory.createHUD(_world);
					// controls
					if(Environment.isMobile) {
						EntityFactory.createControls(_world);
					}
					break;
				default:
					// update state and interval
					_interval = 1;
					_initStep = -1;
					_g.state = State.PLAY;
					break;
			}
			_initStep ++;
		}
		
		private function clearLevel(): void {
			Starling.current.nativeStage.removeChildren();
			deleteEntityGroup(EntityGroup.LEVEL_ENTITIES);
//			deleteEntityGroup(EntityGroup.WEAPONS);
			deleteEntityByTag(EntityTag.LEVEL);
			deleteEntityByTag(EntityTag.HUD);
//			deleteEntityByTag(EntityTag.PLAYER_1);
//			deleteEntityByTag(EntityTag.PLAYER_2);
			deleteEntityByTag(EntityTag.CONTROLS);
		}

		/**
		 * deleteEntityGroup
		 * 
		 * @param group
		 * 
		 * @return
		 */
		private function deleteEntityGroup(group : String) : void {
			var entities: IImmutableBag = _world.getGroupManager().getEntities(group);
			var l: int = entities.size();
			for (var i : int = 0; i < l; ++i) {
				_world.deleteEntity(entities.get(i));
			}
		}

		/**
		 * deleteEntityByTag
		 * 
		 * @param tag
		 * 
		 * @return
		 */
		private function deleteEntityByTag(tag : String) : void {
			var e : Entity = _world.getTagManager().getEntity(tag);
			if( e ) _world.deleteEntity(e);
//			trace("GameConfigSystem.deleteEntityByTag(",tag, e,")");
		}
	}
}
