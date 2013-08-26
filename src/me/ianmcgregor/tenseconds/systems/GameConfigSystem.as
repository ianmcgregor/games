package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.ogmo.OgmoEntity;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import me.ianmcgregor.games.utils.ogmo.OgmoParser;
	import me.ianmcgregor.tenseconds.assets.Levels;
	import me.ianmcgregor.tenseconds.components.BeamComponent;
	import me.ianmcgregor.tenseconds.components.GameConfigComponent;
	import me.ianmcgregor.tenseconds.components.HUDComponent;
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.tenseconds.constants.EntityGroup;
	import me.ianmcgregor.tenseconds.constants.EntityTag;
	import me.ianmcgregor.tenseconds.constants.State;
	import me.ianmcgregor.tenseconds.factories.EntityFactory;

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
			_levels.parse(Levels);
			//trace(_levels.toString());
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
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
			_gameConfigComponent = _gameConfigMapper.get(e);
			switch(_g.state){
				case State.GAME_START:
					// add player entities
					EntityFactory.createPlayer(_world, 1);
					if (_gameConfigComponent.numPlayers > 1) {
						EntityFactory.createPlayer(_world, 2);
					}
					// level
					createLevel();
					// add hud
					EntityFactory.createHUD(_world);
					
					// controls
//					if(Environment.isMobile) {
						//EntityFactory.createControls(_world);
//					}
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
					stopBeams();
					if(_interval == GAME_OVER_PAUSE) {
						_interval = 0;
						_g.state = State.GAME_END;
					} else {
						_interval = GAME_OVER_PAUSE;
					}
					break;
				case State.GAME_END:
					// game over
					_interval = 0;
					var _hud: HUDComponent = _world.getTagManager().getEntity(EntityTag.HUD).getComponent(HUDComponent);
					EntityFactory.createGameOver(_world, (_hud.hits + _hud.kills >= Constants.MAX_ENEMIES));
					_g.state = State.GAME_OVER;
					break;
				case State.PLAY_AGAIN:
					// delete entities
					clearLevel();
					_g.state = State.TITLES;
					break;
				default:
			}
		}

		private function stopBeams() : void {
			var towers: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.TOWERS);
			var l: int = towers.size();
			for (var i : int = 0; i < l; ++i) {
				var t: Entity = towers.get(i);
				var b : BeamComponent = t.getComponent(BeamComponent);
				b.setOn(false);
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
			
			var entities : Vector.<OgmoEntity> = _level.entities.getAll();
			var l : uint = entities.length;
			for (var i : uint = 0; i < l; ++i) {
				var o : OgmoEntity = entities[i];
				var type : String = entities[i].type;
				switch(type) {
					case Constants.TOWER:
						EntityFactory.createTower(_world, int(o.id), o.x, o.y);
						break;
					default:
				}
			}
			EntityFactory.createEnemySpawner(_world);
		}
		
		/**
		 * clearLevel
		 */
		private function clearLevel(): void {
			Starling.current.nativeStage.removeChildren();
			deleteEntityGroup(EntityGroup.TOWERS);
			deleteEntityGroup(EntityGroup.ENEMIES);
			deleteEntityGroup(EntityGroup.LEVEL_ENTITIES);
			deleteEntityByTag(EntityTag.PLAYER_1);
			deleteEntityByTag(EntityTag.PLAYER_2);
			deleteEntityByTag(EntityTag.HUD);
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
