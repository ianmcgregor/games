package me.ianmcgregor.fight.systems {
	import me.ianmcgregor.fight.components.BadGuyComponent;
	import me.ianmcgregor.fight.components.HUDComponent;
	import me.ianmcgregor.fight.components.PlayerComponent;
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.EntityTag;
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.base.GameContainer;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * mappers 
		 */
		private var _hudMapper : ComponentMapper;
		private var _hudComponent : HUDComponent;
		private var _healthMapper : ComponentMapper;
		private var _playerMapper : ComponentMapper;

		/**
		 * SoundSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function HUDSystem(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_hudMapper = new ComponentMapper(HUDComponent, _world);
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
			_healthMapper = new ComponentMapper(HealthComponent, _world);
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
			_hudComponent = _hudMapper.get(_world.getTagManager().getEntity(EntityTag.HUD));
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			var p: PlayerComponent = _playerMapper.get(e);
			var h: HealthComponent = _healthMapper.get(e);
			_hudComponent.player[p.playerNum].health = h.getHealthPercentage();
			_hudComponent.player[p.playerNum].score = p.score;
			
			if(p.opponent) {
				h = _healthMapper.get(p.opponent);
				_hudComponent.badGuy[p.playerNum].health = h.getHealthPercentage();
				_hudComponent.badGuy[p.playerNum].active = true;
				var b: BadGuyComponent = p.opponent.getComponent(BadGuyComponent);
				var name: String;
				switch(b.type){
					case Constants.BAD_GUY_1:
						name = "VILLAIN";
						break;
					case Constants.BAD_GUY_2:
						name = "BAG EGG";
						break;
					case Constants.BAD_GUY_3:
						name = "CRIMINAL";
						break;
					default:
				}
				_hudComponent.badGuy[p.playerNum].name = name;
//				trace('_hudComponent.badGuy.health: ' + (_hudComponent.badGuy.health));
			} else {
				_hudComponent.badGuy[p.playerNum].health = 0;
				_hudComponent.badGuy[p.playerNum].active = false;
			}
		}
	}
}