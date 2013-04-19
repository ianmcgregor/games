package me.ianmcgregor.nanotech.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.nanotech.components.GameConfigComponent;
	import me.ianmcgregor.nanotech.constants.Constants;
	import me.ianmcgregor.nanotech.constants.EntityGroup;
	import me.ianmcgregor.nanotech.constants.EntityTag;
	import me.ianmcgregor.nanotech.constants.State;
	import me.ianmcgregor.nanotech.factories.EntityFactory;

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
		 * _gameInitComponent 
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
//			trace("GameConfigSystem.processEntity(",e,")");
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
					// add friend entities
					createFriends();

					// update state and interval
					_g.state = State.PLAY;
					_interval = 4;
					break;
				case State.PLAY:
					_gameConfigComponent.addProgress(Constants.GAME_PROGRESS_INCREMENT);
					break;
				case State.GAME_END:
					_world.deleteEntity(_world.getTagManager().getEntity(EntityTag.HUD));
					_world.deleteEntity(_world.getTagManager().getEntity(EntityTag.PLAYER_1));
					var p2 : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER_2);
					if(p2) _world.deleteEntity(p2);
					deleteEntityGroup(EntityGroup.ENEMY);
					deleteEntityGroup(EntityGroup.BULLET);
					_interval = 0;
					_gameConfigComponent.setProgress(0);
					EntityFactory.createGameOver(_world);
					_g.state = State.GAME_OVER;
					break;
				default:
			}
		}

		private function createFriends() : void {
			var layout : Array = [
				[0, 0, 1, 0, 0], 
				[0, 1, 1, 1, 0], 
				[1, 1, 1, 1, 1], 
				[0, 1, 1, 1, 0], 
				[0, 0, 1, 0, 0]
			];
			var spacing : Number = 60;
			var l : int = layout.length;
			var row : Array = layout[0];
			var rowL : int = row.length;
			var minX : Number = _g.getWidth() * 0.5 - spacing * (rowL - 1) * 0.5;
			var xPos : Number;
			var minY : Number = _g.getHeight() * 0.5 - spacing * (l - 1) * 0.5;
			var yPos : Number;
			for (var i : int = 0; i < l; ++i) {
				for (var j : int = 0; j < rowL; ++j) {
					if (layout[i][j] == 1) {
						xPos = minX + j * spacing;
						yPos = minY + i * spacing;
						EntityFactory.createFriend(_world, xPos, yPos);
					}
				}
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
