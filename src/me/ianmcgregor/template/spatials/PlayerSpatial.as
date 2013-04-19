package me.ianmcgregor.template.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.template.components.PlayerComponent;
	import me.ianmcgregor.template.spatials.gfx.PlayerGfx;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : PlayerGfx;
		/*
		 * components
		 */
		private var _transform : TransformComponent;
		private var _player : PlayerComponent;
		
		/**
		 * HeroSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function PlayerSpatial(world : World, owner : Entity) {
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
			 * mappers 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			var playerMapper : ComponentMapper = new ComponentMapper(PlayerComponent, _world);
			_player = playerMapper.get(_owner);
			
			/**
			 * gfx
			 */
			g.addChild(_gfx = new PlayerGfx(_player.playerNum));
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
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;
			_gfx.rotation = _transform.rotation;
		}

		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
