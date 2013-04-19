package me.ianmcgregor.racer.systems {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.components.GameComponent;
	import me.ianmcgregor.racer.components.HUDComponent;
	import me.ianmcgregor.racer.components.TileComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.Direction;
	import me.ianmcgregor.racer.constants.EntityGroup;
	import me.ianmcgregor.racer.constants.EntityTag;
	import me.ianmcgregor.racer.constants.TileType;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.utils.getTimer;

	/**
	 * @author ianmcgregor
	 */
	public final class TrackSystem extends EntityProcessingSystem {
		private const MIN_SPEED : Number = 0.005;
		private const SENSITIVITY : Number = 0.21;
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * mappers 
		 */
		private var _carMapper : ComponentMapper;
		private var _trackMapper : ComponentMapper;
		private var _hudMapper : ComponentMapper;
		private var _gameMapper : ComponentMapper;
		/**
		 * components 
		 */
		private var _track : TrackComponent;
		private var _hud : HUDComponent;
		private var _game : GameComponent;

		/**
		 * TrackSystem 
		 * 
		 * @param container 
		 * 
		 * @return 
		 */
		public function TrackSystem(container : GameContainer) {
			super(TileComponent, []);
			_container = container;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_carMapper = new ComponentMapper(CarComponent, _world);
			_trackMapper = new ComponentMapper(TrackComponent, _world);
			_hudMapper = new ComponentMapper(HUDComponent, _world);
			_gameMapper = new ComponentMapper(GameComponent, _world);
		}

		/**
		 * processEntities 
		 * 
		 * @param entities 
		 * 
		 * @return 
		 */
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;

			_track = _trackMapper.get(_world.getTagManager().getEntity(EntityTag.TRACK));
			_hud = _hudMapper.get(_world.getTagManager().getEntity(EntityTag.HUD));
			_game = _gameMapper.get(_world.getTagManager().getEntity(EntityTag.GAME));

			/**
			 * cars 
			 */
			var cars : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.CARS);
			for (var i : int = 0; cars.size() > i; ++i) {
				var carEntity : Entity = cars.get(i);
				var car : CarComponent = carEntity.getComponent(CarComponent);
				var tile : TileComponent = _track.getTile(car.row, car.col);
				doAction(tile, car);
				if (car.isOffroad && car.speed <= MIN_SPEED) {
					pickUp(car);
				}
			}
		}

		/**
		 * doAction 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function doAction(tile : TileComponent, car : CarComponent) : void {
			switch(tile.type) {
				case TileType.START_GRID:
					startGrid(tile, car);
					break;
				case TileType.STRAIGHT:
					straight(tile, car);
					break;
				case TileType.CHICANE:
					chicane(tile, car);
					break;
				case TileType.OIL:
					oil(tile, car);
					break;
				case TileType.CURVE:
					curve(tile, car);
					break;
				case TileType.OFF_ROAD:
					offRoad(tile, car);
					break;
				case TileType.CHANGE_LANE:
					changeLane(tile, car);
					break;
				case TileType.RAMP:
					ramp(tile, car);
					break;
				case TileType.BRIDGE:
					bridge(tile, car);
					break;
				case TileType.CROSS_ROADS:
					crossRoads(tile, car);
					break;
				case TileType.OBSTACLE:
					obstacle(tile, car);
					break;
				case TileType.LOW_OBSTACLE:
					lowObstacle(tile, car);
					break;
				default:
			}

			traceLastTile(car, tile);
		}

		/**
		 * For debugging
		 */
		private var _lastTile : String;

		/**
		 * traceLastTile 
		 * 
		 * @param car 
		 * @param tile 
		 * 
		 * @return 
		 */
		private function traceLastTile(car : CarComponent, tile : TileComponent) : void {
			if (car.id == 2 && tile.type != _lastTile) {
				_lastTile = tile.type;
				//trace(_lastTile);
			}
		}

		/**
		 * startGrid 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function startGrid(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.startGrid(", tile, car, ")");
			if (car.z > 0) {
				fall(car);
			} else {
				if (!car.lapUpdated) {
					// TODO: log lap time
					
					/**
					 * time 
					 */
					var time: int = getTimer();
					
					if(car.lap < 0) {
						car.startTime = time;
					}
					
					// TODO: best lap
					/**
					 * lastLapTime 
					 */
					var lastLapTime: Number = car.lapTime;
					car.lapTime = time - car.startTime - lastLapTime;
