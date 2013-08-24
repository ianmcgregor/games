package me.ianmcgregor.drive.spatials {
	import me.ianmcgregor.drive.components.LevelComponent;
	import me.ianmcgregor.drive.constants.Constants;
	import me.ianmcgregor.drive.factories.EntityFactory;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.ogmo.OgmoEntity;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public final class LevelSpatial extends Spatial {
		/**
		 * _transform 
		 */
		private var _transform : TransformComponent;
		private var _level : LevelComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		
		/**
		 * LevelSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function LevelSpatial(world : World, owner : Entity) {
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
			trace("LevelSpatial.initalize()");
			/**
			 * mappers 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);

			var levelMapper : ComponentMapper = new ComponentMapper(LevelComponent, _world);
			_level = levelMapper.get(_owner);
			
			/**
			 * _gfx
			 */
			g.addChildAt(_gfx = new Sprite(), 0);
			_gfx.name = 'LevelGfx';
			/**
			 * level
			 */
			
			// get level entities
			var atlas : TextureAtlas = g.assets.getTextureAtlas(Constants.SPRITES);
			var tileGfx : DisplayObject;
			var entities : Vector.<OgmoEntity> = _level.current.entities2.getAll();
			var l : uint = entities.length;
			for (var i : uint = 0; i < l; ++i) {
				var o : OgmoEntity = entities[i];
				var type : String = entities[i].type;
//				trace('type: ' + (type));
				switch(type) {
					case Constants.ROAD_STRAIGHT:
					case Constants.ROAD_CURVE_LEFT:
					case Constants.ROAD_CURVE_RIGHT:
					case Constants.ROAD_SPLIT_START:
					case Constants.ROAD_SPLIT:
					case Constants.ROAD_SPLIT_END:
					case Constants.ROAD_BRIDGE:
					case Constants.OFFROAD:
						EntityFactory.createRoad(_world, o.x, o.y, o.width, o.height, type);
						_gfx.addChild(tileGfx = new Image(atlas.getTexture(type)));
//						tileGfx.scaleX = tileGfx.scaleY = 2;
						tileGfx.x = int(o.x);
						tileGfx.y = int(o.y);
						break;
				}
			}
			_gfx.flatten();
			_gfx.touchable = false;
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
			_gfx.x = _transform.x + _gfx.pivotX - g.camera.x;
			_gfx.y = _transform.y + _gfx.pivotY - g.camera.y;
			_gfx.rotation = _transform.rotation;
//			trace('LevelSpatial.render: ', _gfx.x, _gfx.y, _gfx.width, _gfx.height);
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
