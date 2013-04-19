package me.ianmcgregor.rogue.systems {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.astar.AStar;
	import me.ianmcgregor.games.utils.astar.GridOverlay;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.games.utils.raycast.RayCaster;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.components.MonsterComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.constants.EntityTag;
	import me.ianmcgregor.rogue.factories.EntityFactory;

	import starling.core.Starling;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntityProcessingSystem;

	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;

	/**
	 * @author ianmcgregor
	 */
	public final class MonsterAISystem extends IntervalEntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _monsterMapper : ComponentMapper;
		/**
		 * _transformMapper 
		 */
		private var _transformMapper : ComponentMapper;
		/**
		 * path finding
		 */
		private var _aStar : AStar;
		private var _rayCast : RayCaster;
		private const _rayPoint : Point = new Point();
		/**
		 * debug - show rays and paths
		 */
		private var _debug : Boolean = false;
		private var _timeNow : Number;

		/**
		 * MonsterSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function MonsterAISystem(g : GameContainer) {
			super(0.5, MonsterComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_monsterMapper = new ComponentMapper(MonsterComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_aStar = new AStar();
			_rayCast = new RayCaster();
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
//			var transform: TransformComponent = _transformMapper.get(e);
//			var monster: MonsterComponent = _monsterMapper.get(e);
//			trace('_world.getTagManager().getEntity(EntityTag.LEVEL): ' + (_world.getTagManager().getEntity(EntityTag.LEVEL)));
			//findPath(transform, monster);

			
//			var success: Boolean = rayCast(e, transform, monster, 80, 50);
//			if(success) {
//				findPath(e, transform, monster, toX, toY);
//			}
		}

		private function rayCast(e : Entity, transform : TransformComponent, monster : MonsterComponent, toX: Number, toY: Number) : Boolean {
			monster;
			var success: Boolean;
			var level : LevelComponent = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
			var ray : Point = _rayCast.castRay(level.current.nodes, transform.x, transform.y, toX, toY, Constants.TILE_SIZE, _rayPoint);
//			trace("RAY:", ray.x, ray.y, "player:", toX, toY);

			var dist: Number = MathUtils.distance(ray.x, ray.y, toX, toY);
//			trace('dist: ' + (dist));
//			if (ray.x == toX && ray.y == toY) {
			if (dist < 10) {
				success = true;
//				findPath(e, transform, monster, toX, toY);
			}

			if (_debug) {
				var s : Shape = new Shape();
				var g: Graphics = s.graphics;
				s.name = String(e.getId()) + "ray";
				g.lineStyle(4, 0xFF0000, 0.6);
				g.moveTo(transform.x + Constants.TILE_SIZE * 0.5, transform.y + Constants.TILE_SIZE * 0.5);
				g.lineTo(ray.x, ray.y);
				var child : DisplayObject = Starling.current.nativeStage.getChildByName(s.name);
				if (child) {
					Starling.current.nativeStage.removeChild(child);
				}
				Starling.current.nativeStage.addChild(s);
			}
			return success;
		}
		
		/**
		 * findPath 
		 * 
		 * @param transform
		 * @param monster
		 * 
		 * @return 
		 */
		private function findPath(e: Entity, transform : TransformComponent, monster : MonsterComponent, toX: Number, toY: Number) : void {
			var level : LevelComponent = _world.getTagManager().getEntity(EntityTag.LEVEL).getComponent(LevelComponent);
			var x : int = level.getGridColumn(transform.x);
			var y : int = level.getGridRow(transform.y);
			var xTile : int = int(toX / Constants.TILE_SIZE);
			var yTile : int = int(toY/Constants.TILE_SIZE);	
			if (xTile >= level.current.nodes.numCols || yTile >= level.current.nodes.numRows) {
				return;
			}
			level.current.nodes.setStartNode(x, y);
			level.current.nodes.setEndNode(xTile, yTile);
			if (_aStar.findPath(level.current.nodes, monster.getPath())) {
//				trace('_aStar.path: ' + (_aStar.path));
				monster.setPath(_aStar.path);
				
				if(_debug) {
					var s: GridOverlay = new GridOverlay(level.current.nodes);
					s.setPath(_aStar);
					s.name = String(e.getId()) + "path";
					var child : DisplayObject = Starling.current.nativeStage.getChildByName(s.name);
					if (child) {
						Starling.current.nativeStage.removeChild(child);
					}
					Starling.current.nativeStage.addChild(s);
				}
			}
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
			/**
			 * components
			 */
			var m: MonsterComponent = _monsterMapper.get(e);
			var mT: TransformComponent = _transformMapper.get(e);
			var w: WeaponComponent = e.getComponent(WeaponComponent);
			
			// TODO: if monster already has a good path don't change it
			// FIXME: what does this do to shooting?
			
			var p: Entity = _world.getTagManager().getEntity(EntityTag.PLAYER_1);
			var pT: TransformComponent = p.getComponent(TransformComponent);
			var success: Boolean = rayCast(e, mT, m, pT.x, pT.y);
			
			if(success) {
				if(!m.getPath() || m.pathIndex >= m.getPath().length - 1) {
					findPath(e, mT, m, pT.x, pT.y);
				}
				shoot(w, pT, mT);
			} else {
				p = _world.getTagManager().getEntity(EntityTag.PLAYER_2);
				if(p) {
					pT = p.getComponent(TransformComponent);
					success = rayCast(e, mT, m, pT.x, pT.y);
					if(success) {
						if(!m.getPath() || m.pathIndex >= m.getPath().length - 1) {
							findPath(e, mT, m, pT.x, pT.y);
						}
						shoot(w, pT, mT);
					}
				}
			}
			
			
		}
		
		/**
		 * shoot
		 * 
		 * @param w
		 * @param pT
		 * @param mT
		 * 
		 * @return
		 */
		private function shoot(w: WeaponComponent, pT: TransformComponent, mT: TransformComponent) : void {
			if(w && w.getShotAt() < _timeNow - 2) {
				EntityFactory.createMonsterBullet(_world, mT.x + Constants.HALF_TILE_SIZE, mT.y + Constants.HALF_TILE_SIZE, (pT.x - mT.x) * 0.2, (pT.y - mT.y) * 0.2);
				w.setShotAt(_timeNow);
			}
		}
	}
}
