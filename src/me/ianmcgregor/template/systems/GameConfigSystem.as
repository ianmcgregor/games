package me.ianmcgregor.template.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.template.components.GameConfigComponent;
	import me.ianmcgregor.template.constants.EntityGroup;
	import me.ianmcgregor.template.constants.EntityTag;
	import me.ianmcgregor.template.constants.State;
	import me.ianmcgregor.template.factories.EntityFactory;

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
					// add hud
					EntityFactory.createHUD(_world);
					// add player entities
					EntityFactory.createPlayer(_world, 1);
					if (_gameConfigComponent.numPlayers > 1) {
						EntityFactory.createPlayer(_world, 2);
					}
					// controls
//					if(Environment.isMobile) {
						EntityFactory.createControls(_world);
//					}
					// update state and interval
					_g.state = State.PLAY;
					_interval = 4;
					break;
				case State.PLAY:
					break;
				case State.GAME_END:
					/**
					 * delete entities
					 */
					_world.deleteEntity(_world.getTagManager().getEntity(EntityTag.HUD));
					_world.deleteEntity(_world.getTagManager().getEntity(EntityTag.PLAYER_1));
					var p2 : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER_2);
					if(p2) _world.deleteEntity(p2);
					deleteEntityGroup(EntityGroup.NULL);
					/**
					 * game over
					 */
					_interval = 0;
					EntityFactory.createGameOver(_world);
					_g.state = State.GAME_OVER;
					break;
				default:
			}
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
	}
}