//					trace(car.id, 'log lap time: ', car.lapTime, car.lap);
					car.lap++;
					car.nextLap++;
					car.lapUpdated = true;
				}
				straight(tile, car);
			}
		}

		/**
		 * straight 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function straight(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.straight(", tile, car, ")");
			if (car.z > 0) {
				fall(car);
			} else {
				car.direction = tile.direction;
				if (tile.direction == Direction.NW || tile.direction == Direction.SE) {
					/**
					 * row 
					 */
					var row: Number = tile.row + (tile.direction == Direction.SE ? car.lane : -car.lane);
					if (MathUtils.abs(row - car.row) < SENSITIVITY) {
						car.col += tile.direction == Direction.NW ? -car.speed : car.speed;
						car.row = row;
					} else {
						offRoad(tile, car);
					}
				} else if (tile.direction == Direction.NE || tile.direction == Direction.SW) {
					/**
					 * col 
					 */
					var col: Number = tile.col + (tile.direction == Direction.NE ? car.lane : -car.lane);
					if (MathUtils.abs(col - car.col) < SENSITIVITY) {
						car.col = col;
						car.row += tile.direction == Direction.NE ? -car.speed : car.speed;
					} else {
						offRoad(tile, car);
					}
				}
			}
		}

		/**
		 * curve 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function curve(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.curve(", tile, car, ")");
			if (car.z > 0) {
				fall(car);
			} else {
//				// calculate change in ns & ew based on a diagonal
				/**
				 * trackoffset 
				 */
				var trackoffset : Number = 0;
				/**
				 * moveSpeed 
				 */
				var moveSpeed : Number = car.speed * .8;
