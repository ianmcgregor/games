package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.components.HealthComponent;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public class HealthBarGfx extends Spatial {
		
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		/**
		 * _health 
		 */
		private var _health : HealthComponent;
		/**
		 * _container 
		 */
		private var _container : Sprite;
		/**
		 * _bg 
		 */
		private var _bg : Quad;
		/**
		 * _bar 
		 */
		private var _bar : Quad;
		
		/**
		 * HealthBarGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function HealthBarGfx(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g: GameContainer) : void {
			g;
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);
			
			/**
			 * healthMapper 
			 */
			var healthMapper : ComponentMapper = new ComponentMapper(HealthComponent, _world);
			_health = healthMapper.get(_owner);
			
			_container = new Sprite();
			
			_container.addChild( new TextField(35, 10, "HEALTH", BitmapFont.MINI, BitmapFont.NATIVE_SIZE, 0xFFFFFF, true) );
			
			_bg = new Quad(200, 10);
			_bg.color = 0x333333;
			_bg.x = 37;
			_container.addChild(_bg);
			
			_bar = new Quad(198, 8);
			_bar.color = 0x00ff00;
			_bar.x = _bg.x + 1;
			_bar.y = _bg.y + 1;
			_container.addChild(_bar);
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			/**
			 * x 
			 */
			var x : Number = _transform.x;
			/**
			 * y 
			 */
			var y : Number = _transform.y;
			_container.x = x;
			_container.y = y;
			if (!g.contains(_container)) {
				g.addChild(_container);
			}
			
//			_bar.scaleX = Utils.lerp(_bar.scaleX, _health.getHealthPercentage(), 0.1);
			_bar.scaleX = _health.getHealthPercentage();
			
			if(_bar.scaleX < 0.5) _bar.color = 0xffff00;
			if(_bar.scaleX < 0.2) _bar.color = 0xff0000;
		}
	}
}
