package me.ianmcgregor.tenseconds.systems {
	import com.artemis.utils.IImmutableBag;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.tenseconds.components.BeamComponent;
	import me.ianmcgregor.tenseconds.components.PlayerComponent;
	import me.ianmcgregor.tenseconds.components.TowerComponent;
	import me.ianmcgregor.tenseconds.components.VelocityComponent;
	import me.ianmcgregor.tenseconds.constants.EntityGroup;
	import me.ianmcgregor.tenseconds.constants.KeyConstants;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerControlSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * mappers 
		 */
		private var _playerMapper : ComponentMapper;
		private var _weaponMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		/**
		 * _timeNow
		 */
		private var _timeNow : Number;
		
		//
		private var _maxRotation: Number = Math.PI * 0.3;
//		private var _rotationIncrement : Number = 0.01;

		/**
		 * HeroControlSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function PlayerControlSystem(g : GameContainer) {
			super(PlayerComponent, null);
			_g = g;
			_input = _g.getInput();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_velocityMapper = new ComponentMapper(VelocityComponent, _world);
			_weaponMapper = new ComponentMapper(WeaponComponent, _world);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_timeNow = _g.getTimeNow();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			// player 
			var player : PlayerComponent = _playerMapper.get(e);
			var player1 : Boolean = player.playerNum == 1;
			// keys
			var left : Boolean = player1 ? _input.isDown(KeyConstants.LEFT_P1) : _input.isDown(KeyConstants.LEFT_P2);
			var right : Boolean = player1 ? _input.isDown(KeyConstants.RIGHT_P1) : _input.isDown(KeyConstants.RIGHT_P2);
			var up : Boolean = player1 ? _input.isDown(KeyConstants.UP_P1) : _input.isDown(KeyConstants.UP_P2);
			var down : Boolean = player1 ? _input.justPressed(KeyConstants.DOWN_P1) : _input.justPressed(KeyConstants.DOWN_P2);
			
			var towers: IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.TOWERS);
			if(down) {
				// deselect
				TowerComponent(towers.get(player.selectedTower).getComponent(TowerComponent)).playerSelected = 0;
				selectNewTower(player, towers);
			}
			var t: Entity = towers.get(player.selectedTower);
			var transform: TransformComponent = _transformMapper.get(t);
			
			if (left) {
				transform.rotation -= player.rotationVelocity;
				if(transform.rotation < -_maxRotation) transform.rotation = -_maxRotation;
			} else if (right) {
				transform.rotation += player.rotationVelocity;
				if(transform.rotation > _maxRotation) transform.rotation = _maxRotation;
			}
			
			var tower: TowerComponent = t.getComponent(TowerComponent);
			tower.playerSelected = player.playerNum;
			var beam : BeamComponent = t.getComponent(BeamComponent);
			if(beam.alive) {
				beam.setOn(up);
				beam.rotation = transform.rotation;
			}
		}

		private function selectNewTower(player : PlayerComponent, towers : IImmutableBag) : void {
			player.selectedTower++;
			if (player.selectedTower >= towers.size()) {
				player.selectedTower = 0;
			}
			var e: Entity = towers.get(player.selectedTower);
			var t: TowerComponent = e.getComponent(TowerComponent);
			var b : BeamComponent = e.getComponent(BeamComponent);
			if(t.playerSelected != 0 || !b.alive) {
				selectNewTower(player, towers);
			}
		}
	}
}