//				var fcX : Number = car.col - (tile.col + tile.cornerB);
//				var fcY : Number = car.row - (tile.row + tile.cornerA);
//				trace('fcX: ' + (fcX), 'fcY: ' + (fcY));
//				
//				var direction : Number = car.progress < 0 ? tile.direction : tile.curveTo;
//				car.direction = direction;
//				
//				//trace('direction: ' + (Direction.getName(direction)));
//					var offset: Number = 0;
//					/* works for car 1 for:
//					*	SE > SW
//					*	SW > NW
//					*	NW > NE
//					*	
//					*	doesn't work for:
//					*	
//					*	NE > NW
//					*	NW > SW
//					*/
//					
//					if(tile.direction == Direction.SE && tile.curveTo == Direction.SW && direction == Direction.SE) offset = car.lane; 
//					if(tile.direction == Direction.SE && tile.curveTo == Direction.SW && direction == Direction.SW) offset = -car.lane; 
//
//					if(tile.direction == Direction.SW && tile.curveTo == Direction.NW && direction == Direction.SW) offset = car.lane; 
//					if(tile.direction == Direction.SW && tile.curveTo == Direction.NW && direction == Direction.NW) offset = -car.lane; 
//
//					if(tile.direction == Direction.NW && tile.curveTo == Direction.NE && direction == Direction.NW) offset = -car.lane; 
//					if(tile.direction == Direction.NW && tile.curveTo == Direction.NE && direction == Direction.NE) offset = car.lane; 
//
//					if(tile.direction == Direction.NE && tile.curveTo == Direction.NW && direction == Direction.NE) offset = -car.lane; 
//					if(tile.direction == Direction.NE && tile.curveTo == Direction.NW && direction == Direction.NW) offset = -car.lane; 
//					
////					if(tile.direction == Direction.SE || tile.direction == Direction.SW || tile.direction == Direction.NW) {
////						offset = direction == Direction.SE || direction == Direction.NE ? car.lane : -car.lane; 
////					}
//				
//				if (direction == Direction.NW || direction == Direction.SE) {
//					var row: Number = tile.row + offset;
//					if (MathUtils.abs(row - car.row) < SENSITIVITY) {
//						car.col += direction == Direction.NW ? -moveSpeed : moveSpeed;
//						car.row = row;
//					} else {
//						offRoad(tile, car);
//					}
//				} else if (direction == Direction.NE || direction == Direction.SW) {
//					
////					if(tile.direction == Direction.SE || tile.direction == Direction.SW || tile.direction == Direction.NW) {
////						offset = direction == Direction.SE ? car.lane : -car.lane; 
////					}
//					
//					
//					var col: Number = tile.col + offset;//(tile.direction == Direction.NE ? car.lane : -car.lane);
////					var col: Number = tile.col + -car.lane;
//					if (MathUtils.abs(col - car.col) < SENSITIVITY) {
//						car.col = col;
//						car.row += direction == Direction.NE ? -moveSpeed : moveSpeed;
//					//	trace('car.row: ' + (car.row), 'tile.row:', tile.row);
//					} else {
//						offRoad(tile, car);
//					}
//				}
//				
//				
//				return;
				
				/**
				 * moveX 
				 */
				var moveX : Number = (tile.direction == Direction.NW || tile.curveTo == 3) ? -moveSpeed : moveSpeed;
				/**
				 * moveY 
				 */
				var moveY : Number = (tile.direction == Direction.NE || tile.curveTo == 1) ? -moveSpeed : moveSpeed;
				// caluclate what this new location is as a vector from the curve corner
				
				
				/**
				 * fcY 
				 */
				var fcY : Number = (car.row + moveY) - (tile.row + tile.cornerA);
				/**
				 * fcX 
				 */
				var fcX : Number = (car.col + moveX) - (tile.col + tile.cornerB);
				
				
				
				// calculate new direction based on change in location
				if (tile.curveTo == 1 || tile.curveTo == 5) {
					
					trackoffset = tile.curveTo == 1 ? car.lane : -car.lane;
					if(tile.direction != Direction.SE) trackoffset *= -1;
					car.direction = MathUtils.abs(fcY) * car.direction + (1 - MathUtils.abs(fcY)) * tile.curveTo;
				
				} else if (tile.curveTo == 3 || tile.curveTo == 7) {
					
					trackoffset = tile.curveTo == 7 ? car.lane : -car.lane;
					if(tile.direction != Direction.SW) trackoffset *= -1;
					car.direction = MathUtils.abs(fcX) * car.direction + (1 - MathUtils.abs(fcX)) * tile.curveTo;
				
				}
				//if(car.id == 1)trace(car.direction);
				//	trace('car.direction: ' + (car.direction));
				// calculate distance of new location from corner
				/**
				 * dist 
				 */
				var dist : Number = Math.sqrt((fcY * fcY) + (fcX * fcX));
				if (dist > (0.5 + trackoffset + SENSITIVITY)) {
					// too far from centre; so we fly off the track
					car.direction = (tile.direction + tile.curveTo) * 0.5;
					car.z = 2;
					car.isOffroad = true;
				} else {
					// normalise dist to 0.375 or 0.625
					/**
					 * tdist 
					 */
					var tdist : Number = 0.5 + trackoffset;
					car.row = tile.row + tile.cornerA + fcY * tdist / dist;
					car.col = tile.col + tile.cornerB + fcX * tdist / dist;
				}
			}
		}
