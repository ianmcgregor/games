package me.ianmcgregor.racer.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.TileComponent;
	import me.ianmcgregor.racer.components.TrackComponent;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.constants.TileConstants;
	import me.ianmcgregor.racer.constants.TileType;
	import me.ianmcgregor.racer.spatials.gfx.BuilderTileGfx;
	import me.ianmcgregor.racer.spatials.gfx.ITileGfx;
	import me.ianmcgregor.racer.spatials.gfx.TileGfx;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;



	/**
	 * @author ianmcgregor
	 */
	public final class TrackSpatial extends Spatial {
		/**
		 * _track 
		 */
		private var _track : TrackComponent;
		/**
		 * _textureAtlas 
		 */
		private var _textureAtlas : TextureAtlas;
		/**
		 * _container 
		 */
		private var _container : Sprite;
		/**
		 * _containerTop 
		 */
		private var _containerTop : Sprite;
		/**
		 * _currentTrack 
		 */
		private var _currentTrack : int;
		
		/**
		 * TODO: handle extra tiles for bridges etc.
		 */
		
		/**
		 * TrackSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function TrackSpatial(world : World, owner : Entity) {
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
			 * trackMapper 
			 */
			var trackMapper : ComponentMapper = new ComponentMapper(TrackComponent, _world);
			_track = trackMapper.get(_owner);
			
//			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
//			var transform: TransformComponent = transformMapper.get(_owner);
			
			_textureAtlas = g.assets.getTextureAtlas("tiles");

			_container = new Sprite();
			_containerTop = new Sprite();
			
			_currentTrack = _track.currentTrack;
		}
		
		/**
		 * Build new track
		 */
		
		/**
		 * build 
		 * 
		 * @return 
		 */
		private function build() : void {
			demolish();
			_currentTrack = _track.currentTrack;
			/**
			 * trackMap 
			 */
			var trackMap: Vector.<Vector.<TileComponent>> = _track.currentTrackMap;
			/**
			 * tile 
			 */
			var tile : TileComponent;
			/**
			 * texture 
			 */
			var texture : Texture;
			/**
			 * tileGfx 
			 */
			var tileGfx : ITileGfx;
			/**
			 * l 
			 */
			var l : int = trackMap.length;
			/**
			 * row 
			 */
			for (var row : int = 0; row < l; ++row) {
				/**
				 * col 
				 */
				for (var col : int = 0; col < l; ++col) {
					tile = trackMap[row][col];
//					trace("TrackSpatial.build(",tile.type, tile.texture, tile.direction, ")");
					// var texture : Texture = getTexture(tile.textureRef);
					texture = _textureAtlas.getTexture(tile.texture);
					tileGfx = getTile(tile, texture);

					_container.addChild(tileGfx as DisplayObject);
					
					// taller objects need to go on a higher layer:
					// could add tracktop spatial or have another container here?
					
					// * bridge top
					// * trees, buildings etc
					
					switch(tile.type){
						case TileType.BRIDGE:
							/**
							 * textureRef 
							 */
							var textureRef : String = ( tile.direction == 1 || tile.direction == 5 ) ? "19_bridge_top" : "18_bridge_top";
							texture = _textureAtlas.getTexture(textureRef);
							tileGfx = new BuilderTileGfx(tile.id, texture, tile, _textureAtlas);
							tileGfx.draw(tile.row, tile.col, tile.z);
							_containerTop.addChild(tileGfx as DisplayObject);
							break;
						default:
					}
				}
			}
			_container.flatten();
			_containerTop.flatten();
		}

		/**
		 * getTile 
		 * 
		 * @param tile 
		 * @param texture 
		 * 
		 * @return 
		 */
		private function getTile(tile : TileComponent, texture : Texture) : ITileGfx {
			/**
			 * tileGfx 
			 */
			var tileGfx : ITileGfx;
//			tileGfx = _track.isBuilder ? new BuilderTileGfx(tile.id, texture, tile) : new TestTileGfx(tile.id, texture, tile);
			tileGfx = _track.isBuilder ? new BuilderTileGfx(tile.id, texture, tile, _textureAtlas) : new TileGfx(tile.id, texture);
			// tileGfx = new TestTileGfx(tile.id, texture, tile);
			tileGfx.draw(tile.row, tile.col, tile.z);
			return tileGfx;
		}
		
		/**
		 * Demolish old track
		 */
		
		/**
		 * demolish 
		 * 
		 * @return 
		 */
		private function demolish() : void {
			_container.unflatten();
			_container.removeChildren();

			_containerTop.unflatten();
			_containerTop.removeChildren();
		}
		
		/**
		 * Render track gfx
		 */

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if(g.state != State.PLAY && g.state != State.BUILD) {
				if (g.contains(_container)) {
					g.removeChild(_container);
				}
				if (g.contains(_containerTop)) {
					g.removeChild(_containerTop);
				}
				return;
			}
			if (_track.currentTrack != _currentTrack || _track.doForcedRebuild) {
				build();
				_track.doForcedRebuild = false;
			}
			
			if(!g.contains(_container))
			{
				
				_container.x = g.getWidth() * 0.5 - TileConstants.TILE_SIZE;
				_container.y = TileConstants.TRACK_OFFSET_Y;
				g.addChild(_container);
				
				_containerTop.x = _container.x;
				_containerTop.y = _container.y;
				g.addChild(_containerTop);
			}
			if(g.getChildIndex(_containerTop) < g.numChildren - 1) {
				g.setChildIndex(_containerTop, g.numChildren - 1);
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
			if(g.contains(_container))
			{
				g.removeChild(_container);
				g.removeChild(_containerTop);
			}
		}
	}
}
