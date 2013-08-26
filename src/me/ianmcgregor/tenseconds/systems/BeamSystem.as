package me.ianmcgregor.tenseconds.systems {
	import me.ianmcgregor.tenseconds.constants.State;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.tenseconds.components.BeamComponent;
	import me.ianmcgregor.tenseconds.constants.Constants;
	import me.ianmcgregor.tenseconds.constants.EntityGroup;

	import nape.geom.Vec2;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import flash.display.Graphics;

	/**
	 * @author ianmcgregor
	 */
	public final class BeamSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _beamMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;
		private var _enemies : IImmutableBag;
		private var _foundAnyAlive : Boolean;

		/**
		 * PlaySystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function BeamSystem(g : GameContainer) {
			super(BeamComponent, null);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_beamMapper = new ComponentMapper(BeamComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
		}
		
		override protected function begin() : void {
			_enemies = _world.getGroupManager().getEntities(EntityGroup.ENEMIES);
			_foundAnyAlive = false;
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var b: BeamComponent = _beamMapper.get(e);
			var h: HealthComponent = _healthMapper.get(e);
			
			if (!h.isAlive()) {
				b.setOn(false);
				b.alive = false;
//				_world.deleteEntity(e);
				return;	
			}
			
			_foundAnyAlive = true;
				
			if(b.getOn()) {
				h.addDamage(_world.getDelta());
				
				var t: TransformComponent = _transformMapper.get(e);
				// get beam vector from rotation
				var beam: Vec2 = Vec2.fromPolar(Constants.BEAM_LENGTH, t.rotation - Math.PI * 0.5);
				// get left normal
				var leftNormal: Vec2 = beam.copy().rotate(Math.PI * -0.5);
				
				var project : Number;
				var collision : Boolean;
				
				var g : Graphics;
//				g = Starling.current.nativeOverlay.graphics;
				if(g) {
					// draw
					g.clear();
					// beam
					g.moveTo(t.x, t.y);
					g.lineStyle(1, 0xFF00FF);
					g.lineTo(t.x + beam.x, t.y + beam.y);
					// left
					g.moveTo(t.x, t.y);
					g.lineStyle(1, 0x00FFFF);
					g.lineTo(t.x + leftNormal.x, t.y + leftNormal.y);
				}
				
				leftNormal.normalise();
				
				if(g) {
					// vector of circle from tower
					var circle:Vec2 = Vec2.get(500 - t.x, 200 - t.y);
					var radius : Number = 20;
					
					// draw
					g.moveTo(t.x, t.y);
					g.lineStyle(1, 0x00FF00);
					g.lineTo(t.x + circle.x, t.y + circle.y);
					
					// perpendicular distance from beam to circle
					// var project : Number = dotProduct(circle, leftNormal);
					project = MathUtils.dotProduct(circle.x, circle.y, leftNormal.x, leftNormal.y);
					collision = MathUtils.abs(project) < radius;
					//	trace('project: ' + (project), 'collision:',(MathUtils.abs(project) < 10));

					// draw circle
					g.beginFill(( collision ? 0xFF0000 : 0x00FF00 ));
					g.drawCircle(500, 200, radius);
					g.endFill();
					
					circle.dispose();
				}
				
				// enemy collisions
				var l: int = _enemies.size();
				for (var i : int = 0; i < l; ++i) {
					var ee: Entity = _enemies.get(i);
					var et: TransformComponent = ee.getComponent(TransformComponent);
					if(et.y < 0) continue;
					if(MathUtils.distance(t.x, t.y, et.x, et.y) > Constants.BEAM_LENGTH + Constants.ENEMY_RADIUS) continue; 
					// perpendicular distance from beam to circle
					project = MathUtils.dotProduct((et.x - t.x), (et.y - t.y), leftNormal.x, leftNormal.y);
					collision = MathUtils.abs(project) < Constants.ENEMY_RADIUS;
					if(collision) {
						HealthComponent(ee.getComponent(HealthComponent)).addDamage(1);
					}
				}
				
				// dispose
				beam.dispose();
				leftNormal.dispose();
			}
		}
		
		override protected function end() : void {
			if(!_foundAnyAlive) {
				_g.state = State.GAME_ENDING;
			}
		}
	}
}