//		private function curve(tile : TileComponent, car : CarComponent) : void {
//			// trace("TileSystem.curve(", tile, car, ")");
//			/*
//			I had an idea for the dodgy curves.  Change the values of 0 to 8, 1 to 9, so that the curve goes 7,8,9 etc.
//			This means changing the code below to "direction % 8" to get the 9s to be 1s again for if statements.
//			Then, the car direction can also be calculated more gently
//			 */
//			if (car.z > 0) {
//				fall(car);
//			} else {
//				// calculate change in ns & ew based on a diagonal
//				var trackoffset : Number = 0;
//				var moveSpeed : Number = car.speed * .8;
//				var moveY : Number = (tile.direction == Direction.NE || tile.curveTo == 1) ? -moveSpeed : moveSpeed;
//				var moveX : Number = (tile.direction == Direction.NW || tile.curveTo == 3) ? -moveSpeed : moveSpeed;
//				// caluclate what this new location is as a vector from the curve corner
//				var fcY : Number = (car.row + moveY) - (tile.row + tile.cornerA);
//				var fcX : Number = (car.col + moveX) - (tile.col + tile.cornerB);
//				// calculate new direction based on change in location
//				if (tile.curveTo == 1 || tile.curveTo == 5) {
//					trackoffset = tile.curveTo == 1 ? car.lane : -car.lane;
//					if(tile.direction != 7) trackoffset *= -1;
//					car.direction = MathUtils.abs(fcY) * car.direction + (1 - MathUtils.abs(fcY)) * tile.curveTo;
//				} else if (tile.curveTo == 3 || tile.curveTo == 7) {
//					trackoffset = tile.curveTo == 7 ? car.lane : -car.lane;
//					if(tile.direction != 5) trackoffset *= -1;
//					car.direction = MathUtils.abs(fcX) * car.direction + (1 - MathUtils.abs(fcX)) * tile.curveTo;
//				}
//				// calculate distance of new location from corner
//				var dist : Number = Math.sqrt((fcY * fcY) + (fcX * fcX));
//				if (dist > (0.5 + trackoffset + SENSITIVITY)) {
//					// too far from centre; so we fly off the track
//					car.direction = (tile.direction + tile.curveTo) * 0.5;
//					car.z = 2;
//					car.isOffroad = true;
//				} else {
//					// normalise dist to 0.375 or 0.625
//					var tdist : Number = 0.5 + trackoffset;
//					car.row = tile.row + tile.cornerA + fcY * tdist / dist;
//					car.col = tile.col + tile.cornerB + fcX * tdist / dist;
//				}
//			}
//		}

		/**
		 * chicane 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function chicane(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.chicane(", tile, car, ")");
			if (car.z > 0) {
				fall(car);
			} else {
				// var prevailing: Number = (1 + (Math.round((car.direction - 1) * 0.5) * 2));
				car.direction = (car.direction + tile.direction + 0.25 * ((car.col > tile.col ? 1 : -1) * (car.row > tile.row ? 1 : -1))) * 0.5;
				if (tile.direction == Direction.NW || tile.direction == Direction.SE) {
					/**
					 * row 
					 */
					var row: Number = tile.row + car.lane * (tile.direction == Direction.SE ? 1 : -1) * (0.4 + MathUtils.abs(car.progress));
					if (MathUtils.abs(row - car.row) < SENSITIVITY) {
						car.col += tile.direction == Direction.NW ? -car.speed : car.speed;
						car.row = row;
					} else {
						offRoad(tile, car);
					}
				} else if (tile.direction == Direction.NE || tile.direction == Direction.SW) {
					/**
					 * col 
					 */
					var col: Number = tile.col + car.lane * (tile.direction == Direction.NE ? 1 : -1) * (0.4 + MathUtils.abs(car.progress));
					if (MathUtils.abs(col - car.col) < SENSITIVITY) {
						car.row += tile.direction == Direction.NE ? -car.speed : car.speed;
						car.col = col;
					} else {
						offRoad(tile, car);
					}
				}
			}
		}

		/**
		 * oil 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function oil(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.oil(", tile, car, ")");
			if (car.z == 0) {
				car.speed *= 1.1;
			}
			crossRoads(tile, car);
		}

		/**
		 * changeLane 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function changeLane(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.changeLane(", tile, car, ")");
			if (car.z > 0) {
				fall(car);
			} else {
				if (!car.hasSwappedLane) {
					car.hasSwappedLane = true;
					car.lane *= -1;
				}
				// var prevailing: Number = (1 + (Math.round((car.direction - 1) * 0.5) * 2));
				car.direction = (car.direction + tile.direction + 0.25 * ((car.col > tile.col ? 1 : -1) * (car.row > tile.row ? 1 : -1))) * 0.5;
				if (tile.direction == Direction.NW || tile.direction == Direction.SE) {
					/**
					 * row 
					 */
					var row: Number = tile.row + (tile.direction == Direction.SE ? car.lane : -car.lane) * (2 * car.progress);
					if (MathUtils.abs(row - car.row) < SENSITIVITY) {
						car.col += tile.direction == Direction.NW ? -car.speed : car.speed;
						car.row = row;
					} else {
						offRoad(tile, car);
					}
				} else if (tile.direction == Direction.NE || tile.direction == Direction.SW) {
					/**
					 * col 
					 */
					var col: Number = tile.col + (tile.direction == Direction.NE ? car.lane : -car.lane) * (2 * car.progress);
					if (MathUtils.abs(col - car.col) < SENSITIVITY) {
						car.row += tile.direction == Direction.NE ? -car.speed : car.speed;
						car.col = col;
					} else {
						offRoad(tile, car);
					}
				}
			}
		}

		/**
		 * ramp 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function ramp(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.ramp(", tile, car, ")");
			/**
			 * groundZ 
			 */
			var groundZ : Number = 0.5 + (tile.climb ? car.progress : -car.progress);
			/**
			 * prevailing 
			 */
			var prevailing : Number = (1 + (Math.round((car.direction - 1) * 0.5) * 2));
			if (prevailing != tile.direction) {
				// crashed into it the wrong way!
				car.direction = (car.direction + 4) % 8;
				car.z = 1;
				car.speed *= 0.5;
				offRoad(tile, car);
			} else {
				if (car.z > groundZ) {
					// above track
					fall(car);
					if (car.z < groundZ) car.z = groundZ;
				} else {
					// on track
					car.direction = tile.direction;
					if (tile.direction == Direction.NW || tile.direction == Direction.SE) {
						/**
						 * row 
						 */
						var row: Number = tile.row + (tile.direction == Direction.SE ? car.lane : -car.lane);
						if (MathUtils.abs(row - car.row) < SENSITIVITY) {
							car.col += tile.direction == Direction.NW ? -car.speed : car.speed;
							car.row = row;
						} else {
							offRoad(tile, car);
						}
					} else if (tile.direction == Direction.NE || tile.direction == Direction.SW) {
						/**
						 * col 
						 */
						var col: Number = tile.col + (tile.direction == Direction.NE ? car.lane : -car.lane);
						if (MathUtils.abs(col - car.col) < SENSITIVITY) {
							car.row += tile.direction == Direction.NE ? -car.speed : car.speed;
							car.col = col;
						} else {
							offRoad(tile, car);
						}
					}
					car.z = groundZ;
					car.zSpeed = car.speed;
					car.zAcceleration = 0.01;
				}
			}
		}

		/**
		 * bridge 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function bridge(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.bridge(", tile, car, ")");
			if (car.z >= 0.5) {
				// top part
				/**
				 * groundZ 
				 */
				var groundZ : Number = 1.5 - MathUtils.abs(car.progress);
				if (car.z > groundZ) {
					fall(car);
					car.z = Math.max(groundZ, car.z);
				} else {
					car.z = groundZ;
					car.zAcceleration = 0;
					if (tile.direction == Direction.NW || tile.direction == Direction.SE) {
						/**
						 * row 
						 */
						var row: Number = tile.row + (tile.direction == Direction.SE ? car.lane : -car.lane);
						if (MathUtils.abs(row - car.row) < SENSITIVITY) {
							car.col += tile.direction == Direction.NW ? -car.speed : car.speed;
							car.row = row;
						} else {
							offRoad(tile, car);
						}
					} else if (tile.direction == Direction.NE || tile.direction == Direction.SW) {
						/**
						 * col 
						 */
						var col: Number = tile.col + (tile.direction == Direction.NE ? car.lane : -car.lane);
						if (MathUtils.abs(col - car.col) < SENSITIVITY) {
							car.row += tile.direction == Direction.NE ? -car.speed : car.speed;
							car.col = col;
						} else {
							offRoad(tile, car);
						}
					}
				}
				car.direction = tile.direction;
			} else {
				// bottom part
				car.z = 0;
				crossRoads(tile, car);
			}
		}

		/**
		 * crossRoads 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function crossRoads(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.crossRoads(", tile, car, ")");
			if (car.z > 1) {
				fall(car);
			} else {
				/**
				 * prevailing 
				 */
				var prevailing : Number = (1 + (Math.round((car.direction - 1) * 0.5) * 2));
				car.direction = prevailing;
				if (prevailing == 3 || prevailing == 7) {
					car.col += prevailing == 3 ? -car.speed : car.speed;
					car.row = tile.row + (prevailing == 7 ? car.lane : -car.lane);
				} else if (prevailing == 1 || prevailing == 5) {
					car.row += prevailing == 1 ? -car.speed : car.speed;
					car.col = tile.col + (prevailing == 1 ? car.lane : -car.lane);
				}
			}
		}

		/**
		 * offRoad 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function offRoad(tile : TileComponent, car : CarComponent) : void {
			// trace("TileSystem.offRoad(", tile, car, ")");
			tile;
			car.isOffroad = true;
			fall(car);
			if (car.speed <= MIN_SPEED) {
				pickUp(car);
			}
		}

		/**
		 * lowObstacle 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function lowObstacle(tile : TileComponent, car : CarComponent) : void {
			tile;
			// trace("TileSystem.lowObstacle(", tile, car, ")");
			if (car.z > 0.5) {
				fall(car);
			} else {
				car.isOffroad = true;
				car.direction += 2;
				fall(car);
				if (car.speed <= MIN_SPEED) {
					pickUp(car);
				}
			}
		}

		/**
		 * obstacle 
		 * 
		 * @param tile 
		 * @param car 
		 * 
		 * @return 
		 */
		private function obstacle(tile : TileComponent, car : CarComponent) : void {
			tile;
			// trace("TileSystem.obstacle(", tile, car, ")");
			car.isOffroad = true;
			car.direction += 2 * (MathUtils.coinToss() ? 1 : -1);
			fall(car);
			if (car.speed <= MIN_SPEED) {
				pickUp(car);
			}
		}

		/**
		 * fall 
		 * 
		 * @param car 
		 * 
		 * @return 
		 */
		private function fall(car : CarComponent) : void {
			car.row += car.speed * Math.cos(Math.PI * ((car.direction + 3) * 0.25));
			car.col += car.speed * Math.sin(Math.PI * ((car.direction + 3) * 0.25));
			car.zSpeed += car.zAcceleration;
			car.z += car.zSpeed;
			if (car.z < 0) car.z = 0;
			if (car.z > 0) {
				car.zAcceleration -= 0.01;
			} else {
				car.zAcceleration = 0;
			}
		}
		/**
		 * Put car back on track after crash - TODO: don't put on top of other car!
		 */
		private function pickUp(car : CarComponent) : void {
			if (!car.targetTile) return;
			
			//  don't put on top of other car!
			if(car.targetTile == car.opponentCar.targetTile && car.lane == car.opponentCar.lane) {
				car.lane = -car.opponentCar.lane;
			}
			
			car.col = car.targetTile.col + (car.targetTile.direction == 1 ? car.lane : -car.lane);
			car.row = car.targetTile.row + (car.targetTile.direction == 7 ? car.lane : -car.lane);
			car.z = 0;
			car.isOffroad = false;
		}
	}
}
