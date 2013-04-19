package me.ianmcgregor.rogue.spatials {
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;
	import me.ianmcgregor.rogue.components.LevelComponent;
	import me.ianmcgregor.rogue.constants.Constants;

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
			
			/**
			 * level
			 */
			var atlas : TextureAtlas;
			atlas = g.assets.getTextureAtlas(Constants.TILE_ATLAS);
//			var textures: Vector.<Texture> = atlas.getTextures();
			var names: Vector.<String> = atlas.getNames();
//			trace('names: ' + (names));
			var tileGfx : DisplayObject;
			const tileSize: Number = Constants.TILE_SIZE;
			var currentLevel: OgmoLevel = _level.current;
			var grid: Vector.<Vector.<uint>> = currentLevel.tiles;
			var l: int = grid.length;
			for (var i : int = 0; i < l; ++i) {
				var len: int = grid[i].length;
				for (var j : int = 0; j < len; ++j) {
					// var texture : String = grid[i][j] == 0 ? Constants.TEXTURE_GROUND : Constants.TEXTURE_WALL;
					var index : uint = grid[i][j];
					if( index < names.length ) {
						var texture : String = names[index];
	//					trace('grid[i][j]: ' + (grid[i][j]));
	//					_gfx.addChild(tileGfx = new TextureSelectGfx(atlas, texture));
						_gfx.addChild(tileGfx = new Image(atlas.getTexture(texture)));
						tileGfx.x = j * tileSize;
						tileGfx.y = i * tileSize;
					}
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
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;
			
//			g.x = ( g.getWidth() - _gfx.width ) * 0.5;
//			g.y = ( g.getHeight() - _gfx.height ) * 0.5;
			
//			Logger.log("NullSpatial.render()", 2, 3);
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
