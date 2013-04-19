package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.ExpiresComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.rogue.components.MessageComponent;
	import me.ianmcgregor.rogue.constants.Constants;
	import me.ianmcgregor.rogue.spatials.gfx.MessageGfx;

	import starling.display.Sprite;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class MessageSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		private var _expires : ExpiresComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		
		/**
		 * MessageSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function MessageSpatial(world : World, owner : Entity) {
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
			
			var messageMapper: ComponentMapper = new ComponentMapper(MessageComponent, _world);
			var message: MessageComponent = messageMapper.get(_owner);
			
			var expiresMapper: ComponentMapper = new ComponentMapper(ExpiresComponent, _world);
			_expires = expiresMapper.get(_owner);
			
			g.addChild(_gfx = new MessageGfx(message.text));
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
			_gfx.x = _transform.x + ( Constants.TILE_SIZE - _gfx.width ) * 0.5;
			_gfx.y = _transform.y - _gfx.height;
			
			var alpha: Number = _expires.getLifeTime() / 1;
			if(alpha > 1) alpha = 1;
			if(alpha < 0) alpha = 0;
			_gfx.alpha = alpha;
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
