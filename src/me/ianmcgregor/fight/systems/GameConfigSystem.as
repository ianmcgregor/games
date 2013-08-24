package me.ianmcgregor.fight.systems {
	import me.ianmcgregor.fight.assets.Levels;
	import me.ianmcgregor.fight.components.GameConfigComponent;
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.EntityGroup;
	import me.ianmcgregor.fight.constants.EntityTag;
	import me.ianmcgregor.fight.constants.State;
	import me.ianmcgregor.fight.factories.EntityFactory;
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
			trace(_levels.toString());
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
					//_interval = 4;
					break;
				case State.PLAY:
					break;
				case State.GAME_ENDING:
					if(_interval == 1) {
						_interval = 0;
						_g.state = State.NEXT_LEVEL;
					} else {
						_interval = 1;
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
				case State.GAME_END:
					/**
					 * delete entities
					 */
					clearLevel();
					/**
					 * game over
					 */
					_interval = 0;
					deleteEntityByTag(EntityTag.HUD);
					EntityFactory.createGameOver(_world);
					_g.state = State.GAME_OVER;
					break;
				default:
			}
		}

		private function createLevel() : void {
			_level = _levels.at(_currentLevel);
			_gameConfigComponent.level = _level;
			_g.camera.x = _level.camera.x;
			_g.camera.y = _level.camera.y;
			var entities : Vector.<OgmoEntity> = _level.entities.getAll();
			var l : uint = entities.length;
			for (var i : uint = 0; i < l; ++i) {
				var o : OgmoEntity = entities[i];
				var type : String = entities[i].type;
				switch(type) {
					case Constants.GROUND:
						EntityFactory.createGround(_world, o.x, o.y, o.width, o.height);
						break;
					// add player entities
					case Constants.PLAYER_1:
					// FIXME: remove -y
						EntityFactory.createPlayer(_world, 1, o.x, o.y - 100, 64, 68);
						break;
					case Constants.PLAYER_2:
						if (_gameConfigComponent.numPlayers > 1) {
							EntityFactory.createPlayer(_world, 2, o.x, o.y, 32, 32);
						}
						break;
					case Constants.BOSS:
						EntityFactory.createBoss(_world, o.x, o.y, o.width, o.height);
						break;
					case Constants.BAD_GUY_1:
					case Constants.BAD_GUY_2:
					case Constants.BAD_GUY_3:
						EntityFactory.createBadGuy(_world, type, o.x, o.y, o.width, o.height);
						break;
					default:
				}
			}
		}

		private function clearLevel(): void {
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
