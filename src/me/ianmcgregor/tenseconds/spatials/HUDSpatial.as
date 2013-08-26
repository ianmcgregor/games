package me.ianmcgregor.tenseconds.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.string.StringUtils;
	import me.ianmcgregor.tenseconds.components.HUDComponent;
	import me.ianmcgregor.tenseconds.constants.Constants;

	import starling.text.TextField;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSpatial extends Spatial {
		/**
		 * components 
		 */
		private var _transform : TransformComponent;
		/**
		 * _hudComponent 
		 */
		private var _hudComponent : HUDComponent;
		/**
		 * _gfx 
		 */
		private var _killsText : TextField;
		private var _kills : int;
		private var _hits : int;
		private var _hitsText : TextField;
		
		
		/**
		 * HUDSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function HUDSpatial(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g : GameContainer) : void {
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);
			/**
			 * titlesMapper 
			 */
			var hudMapper : ComponentMapper = new ComponentMapper(HUDComponent, _world);
			_hudComponent = hudMapper.get(_owner);
			/**
			 * _gfx
			 */
			_killsText = new TextField(60, 10, "", Constants.FONT, -1, 0xFFFFFF);
			_killsText.hAlign = 'left';
			_killsText.scaleX = _killsText.scaleY = 2;
			_killsText.x = _transform.x;
			_killsText.y = _transform.y;
			setKillsText();
			g.addChild(_killsText);
			
			_hitsText = new TextField(60, 10, "", Constants.FONT, -1, 0xFFFFFF);
			_hitsText.hAlign = 'left';
			_hitsText.scaleX = _hitsText.scaleY = 2;
			_hitsText.x = g.getWidth() - _hitsText.width;// - _transform.x;
			_hitsText.y = _transform.y;
			setHitsText();
			g.addChild(_hitsText);
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			g;
			
			var kills: int = _hudComponent.kills;
			var hits: int = _hudComponent.hits;
			
			if(_kills != kills) {
				_kills = kills;
				setKillsText();
			}
			
			if(_hits != hits) {
				_hits = hits;
				setHitsText();				
			}
		}
		
		private function setKillsText() : void {
			_killsText.text = "KILLS: " + StringUtils.padLeft(String(_kills), "0", 4);
		}
		
		private function setHitsText() : void {
			_hitsText.text = "HITS: " + StringUtils.padLeft(String(_hits), "0", 4);
		}
		
		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if(g.contains(_killsText)) {
				g.removeChild(_killsText);
			}
			if(g.contains(_hitsText)) {
				g.removeChild(_hitsText);
			}
		}
	}
}
