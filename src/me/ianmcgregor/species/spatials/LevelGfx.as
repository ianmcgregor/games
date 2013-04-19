package me.ianmcgregor.species.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.species.assets.Assets;
	import me.ianmcgregor.species.components.Level;

	import starling.display.Image;
	import starling.display.Sprite;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public class LevelGfx extends Spatial {
		
//		private var _textureAtlas : TextureAtlas;
		/**
		 * _container 
		 */
		private var _container: Sprite;
		/**
		 * _tiles 
		 */
		private var _tiles : Array;
		/**
		 * _level 
		 */
		private var _level : Level;
		
		/**
		 * LevelGfx 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function LevelGfx(world : World, owner : Entity) {
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
			 * levelMapper 
			 */
			var levelMapper : ComponentMapper = new ComponentMapper(Level, _world);
			_level = levelMapper.get(_owner);
			_tiles = Assets.tiles;
			_container = new Sprite();
			
			/**
			 * map 
			 */
			var map: Array = _level.map;
			/**
			 * l 
			 */
			var l: int = map.length;
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				var row: Array = map[i];
				var len: int = row.length;
				for (var j : int = 0; j < len; ++j) {
					var index: int = row[j];
					var tile : Image = new Image(_tiles[index]);
					tile.x = j * 16;
					tile.y = i * 16;
//					trace('tile.x: ' + (tile.x),'tile.y: ' + (tile.y));
					_container.addChild(tile);
				}
			}
			
			_container.flatten();
			
			// 40 / 30
//			var spriteSheet : Texture = Texture.fromBitmap(new Assets.SpriteSheet());
//			var xml:XML = XML(new Assets.SpriteSheetXML());
//
//			_textureAtlas = new TextureAtlas(spriteSheet, xml);
			
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if(!g.contains(_container)){
				g.addChildAt(_container, 0);
			}
		}

		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if(g.contains(_container)){
				g.removeChild(_container);
			}
		}
	}
}
