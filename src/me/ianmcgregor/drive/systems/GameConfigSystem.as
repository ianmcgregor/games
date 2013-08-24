package me.ianmcgregor.drive.systems {
	import me.ianmcgregor.drive.assets.Assets;
	import me.ianmcgregor.drive.assets.Levels;
	import me.ianmcgregor.drive.components.GameConfigComponent;
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.constants.EntityGroup;
	import me.ianmcgregor.drive.constants.EntityTag;
	import me.ianmcgregor.drive.constants.State;
	import me.ianmcgregor.drive.factories.EntityFactory;
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.app.Environment;
	import me.ianmcgregor.games.utils.ogmo.OgmoEntity;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import me.ianmcgregor.games.utils.ogmo.OgmoParser;

	import starling.core.Starling;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	/**
	 * @author ianmcgregor
	 */
	public final class GameConfigSystem extends IntervalEntityProcessingSystem {
		private const LEVEL_COMPLETE_PAUSE : Number = 1;
		private const GAME_OVER_PAUSE : Number = 1;
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
		private var _currentLevel : uint = 0;

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
			//_levels.parse(Levels.Level01, Levels.Level02);
			_levels.parse(Levels);
		//	trace(_levels.toString());
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
					// level
					createLevel();
					// add hud
					EntityFactory.createHUD(_world);
					// controls
					if(Environment.isMobile) {
						EntityFactory.createControls(_world);
					}
					// update state and interval
					_g.state = State.PLAY;
					break;
				case State.PLAY:
					break;
				case State.LEVEL_COMPLETE:
					if(_interval == LEVEL_COMPLETE_PAUSE) {
						_interval = 0;
						_g.state = State.NEXT_LEVEL;
					} else {
						_interval = LEVEL_COMPLETE_PAUSE;
						Audio.play(Assets.levelup);
					}
					break;
				case State.NEXT_LEVEL:
					_currentLevel ++;
					clearLevel();
					if (_currentLevel > _levels.numLevels - 1) {
						_currentLevel = 0;
						_g.state = State.GAME_END;
					} else {
						createLevel();
						_g.state = State.PLAY;
					}
					break;
				case State.GAME_ENDING:
					if(_interval == GAME_OVER_PAUSE) {
						_interval = 0;
						_g.state = State.GAME_END;
					} else {
						_interval = GAME_OVER_PAUSE;
					}
					break;
				case State.GAME_END:
					// delete entities
					clearLevel();
					deleteEntityByTag(EntityTag.HUD);
					// game over
					_interval = 0;
					EntityFactory.createGameOver(_world);
					_g.state = State.GAME_OVER;
					break;
				default:
			}
		}
		
		/**
		 * createLevel
		 */
		private function createLevel() : void {
			_level = _levels.at(_currentLevel);
			_gameConfigComponent.level = _level;
			_g.camera.x = _level.camera.x;
			_g.camera.y = _level.camera.y;
			
			EntityFactory.createLevel(_world, _level);

			var entities : Vector.<OgmoEntity> = _level.entities.getAll();
			var l : uint = entities.length;
			for (var i : uint = 0; i < l; ++i) {
				var o : OgmoEntity = entities[i];
				var type : String = entities[i].type;
				switch(type) {
					case Constants.GROUND:
						EntityFactory.createGround(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.ROAD_STRAIGHT:
					case Constants.ROAD_CURVE_LEFT:
					case Constants.ROAD_CURVE_RIGHT:
					case Constants.ROAD_SPLIT_START:
					case Constants.ROAD_SPLIT:
					case Constants.ROAD_BRIDGE:
					case Constants.OFFROAD:
					// TODO: roads could maybe be tiles instead of entities
					// Being done in LevelSpatial now
//						EntityFactory.createRoad(_world, o.x, o.y, type);
						break;
					case Constants.TRUCK:
						EntityFactory.createTruck(_world, o.x, o.y, o.width, o.height);
						break;
					// add player entities
					case Constants.PLAYER_1:
						EntityFactory.createPlayer(_world, 1, o.x, o.y, 64, 64);
						break;
					case Constants.PLAYER_2:
						if (_gameConfigComponent.numPlayers > 1) {
							EntityFactory.createPlayer(_world, 2, o.x, o.y, 64, 64);
						}
						break;
					case Constants.BOSS:
						EntityFactory.createBoss(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.PEDESTRIAN:
						EntityFactory.createPedestrian(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.CYCLIST:
						EntityFactory.createCyclist(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.BOMB:
						EntityFactory.createBomb(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.SLICK:
						EntityFactory.createSlick(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.ROAD_BLOCK:
						EntityFactory.createRoadBlock(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.TREE:
						EntityFactory.createTree(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.BOULDER:
						EntityFactory.createBoulder(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.ENEMY:
					case Constants.ENEMY_1:
					case Constants.ENEMY_2:
					case Constants.ENEMY_3:
						EntityFactory.createEnemy(_world, type, o.x, o.y, o.width, o.height);
						break;
					default:
				}
			}
		}
		
		/**
		 * clearLevel
		 */
		private function clearLevel(): void {
			trace("GameConfigSystem.clearLevel()");
			Starling.current.nativeStage.removeChildren();
			deleteEntityGroup(EntityGroup.LEVEL_ENTITIES);
			deleteEntityByTag(EntityTag.PLAYER_1);
			deleteEntityByTag(EntityTag.PLAYER_2);
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
