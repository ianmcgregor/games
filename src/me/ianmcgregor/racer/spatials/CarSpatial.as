package me.ianmcgregor.racer.spatials {
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.CarComponent;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.constants.TileConstants;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class CarSpatial extends Spatial {
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		/**
		 * _car 
		 */
		private var _car : CarComponent;
		/**
		 * _image 
		 */
		private var _image : Vector.<Image>;

		/**
		 * CarSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function CarSpatial(world : World, owner : Entity) {
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
			g;
			/**
			 * carMapper 
			 */
			var carMapper : ComponentMapper = new ComponentMapper(CarComponent, _world);
			_car = carMapper.get(_owner);

			_gfx = new Sprite();
			_gfx.touchable = false;

			/**
			 * textures 
			 */
			_image = new Vector.<Image>();
//			initTextures(g);
			
//			return;
//			
//			_gfx.removeChildren();
//			/**
//			 * dot 
//			 */
//			var dot : Quad = new Quad(4, 4);
//			dot.x = dot.y = -2;
//			dot.color = 0x00FFFF;
//			_gfx.addChild(dot);
		}
		
		/**
		 * initTextures once game has been set up - TODO: could resuse Image instances and just change texture
		 */

		private function initTextures(g : GameContainer) : void {
			_image.fixed = false;
			_image.length = 0;
			
			var textureAtlas : TextureAtlas = g.assets.getTextureAtlas("cars");
			var texture : Texture;
			var image : Image;
			var l : int = 5;
			for (var i : int = 1; i < l; ++i) {
				var textureRef : String = "car" + _car.texture + "_" + i;
				texture = textureAtlas.getTexture(textureRef);
				trace('textureRef: ' + (textureRef));
				// trace('textureRef: ' + (textureRef));
				image = new Image(texture);
				_gfx.addChild(image);
				image.visible = false;
				image.x = 0 - image.width * 0.5 - 5;
				image.y = 0 - image.height * 0.5 - 5;
				_image[_image.length] = image;
			}

			_image.fixed = true;
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if(g.state != State.PLAY) {
				if (g.contains(_gfx)) {
					g.removeChild(_gfx);
				}
				return;
			}
			if (!g.contains(_gfx)) {
				initTextures(g);
				g.addChild(_gfx);
			}
			
			_gfx.x = g.x + g.getWidth() * 0.5 + translateX(_car.row, _car.col);
			_gfx.y = TileConstants.TRACK_OFFSET_Y + TileConstants.TILE_SIZE * 1.25 + translateY(_car.row, _car.col, _car.z);

			/**
			 * direction 
			 */
			var direction : Number = Math.round(_car.direction);
			switch(direction) {
				case 5:
					changeImage(2);
					break;
				case 3:
					changeImage(0);
					break;
				case 1:
					changeImage(3);
					break;
				case 7:
					changeImage(1);
					break;
				default:
//					trace('_car.direction: ' + (_car.direction));
			}
			
			// if off the ground go on top of higher objects - will be reset automatically in TrackSpatial
			if(_car.z > 0) {
				g.setChildIndex(_gfx, g.numChildren - 1);
			}
			
//			trace(_car.id, 'direction: ' + (_car.direction), 'row: ' + (_car.row), 'col: ' + (_car.col), 'lane: ' + (_car.lane));
			
			// car z sorting
			if(_car.direction == 1 && _car.lane > 0) {
				g.setChildIndex(_gfx, g.numChildren - 1);
			} else if(_car.direction == 7 && _car.lane > 0) {
				g.setChildIndex(_gfx, g.numChildren - 1);
			} else if(_car.direction == 5 && _car.lane < 0) {
				g.setChildIndex(_gfx, g.numChildren - 1);
			} else if(_car.direction == 3 && _car.lane < 0) {
				g.setChildIndex(_gfx, g.numChildren - 1);
			}
		}

		/**
		 * changeImage 
		 * 
		 * @param index 
		 * 
		 * @return 
		 */
		private function changeImage(index : int) : void {
			/**
			 * i 
			 */
			var i : int = _image.length;
			while (--i > -1) {
				_image[i].visible = false;
			}
			_image[index].visible = true;
		}

		/**
		 * translateX 
		 * 
		 * @param row 
		 * @param col 
		 * 
		 * @return 
		 */
		private function translateX(row : Number, col : Number) : Number {
			// trace("CarSpatial.ttx(",y, x,")");
			return col * TileConstants.TILE_SIZE - row * TileConstants.TILE_SIZE;
		}

		/**
		 * translateY 
		 * 
		 * @param row 
		 * @param col 
		 * @param z 
		 * 
		 * @return 
		 */
		private function translateY(row : Number, col : Number, z : Number) : Number {
			// trace("CarSpatial.tty(",y, x, z,")");
			return (col * TileConstants.TILE_SIZE * 0.5) + (row * TileConstants.TILE_SIZE * 0.5) - (z * TileConstants.TILE_SIZE * 0.25);
		}

		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
		}
	}
}
