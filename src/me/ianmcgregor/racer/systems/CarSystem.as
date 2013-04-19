package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.TileComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.Constants;
	import me.ianmcgregor.racer.constants.Direction;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.GameState;
	import me.ianmcgregor.racer.constants.GameType;
	import me.ianmcgregor.racer.constants.TileType;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.ui.Keyboard;

	/**
	 * @author ianmcgregor
	 */
	public final class CarSystem extends EntityProcessingSystem {
		/**
		 * _carOne 
		 */
		private var _carOne : CarComponent;
		/**
		 * _carTwo 
		 */
		private var _carTwo : CarComponent;
		/**
		 * _gameMapper 
		 */
		private var _gameMapper : ComponentMapper;
		/**
		 * _game 
		 */
		private var _game : GameComponent;
		/**
		 * _trackMapper 
		 */
		private var _trackMapper : ComponentMapper;
		/**
		 * _carMapper 
		 */
		private var _carMapper : ComponentMapper;
		/**
		 * _keyInput 
		 */
		private var _keyInput : IKeyInput;
		/**
		 * _track 
		 */
		private var _track : TrackComponent;
		/**
		 * _container 
		 */
		private var _container : GameContainer;

		/**
		 * TODO: 
		 * 
		 * clean up unused methods below
		 */

		/**
		 * CarSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function CarSystem(container : GameContainer) {
			super(CarComponent, []);
			_container = container;
			_keyInput = _container.getInput();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_gameMapper = new ComponentMapper(GameComponent, _world);
			_trackMapper = new ComponentMapper(TrackComponent, _world);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_game = _gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));
			_track = _trackMapper.get(_world.getTagManager().getEntity(EntityTag.TRACK));

			if (_game.state == GameState.TITLES) {
				initCars();
				_game.state = GameState.CREATING_TRACK;
			}
		}

		/**
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
			super.processEntities(entities);
		}

		/**
		 * end 
		 * 
		 * @return 
		 */
		override protected function end() : void {
			super.end();

			if (_game.state == GameState.READY) {
				_game.state = GameState.START_LIGHTS;
			}
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
			 * car 
			 */
			var car : CarComponent = e.getComponent(CarComponent);

			switch(_game.state) {
				case GameState.READY:
					startRace(car);
					break;
				// case GameState.DRIVING:
				// break;
				default:
					drive(car);
					if(_game.state == GameState.DRIVING) checkTrackComplete(car);
					break;
			}
			/*
			this.action = eval(tile.mc.type)(tile,this);
			} else {
			offroad(tile,this);
			}
			this.draw(this.ns,this.ew,this.z);
			this.drawz();
			 */
		}

		/**
		 * checkTrackComplete 
		 * 
		 * @param car 
		 * 
		 * @return 
		 */
		private function checkTrackComplete(car : CarComponent) : void {
			if (car.lap >= _track.laps) {
				
				// TODO: log track time
				
				_game.state = GameState.TRACK_COMPLETE;

				car.winTotal++;
// only use lives if one player?
//				if (car.isCPU) {
					car.opponentCar.lives--;
//				}
				
				_track.winner = car.id;
				//_game.lastWinner = car.id;

				if (car.isCPU && car.opponentCar.lives <= 0) {
					_game.state = GameState.GAME_OVER;
				}
			}
		}

		/**
		 * initCars 
		 * 
		 * @return 
		 */
		private function initCars() : void {
			/**
			 * initialAcceleration 
			 */
			var initialAcceleration : Number = 0.015;

			_carMapper = new ComponentMapper(CarComponent, _world);

			_carOne = _carMapper.get(_world.getTagManager().getEntity(EntityTag.CAR_ONE));
			_carOne.acceleration = initialAcceleration;
			_carOne.accelerateKey = Constants.KEY_PLAYER_ONE;
			_carOne.reverseKey = Keyboard.Z;

			_carTwo = _carMapper.get(_world.getTagManager().getEntity(EntityTag.CAR_TWO));
			_carTwo.acceleration = initialAcceleration;
			_carTwo.accelerateKey = Constants.KEY_PLAYER_TWO;
			_carTwo.reverseKey = Keyboard.M;

			_carOne.opponentCar = _carTwo;
			_carTwo.opponentCar = _carOne;

			switch(_game.type) {
				case GameType.ONE_PLAYER:
					_carOne.isCPU = false;
					_carTwo.isCPU = true;
					break;
				case GameType.TWO_PLAYER:
					_carOne.isCPU = false;
					_carTwo.isCPU = false;
					break;
				case GameType.DEMO:
					_carOne.isCPU = true;
					_carTwo.isCPU = true;
					break;
				default:
			}
		}

		// private function chooseCar() : void {
		// }
		/**
		 * Put cars on startgrid
		 */
		private function startRace(car : CarComponent) : void {
			/**
			 * startGrid 
			 */
			var startGrid : TileComponent = _track.startGrid;
			car.col = startGrid.col + (startGrid.direction == 1 ? car.lane : -car.lane);
			car.row = startGrid.row + (startGrid.direction == 7 ? car.lane : -car.lane);
			// car.x = startGrid.col + car.lane * (startGrid.direction == 1 ? 1 : -1);
			// car.y = startGrid.row + car.lane * (startGrid.direction == 7 ? 1 : -1);
			car.z = 0;
			car.targetTile = startGrid;
			car.reset();
		}

		/**
		 * Drive
		 */
		private function drive(car : CarComponent) : void {
			/**
			 * tile 
			 */
			var tile : TileComponent = _track.getTile(car.row, car.col);
			// if ( car.z < 1 && _track.isDriving && !car.isOffroad) {

			/**
			 * Update speed
			 */
			if ( _game.state == GameState.DRIVING && car.z < 1 && !car.isOffroad) {
				// cpu acceleration
				if (car.isCPU) {
					switch(tile.type) {
						case TileType.CURVE:
						case TileType.RAMP:
						case TileType.OIL:
							car.speed += Math.random() * car.cpuSlowAcceleration;
							break;
						default:
							car.speed += Math.random() * car.cpuAcceleration;
							/**
							 * compensate speed to make a fairer game (straights only)
							 */
							if (car.opponentCar.lap > car.lap) {
								car.speed += car.acceleration * 0.05;
							} else if (car.opponentCar.lap < car.lap) {
								car.speed -= car.acceleration * 0.15;
							}
							break;
					}
					// human acceleration
				} else if (_keyInput.isDown(car.accelerateKey)) {
					car.speed += car.acceleration;
				}
			}
			/**
			 * Adjust speed with traction
			 */
			car.speed *= car.traction;

			// slow down quickly if completed track
			if ( _game.state == GameState.TRACK_COMPLETE ) {
				car.speed *= car.traction;
			}

			// min speed
			if (car.speed < 0) car.speed = 0;

			// FIXME: temp
			if (_keyInput.isDown(car.reverseKey)) {
				car.speed -= car.acceleration;
			}
				

			/**
			 * Set last straight as targte tile when offroad
			 */
			if (tile.type == TileType.STRAIGHT) {
				car.targetTile = tile;
			}
			if (tile.type != TileType.CHANGE_LANE) {
				car.hasSwappedLane = false;
			}
			if (tile.type != TileType.START_GRID) {
				car.lapUpdated = false;
			}

			// TODO: simplify
			if (tile.direction == Direction.NW || tile.direction == Direction.SE) {
//				car.progress = (car.col - tile.col) * (tile.direction == 3 ? -1 : 1);
				car.progress = car.col - tile.col;
				if( tile.direction == Direction.NW) car.progress = -car.progress;
			} else if (tile.direction == Direction.NE || tile.direction == Direction.SW) {
//				car.progress = (car.row - tile.row) * (tile.direction == 1 ? -1 : 1);
				car.progress = car.row - tile.row;
				if( tile.direction == Direction.NE) car.progress = -car.progress;
			}
			//if(car.id == 1 && tile.type == TileType.CURVE)trace('car.progress: ' + (car.progress));
//			is this better?
//			switch(tile.direction){
//				case 3:
//					car.progress = -(car.x - tile.col);
//					break;
//				case 7:
//					car.progress = (car.x - tile.col);
//					break;
//				case 1:
//					car.progress = -(car.y - tile.row);
//					break;
//				case 5:
//					car.progress = (car.y - tile.row);
//					break;
//				default:
//			}

			// var roughdirection : Number = Math.round(car.direction - 1 % 8) + 1;
			/**
			 * carRotation 
			 */
			var carRotation : Number = car.direction * -45;
			// this.mc.body.body._rotation = this.direction*-360/8;
			// this.mc.shadow.body._rotation = this.direction*-360/8;
			car.rotation = carRotation * MathUtils.RAD;

			// collision
			collisionDetect(tile, car);
		}

		/**
		 * collisionDetect 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function collisionDetect(tile : TileComponent, car : CarComponent) : void {
			// not allowing on start grid to avoid a bug where laps getting updated
			if (tile.type != TileType.START_GRID && Math.abs(car.col - car.opponentCar.col) < 0.2 && Math.abs(car.row - car.opponentCar.row) < 0.2 && Math.abs(car.z - car.opponentCar.z) < 0.5 && Math.random() > 0.5) {
				trace("COLLISION!");
				car.isOffroad = true;
				car.direction += 4;
				car.opponentCar.isOffroad = true;
				car.opponentCar.direction += 4;
			}
		}
	}
}
